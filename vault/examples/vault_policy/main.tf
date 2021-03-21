#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.14"

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

module "vault_policy" {
  source = "../../modules/vault_policy"

  enable_policy = true
  policy_name   = "policy1"

  policy = <<EOT
path "secret/my_app" {
  capabilities = ["update"]
}
EOT

}

#---------------------------------------------------
# Vault rgp policy
#---------------------------------------------------
module "vault_rgp_policy" {
  source = "../../modules/vault_policy"

  enable_rgp_policy            = true
  rgp_policy_name              = "allow-all"
  rgp_policy_enforcement_level = "soft-mandatory"

  rgp_policy = <<EOT
main = rule {
  true
}
EOT

}

#---------------------------------------------------
# Vault egp policy
#---------------------------------------------------
module "egp_policy" {
  source = "../../modules/vault_policy"

  enable_egp_policy            = true
  egp_policy_name              = "allow-all"
  egp_policy_paths             = ["*"]
  egp_policy_enforcement_level = "soft-mandatory"

  egp_policy = <<EOT
main = rule {
  true
}
EOT

}