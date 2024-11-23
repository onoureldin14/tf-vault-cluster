provider "aws" {
  region     = var.region
}

provider "hcp" {}

provider "tfe" {
  hostname = var.tfc_hostname
}
