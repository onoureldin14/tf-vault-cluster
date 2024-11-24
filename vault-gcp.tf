resource "google_service_account" "vault" {
  count        = var.vault_cluster_gcp == true ? 1 : 0
  project      = var.google_project_id
  account_id   = var.vault_service_account_id
  display_name = "Vault Service Account for KMS auto-unseal"
}

resource "google_storage_bucket" "vault" {
  count         = var.vault_cluster_gcp == true ? 1 : 0
  name          = local.vault_storage_bucket_name
  location      = var.google_region
  project       = var.google_project_id
  force_destroy = true
}

resource "google_storage_bucket_iam_member" "member" {
  count  = var.vault_cluster_gcp == true ? 1 : 0
  bucket = google_storage_bucket.vault[0].name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${google_service_account.vault[0].email}"
}

resource "google_kms_key_ring" "vault" {
  count    = var.vault_cluster_gcp == true ? 1 : 0
  name     = local.vault_kms_keyring_name
  project  = var.google_project_id
  location = var.google_region
}

resource "google_kms_crypto_key" "vault" {
  count           = var.vault_cluster_gcp == true ? 1 : 0
  name            = local.vault_crypto_key_name
  key_ring        = google_kms_key_ring.vault[0].id
  rotation_period = var.vault_kms_key_rotation

  version_template {
    algorithm        = var.vault_kms_key_algorithm
    protection_level = var.vault_kms_key_protection_level
  }
}

resource "google_kms_key_ring_iam_member" "vault" {
  count       = var.vault_cluster_gcp == true ? 1 : 0
  key_ring_id = google_kms_key_ring.vault[0].id
  role        = "roles/owner"
  member      = "serviceAccount:${google_service_account.vault[0].email}"
}

resource "time_sleep" "wait_for_kms_and_bucket" {
  count           = var.initial_terraform_run && var.vault_cluster_gcp ? 1 : 0
  create_duration = "180s" # Wait for 3 minutes for crypto key to become enabled...
}

resource "google_cloud_run_service" "default" {
  count                      = var.vault_cluster_gcp == true ? 1 : 0
  name                       = var.name
  project                    = var.google_project_id
  location                   = var.google_region
  autogenerate_revision_name = true

  metadata {
    namespace = var.google_project_id
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  template {
    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale" = 1
        "run.googleapis.com/sandbox"       = "gvisor"
      }
    }

    spec {
      service_account_name = google_service_account.vault[0].email

      container_concurrency = var.container_concurrency
      containers {
        image = local.vault_image

        command = var.initial_terraform_run ? null : ["/usr/local/bin/docker-entrypoint.sh"] # Do not use the command and args field for the initial run.
        args    = var.initial_terraform_run ? null : ["server"]                              # Do not use the args field for the initial run.

        ports {
          name           = "http1"
          container_port = 8080
        }
        startup_probe {
          http_get {
            path = "/v1/sys/health?standbyok=true"
            port = 8080
          }

          initial_delay_seconds = var.initial_terraform_run ? 240 : 5 # Keep the initial delay for the first terraform run to 240 seconds. Decrease to 5 seconds for subsequent runs.
          period_seconds        = 5
          failure_threshold     = 2
          timeout_seconds       = 3
        }

        env {
          name  = "SKIP_SETCAP"
          value = "true"
        }

        env {
          name  = "VAULT_LOCAL_CONFIG"
          value = local.vault_config
        }

        resources {
          limits = {
            "cpu"    = "1000m"
            "memory" = "512Mi"
          }
          requests = {}
        }
      }
    }
  }
  depends_on = [time_sleep.wait_for_kms_and_bucket, google_storage_bucket.vault, google_kms_crypto_key.vault, google_service_account.vault]
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  count    = var.vault_cluster_gcp == true ? 1 : 0
  location = google_cloud_run_service.default[0].location
  project  = google_cloud_run_service.default[0].project
  service  = google_cloud_run_service.default[0].name

  policy_data = data.google_iam_policy.noauth[0].policy_data
}
