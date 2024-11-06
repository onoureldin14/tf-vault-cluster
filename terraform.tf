terraform {
    backend "s3" {
        bucket         = "terraform-state-7bqml8"
        key            = "tf-vault-cluster/terraform.tfstate"
        region         = "eu-west-2"
        dynamodb_table = "terraform-app-state-lock"
    }
  required_providers {
    hcp = {
      source = "hashicorp/hcp"
      version= "~>0.97.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.1.0"
    }   
  }
  required_version = "~> 1.2"
}