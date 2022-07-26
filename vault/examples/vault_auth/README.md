# Work with VAULT_AUTH via terraform

A terraform module for making VAULT_AUTH.


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

module "vault_auth_backend_github" {
  source = "../../modules/vault_auth"

  enable_auth_backend = true
  auth_backend_type   = "github"

  auth_backend_tune = [
    {
      max_lease_ttl      = "90000s"
      listing_visibility = "unauth"
    }
  ]

  auth_backend_description = "Set github backend for Vault"
  auth_backend_path        = null
  auth_backend_local       = null
}

module "vault_auth_backend_userpass" {
  source = "../../modules/vault_auth"

  enable_auth_backend = true
  auth_backend_type   = "userpass"

  auth_backend_tune        = []
  auth_backend_description = "Set userpass backend for Vault"
  auth_backend_path        = null
  auth_backend_local       = null
}

```

## Module Input Variables
----------------------
- `enable_auth_backend` - Enable auth backend for vault (`default = False`)
- `auth_backend_type` - (Required) The name of the auth method type (`default = null`)
- `auth_backend_path` - (Optional) The path to mount the auth method — this defaults to the name of the type (`default = null`)
- `auth_backend_description` - (Optional) A description of the auth method (`default = null`)
- `auth_backend_local` - (Optional) Specifies if the auth method is local only. (`default = null`)
- `auth_backend_tune` - (Optional) Extra configuration block. (`default = []`)

## Module Output Variables
----------------------
- `auth_backend_id` - ID of Vault auth backend
- `auth_backend_accessor` - The accessor for this auth method


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
