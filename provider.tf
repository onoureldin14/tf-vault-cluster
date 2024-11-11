provider "aws" {
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
    region = var.region
}

provider "hcp" {}

provider "tfe" {
  hostname = var.tfc_hostname
  token    = var.tfc_token
}

