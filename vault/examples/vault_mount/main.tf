#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.15"

  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "~> 2.17.0"
    }
  }
}

provider "vault" {
  address = "http://127.0.0.1:8200"
  token   = "s.f0nKPyuFC2Ikk4IcNoRFOMgS"
}

module "vault_mount" {
  source = "../../modules/vault_mount"

  enable_mount      = true
  mount_path        = "dummy"
  mount_type        = "generic"
  mount_description = "test desc here"

}