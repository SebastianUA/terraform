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

module "consul_prepared_query" {
  source = "../../modules/consul_prepared_query"

  enable_prepared_query  = true
  prepared_query_name    = "prepared-query-name"
  prepared_query_service = "myapp"

  prepared_query_datacenter   = "us-central1"
  prepared_query_token        = "abcd"
  prepared_query_stored_token = "wxyz"
  prepared_query_only_passing = true
  prepared_query_near         = "_agent"

  prepared_query_failover = [
    {
      nearest_n   = 3
      datacenters = ["us-west1", "us-east-2", "asia-east1"]
    }
  ]

  prepared_query_dns = [
    {
      ttl = "30s"
    }
  ]

  prepared_query_template = [
    {
      type   = "name_prefix_match"
      regexp = "^(.*)-near-self$"
    }
  ]

  prepared_query_tags = ["active", "!standby"]
}
