# Work with VAULT_GENERIC via terraform

A terraform module for making VAULT_GENERIC.


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

module "vault_auth_backend_userpass" {
  source = "../../modules/vault_auth"

  enable_auth_backend = true
  auth_backend_type   = "userpass"

  auth_backend_tune        = []
  auth_backend_description = "Set userpass backend for Vault"
  auth_backend_path        = "secret/path"
  auth_backend_local       = null
}

module "generic_endpoint_u1" {
  source = "../../modules/vault_generic"

  enable_generic_endpoint    = true
  generic_endpoint_path      = "auth/userpass/users/u1"
  generic_endpoint_data_json = <<EOT
{
  "policies": ["p1"],
  "password": "changeme"
}
EOT

  generic_endpoint_ignore_absent_fields = true

  depends_on = [
    module.vault_auth_backend_userpass
  ]

}

module "generic_endpoint_u1_token" {
  source = "../../modules/vault_generic"

  enable_generic_endpoint    = true
  generic_endpoint_path      = "auth/userpass/login/u1"
  generic_endpoint_data_json = jsonencode({ "password" = "changeme" })

  generic_endpoint_ignore_absent_fields = true
  generic_endpoint_disable_read         = true
  generic_endpoint_disable_delete       = true

  depends_on = [
    module.generic_endpoint_u1
  ]

}

module "generic_endpoint_u1_entity" {
  source = "../../modules/vault_generic"

  enable_generic_endpoint    = true
  generic_endpoint_path      = "identity/lookup/entity"
  generic_endpoint_data_json = <<EOT
{
  "alias_name": "u1",
  "alias_mount_accessor": "${module.vault_auth_backend_userpass.auth_backend_accessor}"
}
EOT

  generic_endpoint_ignore_absent_fields = true
  generic_endpoint_disable_read         = true
  generic_endpoint_disable_delete       = true
  generic_endpoint_write_fields         = ["id"]

}

module "generic_secret" {
  source = "../../modules/vault_generic"

  enable_generic_secret    = true
  generic_secret_path      = "secret/test/tmp"
  generic_secret_data_json = jsonencode({ "hello" = "world" })

  generic_secret_disable_read = false

  depends_on = []
}

```

## Module Input Variables
----------------------
- `enable_generic_secret` - Enable generic_secret for Vault usage (`default = False`)
- `generic_secret_path` - (Required) The full logical path at which to write the given data. To write data into the 'generic' secret backend mounted in Vault by default, this should be prefixed with secret/. Writing to other backends with this resource is possible; consult each backend's documentation to see which endpoints support the PUT and DELETE methods. (`default = null`)
- `generic_secret_data_json` - (Required) String containing a JSON-encoded object that will be written as the secret data at the given path. (`default = null`)
- `generic_secret_disable_read` - (Optional) True/false. Set this to true if your vault authentication is not able to read the data. Setting this to true will break drift detection. Defaults to false. (`default = False`)
- `enable_generic_endpoint` - Enable generic_endpoint for Vault usage (`default = False`)
- `generic_endpoint_path` - (Required) The full logical path at which to write the given data. Consult each backend's documentation to see which endpoints support the PUT methods and to determine whether they also support DELETE and GET. (`default = null`)
- `generic_endpoint_data_json` - (Required) String containing a JSON-encoded object that will be written to the given path as the secret data. (`default = null`)
- `generic_endpoint_ignore_absent_fields` - (Optional) True/false. If set to true, ignore any fields present when the endpoint is read but that were not in data_json. Also, if a field that was written is not returned when the endpoint is read, treat that field as being up to date. You should set this to true when writing to endpoint that, when read, returns a different set of fields from the ones you wrote, as is common with many configuration endpoints. Defaults to false. (`default = False`)
- `generic_endpoint_disable_read` - (Optional) True/false. Set this to true if your vault authentication is not able to read the data or if the endpoint does not support the GET method. Setting this to true will break drift detection. You should set this to true for endpoints that are write-only. Defaults to false. (`default = False`)
- `generic_endpoint_disable_delete` - (Optional) True/false. Set this to true if your vault authentication is not able to delete the data or if the endpoint does not support the DELETE method. Defaults to false. (`default = False`)
- `generic_endpoint_write_fields` - (Optional). A list of fields that should be returned in write_data_json and write_data. If omitted, data returned by the write operation is not available to the resource or included in state. This helps to avoid accidental storage of sensitive values in state. Some endpoints, such as many dynamic secrets endpoints, return data from writing to an endpoint rather than reading it. You should use write_fields if you need information returned in this way. (`default = null`)

## Module Output Variables
----------------------
- `generic_secret_id` - ID of Vault generic secret
- `generic_endpoint_id` - ID of Vault generic endpoint


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
