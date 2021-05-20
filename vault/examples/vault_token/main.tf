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

module "vault_token" {
  source = "../../modules/vault_token"

  enable_token = true

  token_display_name = "test_token"
  token_role_name    = "role1"
  token_policies     = ["policy1"]

  token_renewable = true
  token_ttl       = "24h"

  token_renew_min_lease = 43200
  token_renew_increment = 86400

  token_pgp_key = "keybase:captainua"
}

module "token_auth_backend_role" {
  source = "../../modules/vault_token"

  enable_token_auth_backend_role                 = true
  token_auth_backend_role_name                   = "role1"
  token_auth_backend_role_allowed_policies       = ["policy1"]
  token_auth_backend_role_disallowed_policies    = ["default"]
  token_auth_backend_role_orphan                 = true
  token_auth_backend_role_renewable              = true
  token_auth_backend_role_token_period           = 86400
  token_auth_backend_role_token_explicit_max_ttl = 115200
  token_auth_backend_role_path_suffix            = "path-suffix"

}
