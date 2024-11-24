variable "initial_terraform_run" {
  description = "Initial run of Terraform."
  type        = bool
  default     = false
}

variable "tf_cloud_backend" {
  description = "Enable Terraform Cloud as the backend for the trust relationships project."
  type        = bool
  default     = false
}

variable "vault_cluster_gcp" {
  description = "Enable Vault cluster on GCP."
  type        = bool
  default     = false
}


variable "google_project_id" {
  description = "The Google Cloud project ID"
  type        = string
  default     = "security-vmt"
}


variable "google_region" {
  description = "The Google Cloud region"
  type        = string
  default     = "europe-west2"
}

variable "name" {
  description = "Application name."
  default     = "vault-gcp-cloud-run"
  type        = string
}

variable "vault_service_account_id" {
  description = "ID for the service account to be used. This is the part of the service account email before the `@` symbol."
  type        = string
  default     = "vault-sa"
}

variable "vault_kms_key_rotation" {
  description = "The period for KMS key rotation."
  type        = string
  default     = "7776000s"
}

variable "vault_kms_key_algorithm" {
  description = "The cryptographic algorithm to be used with the KMS key."
  type        = string
  default     = "GOOGLE_SYMMETRIC_ENCRYPTION"
}

variable "vault_kms_key_protection_level" {
  description = "The protection level to be used with the KMS key."
  type        = string
  default     = "SOFTWARE"
}

variable "container_concurrency" {
  description = "Max number of connections per container instance."
  type        = number
  default     = 80
}

variable "vault_ui" {
  description = "Enable Vault UI."
  type        = bool
  default     = false
}




variable "tfc_hostname" {
  type        = string
  default     = "app.terraform.io"
  description = "The hostname of the TFC or TFE instance."
}

variable "tfc_organization_name" {
  type        = string
  description = "The name of your Terraform Cloud organization."
  default     = "Onoureldin"
}

variable "hvn_id" {
  description = "The ID of the HCP HVN."
  type        = string
  default     = "vmt-hvn"
}

variable "cluster_id" {
  description = "The ID of the HCP Vault cluster."
  type        = string
  default     = "vmt-vault-cluster"
}

variable "peering_id" {
  description = "The ID of the HCP peering connection."
  type        = string
  default     = "vmt-vault-peering"
}

variable "route_id" {
  description = "The ID of the HCP HVN route."
  type        = string
  default     = "vmt-hvn-route"
}

variable "region" {
  description = "The region of the HCP HVN and Vault cluster."
  type        = string
  default     = "eu-west-2"
}

variable "cloud_provider" {
  description = "The cloud provider of the HCP HVN and Vault cluster."
  type        = string
  default     = "aws"
}

variable "tier" {
  description = "Tier of the HCP Vault cluster. Valid options for tiers."
  type        = string
  default     = "dev"
}
