# Work with CONSUL_NAMESPACE via terraform

A terraform module for making CONSUL_NAMESPACE.


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

module "consul_namespace" {
  source = "../../modules/consul_namespace"

  enable_namespace      = true
  namespace_name        = "consul-ns"
  namespace_description = "Test consul namespace"

  namespace_policy_defaults = null
  namespace_role_defaults   = null

  namespace_meta = {
    foo = "bar"
  }
}

```

## Module Input Variables
----------------------
- `name` - Set name for Consul namespace if doesnt set namespace's name properly (`default = False`)
- `environment` - Set env for Consul namespace if does not set name (`default = dev`)
- `enable_namespace` - Enable namespace for Consul usage (`default = False`)
- `namespace_name` - The namespace name. (`default = ""`)
- `namespace_description` - (Optional) Free form namespace description. (`default = null`)
- `namespace_policy_defaults` - (Optional) The list of default policies that should be applied to all tokens created in this namespace. (`default = null`)
- `namespace_role_defaults` - (Optional) The list of default roles that should be applied to all tokens created in this namespace. (`default = null`)
- `namespace_meta` - (Optional) Specifies arbitrary KV metadata to associate with the namespace. (`default = null`)

## Module Output Variables
----------------------
- `consul_namespace_id` - ID of Counsul namespace
- `consul_namespace_name` - The namespace name.
- `consul_namespace_description` - The namespace description.
- `consul_namespace_policy_defaults` - The list of default policies that will be applied to all tokens created in this namespace.
- `consul_namespace_role_defaults` - The list of default roles that will be applied to all tokens created in this namespace.
- `consul_namespace_meta` - Arbitrary KV metadata associated with the namespace.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
