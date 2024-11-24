terraform {
  # backend "s3" {
  #     bucket         = "terraform-state-7bqml8"
  #     key            = "tf-vault-config/terraform.tfstate"
  #     region         = "eu-west-2"
  #     dynamodb_table = "terraform-app-state-lock"
  # }
  backend "remote" {
    organization = "Onoureldin"
    workspaces {
      name = "tf-vault-cluster"
    }
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.12.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1.3"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.12.1"
    }
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
