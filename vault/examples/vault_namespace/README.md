# Work with VAULT_NAMESPACE via terraform

A terraform module for making VAULT_NAMESPACE.


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
    vault = {
      source  = "hashicorp/vault"
      version = "~> 2.17.0"
    }
  }
}

provider "vault" {
  address = "http://127.0.0.1:8200"
  token   = "s.mCwwXmc2wfgcCghPWFdIXe82"
}

module "vault_namespace" {
  source = "../../modules/vault_namespace"

  enable_namespace = true
  namespace_path   = "ns1"

}

```

## Module Input Variables
----------------------
- `enable_namespace` - Enable namespace for Vault usage (`default = False`)
- `namespace_path` - (Required) The path of the namespace. Must not have a trailing / (`default = null`)

## Module Output Variables
----------------------
- `namespace_id` - ID of the namespace.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
