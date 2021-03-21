#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.14"

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

module "consul_network_area" {
  source = "../../modules/consul_network_area"

  enable_network_area          = true
  network_area_peer_datacenter = "dc2"
  network_area_retry_join      = ["1.2.3.4"]
  network_area_use_tls         = true
}
