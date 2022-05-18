#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"
  # backend "remote" {
  #   organization = "captain"

  #   workspaces {
  #     name = "captain-tls-nonprod"
  #   }
  # }
}


module "tls_private_key" {
  source = "../../modules/tls"

  enable_tls_private_key      = true
  tls_private_key_algorithm   = "RSA"
  tls_private_key_ecdsa_curve = "P224"
  tls_private_key_rsa_bits    = 2048
}

module "tls_self_signed_cert" {
  source = "../../modules/tls"

  enable_self_signed_cert = true
  #tls_self_signed_cert_private_key_pem           = file("file.pem")
  tls_self_signed_cert_private_key_pem = module.tls_private_key.tls_private_key_private_key_pem
  tls_self_signed_cert_subject = {
    name         = "linux-notes.org"
    organization = "Organisation"
  }
}

module "tls_locally_signed_cert" {
  source = "../../modules/tls"

  enable_locally_signed_cert = false
}

module "tls_cert_request" {
  source = "../../modules/tls"

  enable_tls_cert_request          = false
  tls_cert_request_private_key_pem = module.tls_private_key.tls_private_key_private_key_pem

  tls_cert_request_subject = {
    common_name  = "linux-notes.org"
    organization = "ACME Examples, Inc"
  }

}
