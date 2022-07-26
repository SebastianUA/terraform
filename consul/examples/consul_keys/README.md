# Work with CONSUL_KEYS via terraform

A terraform module for making CONSUL_KEYS.


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

```

## Module Input Variables
----------------------
- `enable_keys` - Enable keys for Consul usage (`default = False`)
- `keys_datacenter` - (Optional) The datacenter to use. This overrides the agent's default datacenter and the datacenter in the provider setup. (`default = null`)
- `keys_token` - (Optional) The ACL token to use. This overrides the token that the agent provides by default. (`default = null`)
- `keys_namespace` - (Optional, Enterprise Only) The namespace to create the keys within. (`default = null`)
- `consul_keys` - (Required) Specifies a key in Consul to be written.  (`default = []`)
- `enable_key_prefix` - Enable key prefix usage (`default = False`)
- `key_prefix_path_prefix` - (Required) Specifies the common prefix shared by all keys that will be managed by this resource instance. In most cases this will end with a slash, to manage a 'folder' of keys. (`default = null`)
- `key_prefix_datacenter` - (Optional) The datacenter to use. This overrides the agent's default datacenter and the datacenter in the provider setup. (`default = null`)
- `key_prefix_token` - (Optional) The ACL token to use. This overrides the token that the agent provides by default. (`default = null`)
- `key_prefix_namespace` - (Optional, Enterprise Only) The namespace to create the keys within. (`default = null`)
- `key_prefix_subkeys` - (Optional) A mapping from subkey name (which will be appended to the given path_prefix) to the value that should be stored at that key. Use slashes, as shown in the above example, to create 'sub-folders' under the given path prefix. (`default = null`)
- `key_prefix_subkey` - (Optional) A subkey to add. Supported values documented below. Multiple blocks supported. (`default = []`)

## Module Output Variables
----------------------
- `consul_keys_id` - ID of Counsul keys
- `consul_keys_datacenter` - The datacenter the keys are being written to.
- `consul_key_prefix_id` - ID of Counsul key prefix
- `consul_key_prefix_datacenter` - The datacenter the keys are being read/written to.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
