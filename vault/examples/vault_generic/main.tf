#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.13"

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

module "vault_auth_backend_userpass" {
  source = "../../modules/vault_auth"

  enable_auth_backend = true
  auth_backend_type   = "userpass"

  auth_backend_tune        = []
  auth_backend_description = "Set userpass backend for Vault"
  auth_backend_path        = "secret/path"
  auth_backend_local       = null
}

module "generic_endpoint_u1" {
  source = "../../modules/vault_generic"

  enable_generic_endpoint    = true
  generic_endpoint_path      = "auth/userpass/users/u1"
  generic_endpoint_data_json = <<EOT
{
  "policies": ["p1"],
  "password": "changeme"
}
EOT

  generic_endpoint_ignore_absent_fields = true

  depends_on = [
    module.vault_auth_backend_userpass
  ]

}

module "generic_endpoint_u1_token" {
  source = "../../modules/vault_generic"

  enable_generic_endpoint    = true
  generic_endpoint_path      = "auth/userpass/login/u1"
  generic_endpoint_data_json = jsonencode({ "password" = "changeme" })

  generic_endpoint_ignore_absent_fields = true
  generic_endpoint_disable_read         = true
  generic_endpoint_disable_delete       = true

  depends_on = [
    module.generic_endpoint_u1
  ]

}

module "generic_endpoint_u1_entity" {
  source = "../../modules/vault_generic"

  enable_generic_endpoint    = true
  generic_endpoint_path      = "identity/lookup/entity"
  generic_endpoint_data_json = <<EOT
{
  "alias_name": "u1",
  "alias_mount_accessor": "${module.vault_auth_backend_userpass.auth_backend_accessor}"
}
EOT

  generic_endpoint_ignore_absent_fields = true
  generic_endpoint_disable_read         = true
  generic_endpoint_disable_delete       = true
  generic_endpoint_write_fields         = ["id"]

}

module "generic_secret" {
  source = "../../modules/vault_generic"

  enable_generic_secret    = true
  generic_secret_path      = "secret/test/tmp"
  generic_secret_data_json = jsonencode({ "hello" = "world" })

  generic_secret_disable_read = false

  depends_on = []
}