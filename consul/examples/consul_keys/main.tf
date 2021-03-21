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

module "consul_keys" {
  source = "../../modules/consul_keys"

  enable_keys = true

  keys_datacenter = null
  keys_namespace  = null

  consul_keys = [
    {
      path  = "service/app1"
      value = "test"
    },
    {
      path    = "service/app2"
      value   = "tmp"
      name    = "name"
      default = null
      flags   = 0
      delete  = false
    }
  ]
}

module "consul_key_prefix" {
  source = "../../modules/consul_keys"

  enable_key_prefix      = true
  key_prefix_path_prefix = "myapp/config/"
  key_prefix_datacenter  = "dc1"

  key_prefix_subkeys = {
    "elb_cname"         = "elb_cname"
    "s3_bucket_name"    = "s3_bucket_name"
    "database/hostname" = "database/hostname"
    "database/port"     = "database/port"
    "database/username" = "database/username"
    "database/name"     = "database/name"
  }

  key_prefix_subkey = [
    {
      path  = "database/password"
      value = "value"
      flags = 2
    },
    {
      path  = "database/password2"
      value = "value2"
      flags = 2
    }
  ]
}
