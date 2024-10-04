terraform {
  required_providers {
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.94.1"
    }
  }
}

provider "hcp" {}

provider "tfe" {
  organization = "mattspahr-sandbox"
}

provider "random" {}
