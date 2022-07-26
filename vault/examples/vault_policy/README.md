# Work with VAULT_POLICY via terraform

A terraform module for making VAULT_POLICY.


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

module "vault_policy" {
  source = "../../modules/vault_policy"

  enable_policy = true
  policy_name   = "policy1"

  policy = <<EOT
path "secret/my_app" {
  capabilities = ["update"]
}
EOT

}

#---------------------------------------------------
# Vault rgp policy
#---------------------------------------------------
module "vault_rgp_policy" {
  source = "../../modules/vault_policy"

  enable_rgp_policy            = true
  rgp_policy_name              = "allow-all"
  rgp_policy_enforcement_level = "soft-mandatory"

  rgp_policy = <<EOT
main = rule {
  true
}
EOT

}

#---------------------------------------------------
# Vault egp policy
#---------------------------------------------------
module "egp_policy" {
  source = "../../modules/vault_policy"

  enable_egp_policy            = true
  egp_policy_name              = "allow-all"
  egp_policy_paths             = ["*"]
  egp_policy_enforcement_level = "soft-mandatory"

  egp_policy = <<EOT
main = rule {
  true
}
EOT

}

```

## Module Input Variables
----------------------
- `name` - Set default suffix name (`default = vault`)
- `environment` - Set ENV (`default = dev`)
- `enable_policy` - Enable policy for vault usage (`default = False`)
- `policy_name` - The name of the policy (`default = ""`)
- `policy` - (Required) String containing a Vault policy (`default = null`)
- `enable_rgp_policy` - Enable rgp policy for vault usage (`default = False`)
- `rgp_policy_name` - The name of the policy (`default = ""`)
- `rgp_policy` - (Required) String containing a Vault policy (`default = null`)
- `rgp_policy_enforcement_level` - (Required) Enforcement level of Sentinel policy. Can be either advisory or soft-mandatory or hard-mandatory (`default = null`)
- `enable_egp_policy` - Enable egp policy for vault usage (`default = False`)
- `egp_policy_name` - The name of the policy (`default = ""`)
- `egp_policy` - (Required) String containing a Sentinel policy (`default = null`)
- `egp_policy_enforcement_level` - (Required) Enforcement level of Sentinel policy. Can be either advisory or soft-mandatory or hard-mandatory (`default = null`)
- `egp_policy_paths` - (Required) List of paths to which the policy will be applied to (`default = null`)

## Module Output Variables
----------------------
- `vault_policy_id` - ID of Vault policy
- `vault_rgp_policy_id` - ID of Vault rgp policy
- `vault_egp_policy_id` - ID of Vault egp policy


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
