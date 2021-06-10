#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"

  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "~> 2.17.0"
    }
  }
}

provider "vault" {
  address = "http://127.0.0.1:8200"
  token   = "s.mCwwXmc2wfgcCghPWFdIXe82"
}

module "vault_auth_backend_github" {
  source = "../../modules/vault_auth"

  enable_auth_backend = true
  auth_backend_type   = "github"

  auth_backend_tune = [
    {
      max_lease_ttl      = "90000s"
      listing_visibility = "unauth"
    }
  ]

  auth_backend_description = "Set github backend for Vault"
  auth_backend_path        = null
  auth_backend_local       = null
}

module "vault_auth_backend_userpass" {
  source = "../../modules/vault_auth"

  enable_auth_backend = true
  auth_backend_type   = "userpass"

  auth_backend_tune        = []
  auth_backend_description = "Set userpass backend for Vault"
  auth_backend_path        = null
  auth_backend_local       = null
}
