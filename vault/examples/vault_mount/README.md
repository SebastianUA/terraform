# Work with VAULT_MOUNT via terraform

A terraform module for making VAULT_MOUNT.


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

module "vault_mount" {
  source = "../../modules/vault_mount"

  enable_mount      = true
  mount_path        = "dummy"
  mount_type        = "generic"
  mount_description = "test desc here"

}

```

## Module Input Variables
----------------------
- `enable_mount` - Enable mount for Vault usage (`default = False`)
- `mount_path` - (Required) Where the secret backend will be mounted (`default = null`)
- `mount_type` - (Required) Type of the backend, such as 'aws', 'generic', etc. (`default = null`)
- `mount_description` - (Optional) Human-friendly description of the mount (`default = null`)
- `mount_default_lease_ttl_seconds` - (Optional) Default lease duration for tokens and secrets in seconds (`default = null`)
- `mount_max_lease_ttl_seconds` - (Optional) Maximum possible lease duration for tokens and secrets in seconds (`default = null`)
- `mount_local` - (Optional) Boolean flag that can be explicitly set to true to enforce local mount in HA environment (`default = null`)
- `mount_options` - (Optional) Specifies mount type specific options that are passed to the backend (`default = null`)
- `mount_seal_wrap` - (Optional) Boolean flag that can be explicitly set to true to enable seal wrapping for the mount, causing values stored by the mount to be wrapped by the seal's encryption capability (`default = null`)
- `mount_external_entropy_access` - (Optional) Boolean flag that can be explicitly set to true to enable the secrets engine to access Vault's external entropy source (`default = null`)

## Module Output Variables
----------------------
- `mount_id` - ID of the mount.
- `mount_accessor` - The accessor for this mount.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
