# Work with VAULT_TOKEN via terraform

A terraform module for making VAULT_TOKEN.


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

module "vault_token" {
  source = "../../modules/vault_token"

  enable_token = true

  token_display_name = "test_token"
  token_role_name    = "role1"
  token_policies     = ["policy1"]

  token_renewable = true
  token_ttl       = "24h"

  token_renew_min_lease = 43200
  token_renew_increment = 86400

  token_pgp_key = "keybase:captainua"
}

module "token_auth_backend_role" {
  source = "../../modules/vault_token"

  enable_token_auth_backend_role                 = true
  token_auth_backend_role_name                   = "role1"
  token_auth_backend_role_allowed_policies       = ["policy1"]
  token_auth_backend_role_disallowed_policies    = ["default"]
  token_auth_backend_role_orphan                 = true
  token_auth_backend_role_renewable              = true
  token_auth_backend_role_token_period           = 86400
  token_auth_backend_role_token_explicit_max_ttl = 115200
  token_auth_backend_role_path_suffix            = "path-suffix"

}

```

## Module Input Variables
----------------------
- `name` - Set default suffix name (`default = vault`)
- `environment` - Set ENV (`default = dev`)
- `enable_token` - Enable token for vault usage (`default = False`)
- `token_display_name` - (Optional) String containing the token display name (`default = null`)
- `token_role_name` - (Optional) The token role name (`default = null`)
- `token_policies` - (Optional) List of policies to attach to this token (`default = null`)
- `token_renewable` - (Optional) Flag to allow to renew this token (`default = null`)
- `token_ttl` - (Optional) The TTL period of this token (`default = null`)
- `token_explicit_max_ttl` - (Optional) The explicit max TTL of this token (`default = null`)
- `token_renew_min_lease` - (Optional) The minimal lease to renew this token (`default = null`)
- `token_renew_increment` - (Optional) The renew increment (`default = null`)
- `token_pgp_key` - (Optional) The PGP key with which the client_token will be encrypted. The key must be provided using either a base64 encoded non-armored PGP key, or a keybase username in the form keybase:somebody. The token won't be renewed automatically by the provider and client_token will be empty. If you do not set this argument, the client_token will be written as plain text in the Terraform state. (`default = null`)
- `token_no_parent` - (Optional) Flag to create a token without parent (`default = null`)
- `token_no_default_policy` - (Optional) Flag to not attach the default policy to this token (`default = null`)
- `token_period` - (Optional) The period of this token (`default = null`)
- `token_num_uses` - (Optional) The number of allowed uses of this token (`default = null`)
- `enable_token_auth_backend_role` - Enable token auth backend role for Vault usage (`default = False`)
- `token_auth_backend_role_name` - (Required) The name of the role. (`default = ""`)
- `token_auth_backend_role_allowed_policies` - (Optional) List of allowed policies for given role. (`default = null`)
- `token_auth_backend_role_disallowed_policies` - (Optional) List of disallowed policies for given role. (`default = null`)
- `token_auth_backend_role_orphan` - (Optional) If true, tokens created against this policy will be orphan tokens. (`default = null`)
- `token_auth_backend_role_renewable` - (Optional) Wether to disable the ability of the token to be renewed past its initial TTL. (`default = null`)
- `token_auth_backend_role_token_period` - If set, indicates that the token generated using this role should never expire. The token should be renewed within the duration specified by this value. At each renewal, the token's TTL will be set to the value of this field. Specified in seconds. (`default = null`)
- `token_auth_backend_role_token_explicit_max_ttl` - If set, the token will have an explicit max TTL set upon it. (`default = null`)
- `token_auth_backend_role_path_suffix` - (Optional) Tokens created against this role will have the given suffix as part of their path in addition to the role name. (`default = null`)
- `token_auth_backend_role_token_ttl` - (Optional) The incremental lifetime for generated tokens in number of seconds. Its current value will be referenced at renewal time. (`default = null`)
- `token_auth_backend_role_token_max_ttl` - (Optional) The maximum lifetime for generated tokens in number of seconds. Its current value will be referenced at renewal time. (`default = null`)
- `token_auth_backend_role_token_bound_cidrs` - (Optional) List of CIDR blocks; if set, specifies blocks of IP addresses which can authenticate successfully, and ties the resulting token to these blocks as well. (`default = null`)
- `token_auth_backend_role_token_no_default_policy` - (Optional) If set, the default policy will not be set on generated tokens; otherwise it will be added to the policies set in token_policies. (`default = null`)
- `token_auth_backend_role_token_num_uses` - (Optional) The period, if any, in number of seconds to set on the token. (`default = null`)
- `token_auth_backend_role_token_type` - (Optional) The type of token that should be generated. Can be service, batch, or default to use the mount's tuned default (which unless changed will be service tokens). For token store roles, there are two additional possibilities: default-service and default-batch which specify the type to return unless the client requests a different type at generation time. (`default = null`)

## Module Output Variables
----------------------
- `vault_token_id` - ID of Vault token
- `vault_token_lease_duration` - String containing the token lease duration if present in state file
- `vault_token_lease_started` - String containing the token lease started time if present in state file
- `vault_token_client_token` - String containing the client token if stored in present file
- `vault_token_encrypted_client_token` - String containing the client token encrypted with the given pgp_key if stored in present file
- `token_auth_backend_role_id` - ID of Vault token auth backend role


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
