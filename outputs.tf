output "gcp_service_account_email" {
  value = var.vault_cluster_gcp ? google_service_account.vault[0].email : null
}

output "vault_gcp_app_url" {
  value = var.vault_cluster_gcp == true ? google_cloud_run_service.default[0].status[0].url : null
}

output "vault_hcp_app_url" {
  value = var.vault_cluster_gcp == false ? hcp_vault_cluster.hcp_vault[0].vault_public_endpoint_url : null
}

output "vault_hcp_admin_token" {
  value     = var.vault_cluster_gcp == false ? hcp_vault_cluster_admin_token.admin_token[0].token : null
  sensitive = true

}
