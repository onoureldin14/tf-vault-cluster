provider "google" {
  project = var.google_project_id
  region  = var.google_region
}

provider "aws" {
  region = var.region
}

provider "hcp" {}

provider "tfe" {
  hostname = var.tfc_hostname
}
