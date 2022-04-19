#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"

  required_providers {
    pfptmeta = {
      source  = "nsofnetworks/pfptmeta"
      version = "0.1.23"
    }
  }
}

provider "pfptmeta" {
  # Configuration options
}
