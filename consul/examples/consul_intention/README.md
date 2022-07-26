# Work with CONSUL_INTENTION via terraform

A terraform module for making CONSUL_INTENTION.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
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

      header_name  = "foo"
      header_value = ["test"]
    }
  ]

  depends_on = [
    module.consul_node
  ]
}

module "consul_intention" {
  source = "../../modules/consul_network_area"

  enable_intention           = true
  intention_source_name      = "api"
  intention_destination_name = module.consul_service.consul_service_name
  intention_action           = "allow"


  depends_on = [
    module.consul_service
  ]
}

```

## Module Input Variables
----------------------
- `enable_intention` - Enable intention for Consul usage (`default = False`)
- `intention_source_name` - (Required, string) The name of the source service for the intention. This service does not have to exist. (`default = null`)
- `intention_destination_name` - (Required, string) The name of the destination service for the intention. This service does not have to exist. (`default = null`)
- `intention_action` - (Required, string) The intention action. Must be one of allow or deny. (`default = null`)
- `intention_description` - (Optional, string) Optional description that can be used by Consul tooling, but is not used internally. (`default = null`)
- `intention_datacenter` - (Optional) The datacenter to use. This overrides the agent's default datacenter and the datacenter in the provider setup. (`default = null`)
- `intention_source_namespace` - (Optional, Enterprise Only) The source namespace of the intention. (`default = null`)
- `intention_destination_namespace` - (Optional, Enterprise Only) The destination namespace of the intention. (`default = null`)
- `intention_meta` - (Optional, map) Key/value pairs that are opaque to Consul and are associated with the intention. (`default = null`)

## Module Output Variables
----------------------
- `consul_intention_id` - ID of Counsul intention
- `consul_intention_source_name` - The source for the intention.
- `consul_intention_source_namespace` - The source namespace of the intention.
- `consul_intention_destination_name` - The destination for the intention.
- `consul_intention_destination_namespace` - The destination namespace of the intention.
- `consul_intention_action` - The intention action.
- `consul_intention_description` - A description of the intention.
- `consul_intention_meta` - Key/value pairs associated with the intention.
- `consul_intention_datacenter` - The datacenter in which the intention is created.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
