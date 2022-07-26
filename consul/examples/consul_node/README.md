# Work with CONSUL_NODE via terraform

A terraform module for making CONSUL_NODE.


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

```

## Module Input Variables
----------------------
- `name` - Set name for Consul namespace if doesnt set namespace's name properly (`default = False`)
- `environment` - Set env for Consul namespace if does not set name (`default = dev`)
- `enable_node` - Enable node for Consul usage (`default = False`)
- `node_name` - The name of the node being added to, or referenced in the catalog. (`default = ""`)
- `node_address` - (Required) The address of the node being added to, or referenced in the catalog. (`default = ""`)
- `node_datacenter` - (Optional) The datacenter to use. This overrides the agent's default datacenter and the datacenter in the provider setup. (`default = null`)
- `node_meta` - (Optional, map) Key/value pairs that are associated with the node. (`default = null`)

## Module Output Variables
----------------------
- `consul_node_id` - ID of Counsul node
- `consul_node_address` - The address of the node.
- `consul_node_name` - The name of the node.
- `consul_node_meta` - (Optional, map) Key/value pairs that are associated with the node.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
