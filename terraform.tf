terraform {
  backend "remote" {
    organization = "Onoureldin"
    workspaces {
      name = "tf-vault-cluster"
    }
  }
  required_providers {
    hcp = {
      source  = "hashicorp/hcp"
      version = "~>0.97.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.1.0"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.45.0"
    }
  }
  required_version = "~> 1.2"
}
