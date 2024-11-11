resource "tfe_variable_set" "vault_config" {
  name         = "Vault Config"
  description  = "Contains vault config related variables"
  organization = var.tfc_organization_name
}

resource "tfe_workspace" "tf_vault_config" {
  name = "tf-vault-config"
  organization = var.tfc_organization_name
}

resource "tfe_variable" "vault_public_address" {
  key             = "vault_public_address"
  value           = hcp_vault_cluster.hcp_vault.vault_public_endpoint_url
  category        = "terraform"
  sensitive       = true
  description     = "Value of the public endpoint URL of the HCP Vault cluster"
  variable_set_id = tfe_variable_set.vault_config.id
}

resource "tfe_variable" "vault_admin_token" {
  key             = "vault_token"
  value           = hcp_vault_cluster_admin_token.admin_token.token
  category        = "terraform"
  sensitive       = true
  description     = "Value of the admin token of the HCP Vault cluster"
  variable_set_id = tfe_variable_set.vault_config.id
}

resource "tfe_workspace_variable_set" "workload" {
  variable_set_id = tfe_variable_set.vault_config.id
  workspace_id    = tfe_workspace.tf_vault_config.id
}