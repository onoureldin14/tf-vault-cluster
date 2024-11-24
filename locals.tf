locals {
  vault_kms_keyring_name    = "${var.name}-${lower(random_id.vault.hex)}-kr"
  vault_storage_bucket_name = "${var.name}-${lower(random_id.vault.hex)}-bucket"
  vault_crypto_key_name     = "${var.name}-${lower(random_id.vault.hex)}-key"
  vault_image               = "europe-west2-docker.pkg.dev/${var.google_project_id}/vault-repo/vault:1.18"
  vault_config = jsonencode(
    {
      "storage" = {
        "gcs" = {
          "bucket"     = local.vault_storage_bucket_name
          "ha_enabled" = "false"
        }
      },
      "seal" = {
        "gcpckms" = {
          "project"    = var.google_project_id,
          "region"     = var.google_region,
          "key_ring"   = local.vault_kms_keyring_name,
          "crypto_key" = local.vault_crypto_key_name
        }
      },
      "default_lease_ttl" = "168h",
      "max_lease_ttl"     = "720h",
      "disable_mlock"     = "true",
      "listener" = {
        "tcp" = {
          "address"     = "0.0.0.0:8080",
          "tls_disable" = "1"
        }
      },
      "ui" = var.vault_ui
    }
  )

}
