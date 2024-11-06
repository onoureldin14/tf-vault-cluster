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