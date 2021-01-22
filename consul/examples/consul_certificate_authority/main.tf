#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.13"

  required_providers {
    consul = {
      source  = "hashicorp/consul"
      version = "~> 2.11.0"
    }
  }
}

provider "consul" {
  address    = "127.0.0.1:8500"
  scheme     = "http"
  datacenter = "dc1"

  ca_file        = null
  ca_pem         = null
  cert_file      = null
  cert_pem       = null
  key_file       = null
  key_pem        = null
  ca_path        = null
  http_auth      = null
  token          = null
  insecure_https = null
}

module "consul_certificate_authority_consul" {
  source = "../../modules/consul_certificate_authority"

  enable_certificate_authority           = true
  certificate_authority_connect_provider = "consul"
  certificate_authority_config = {
    LeafCertTTL         = "24h"
    RotationPeriod      = "2160h"
    IntermediateCertTTL = "8760h"
  }
}

module "consul_certificate_authority_vault" {
  source = "../../modules/consul_certificate_authority"

  enable_certificate_authority           = true
  certificate_authority_connect_provider = "vault"
  certificate_authority_config = {
    address               = "http://localhost:8200"
    token                 = "token_here"
    root_pki_path         = "connect-root"
    intermediate_pki_path = "connect-intermediate"
  }
}

module "consul_certificate_authority_aws-pca" {
  source = "../../modules/consul_certificate_authority"

  enable_certificate_authority           = true
  certificate_authority_connect_provider = "aws-pca"
  certificate_authority_config = {
    existing_arn = "arn:aws:acm-pca:region:account:certificate-authority/12345678-1234-1234-123456789012"
  }
}
