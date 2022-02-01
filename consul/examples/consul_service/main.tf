#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"

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

module "consul_node" {
  source = "../../modules/consul_node"

  enable_node     = true
  node_name       = "consul-node-1"
  node_address    = "192.168.0.113"
  node_datacenter = "dc1"

  node_meta = {
    foo = "bar"
  }
}

module "consul_service" {
  source = "../../modules/consul_service"

  enable_service = true
  service_name   = "consul-service-1"
  service_node   = module.consul_node.consul_node_name

  service_port = 80
  service_tags = ["tags0"]

  service_check = [
    {
      check_id                          = "service:redis1"
      name                              = "Redis health check"
      status                            = "passing"
      http                              = "https://www.hashicorptest.com"
      tls_skip_verify                   = false
      method                            = "PUT"
      interval                          = "5s"
      timeout                           = "1s"
      deregister_critical_service_after = "30s"

      header = [
        {
          name  = "foo"
          value = ["test"]
        }
      ]
    }
  ]

  depends_on = [
    module.consul_node
  ]
}