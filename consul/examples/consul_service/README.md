# Work with CONSUL_SERVICE via terraform

A terraform module for making CONSUL_SERVICE.


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
```

## Module Input Variables
----------------------
- `name` - Set name for Consul namespace if doesnt set namespace's name properly (`default = False`)
- `environment` - Set env for Consul namespace if does not set name (`default = dev`)
- `enable_service` - Enable service for Consul usage (`default = False`)
- `service_name` - The name of the service. (`default = ""`)
- `service_node` - (Required, string) The name of the node the to register the service on. (`default = null`)
- `service_datacenter` - (Optional) The datacenter to use. This overrides the agent's default datacenter and the datacenter in the provider setup. (`default = null`)
- `service_meta` - (Optional) A map of arbitrary KV metadata linked to the service instance. (`default = null`)
- `service_namespace` - (Optional, Enterprise Only) The namespace to create the service within. (`default = null`)
- `service_address` - (Optional, string) The address of the service. Defaults to the address of the node. (`default = null`)
- `service_port` - (Optional, int) The port of the service. (`default = null`)
- `service_service_id` - (Optional, string) - If the service ID is not provided, it will be defaulted to the value of the name attribute. (`default = null`)
- `service_enable_tag_override` - (Optional, boolean) Specifies to disable the anti-entropy feature for this service's tags. Defaults to false (`default = null`)
- `service_check` - (Optional, list of checks) Health-checks to register to monitor the service. (`default = []`)
- `service_tags` - (Optional, set of strings) A list of values that are opaque to Consul, but can be used to distinguish between services or nodes. (`default = null`)

## Module Output Variables
----------------------
- `consul_service_id` - ID of Counsul service
- `consul_service_service_id` - The ID of the service.
- `consul_service_address` - The address of the service.
- `consul_service_node` - The node the service is registered on.
- `consul_service_name` - The name of the service.
- `consul_service_port` - The port of the service.
- `consul_service_tags` - The tags of the service.
- `consul_service_check` - The list of health-checks associated with the service.
- `consul_service_datacenter` - The datacenter of the service.
- `consul_service_service_meta` - A map of arbitrary KV metadata linked to the service instance.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
