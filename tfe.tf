resource "tfe_variable_set" "vault_config" {
  count        = var.tf_cloud_backend == true ? 1 : 0
  name         = "Vault Config"
  description  = "Contains vault config related variables"
  organization = var.tfc_organization_name
}

resource "tfe_workspace" "tf_vault_config" {
  count        = var.tf_cloud_backend == true ? 1 : 0
  name         = "tf-vault-config"
  organization = var.tfc_organization_name
}

resource "tfe_variable" "vault_public_address_variable" {
  count           = var.tf_cloud_backend == true ? 1 : 0
  key             = "vault_public_address"
  value           = var.vault_cluster_gcp ? google_cloud_run_service.default[0].status[0].url : hcp_vault_cluster.hcp_vault[0].vault_public_endpoint_url
  category        = "terraform"
  sensitive       = true
  description     = "Variable of the public endpoint URL of the HCP Vault cluster"
  variable_set_id = tfe_variable_set.vault_config[0].id
}

resource "tfe_variable" "vault_public_address" {
  count           = var.tf_cloud_backend == true ? 1 : 0
  key             = "VAULT_ADDR"
  value           = var.vault_cluster_gcp ? google_cloud_run_service.default[0].status[0].url : hcp_vault_cluster.hcp_vault[0].vault_public_endpoint_url
  category        = "env"
  sensitive       = true
  description     = "Env Value of the public endpoint URL of the HCP Vault cluster"
  variable_set_id = tfe_variable_set.vault_config[0].id
}


resource "tfe_variable" "vault_admin_token" {
  count           = var.tf_cloud_backend == true ? 1 : 0
  key             = "VAULT_TOKEN"
  value           = var.vault_cluster_gcp ? "FETCH_VAULT_ROOT_TOKEN_FROM_GCP" : hcp_vault_cluster_admin_token.admin_token[0].token
  category        = "env"
  sensitive       = true
  description     = "Value of the admin token of the HCP Vault cluster"
  variable_set_id = tfe_variable_set.vault_config[0].id
}

resource "tfe_workspace_variable_set" "workload" {
  count           = var.tf_cloud_backend == true ? 1 : 0
  variable_set_id = tfe_variable_set.vault_config[0].id
  workspace_id    = tfe_workspace.tf_vault_config[0].id
}
