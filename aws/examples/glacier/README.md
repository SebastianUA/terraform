# Work with GLACIER via terraform

A terraform module for making GLACIER.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "glacier" {
  source      = "../../modules/glacier"
  name        = "TEST"
  environment = "stage"

  # Glacier Vault
  enable_glacier_vault        = true
  glacier_vault_name          = ""
  glacier_vault_access_policy = file("additional_files/glacier_vault_policy.json")
  glacier_vault_notification  = []

  #   Glacier Vault lock
  enable_glacier_vault_lock                = true
  glacier_vault_lock_complete_lock         = false
  glacier_vault_lock_policy                = file("additional_files/glacier_vault_policy.json")
  glacier_vault_lock_ignore_deletion_error = null

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_glacier_vault` - Enable glacier vault usage (`default = False`)
- `glacier_vault_name` - The name of the Vault. Names can be between 1 and 255 characters long and the valid characters are a-z, A-Z, 0-9, '_' (underscore), '-' (hyphen), and '.' (period). (`default = ""`)
- `glacier_vault_access_policy` - (Optional) The policy document. This is a JSON formatted string. The heredoc syntax or file function is helpful here. Use the Glacier Developer Guide for more information on Glacier Vault Policy (`default = null`)
- `glacier_vault_notification` - (Optional) The notifications for the Vault. (`default = []`)
- `enable_glacier_vault_lock` - Enable glacier vault lock usage (`default = False`)
- `glacier_vault_lock_complete_lock` - (Required) Boolean whether to permanently apply this Glacier Lock Policy. Once completed, this cannot be undone. If set to false, the Glacier Lock Policy remains in a testing mode for 24 hours. After that time, the Glacier Lock Policy is automatically removed by Glacier and the Terraform resource will show as needing recreation. Changing this from false to true will show as resource recreation, which is expected. Changing this from true to false is not possible unless the Glacier Vault is recreated at the same time. (`default = False`)
- `glacier_vault_lock_policy` - (Required) JSON string containing the IAM policy to apply as the Glacier Vault Lock policy. (`default = null`)
- `glacier_vault_lock_vault_name` - The name of the Glacier Vault. (`default = ""`)
- `glacier_vault_lock_ignore_deletion_error` - (Optional) Allow Terraform to ignore the error returned when attempting to delete the Glacier Lock Policy. This can be used to delete or recreate the Glacier Vault via Terraform, for example, if the Glacier Vault Lock policy permits that action. This should only be used in conjunction with complete_lock being set to true. (`default = null`)

## Module Output Variables
----------------------
- `glacier_vault_id` - ID of glacier vault
- `glacier_vault_arn` - The ARN of the vault.
- `glacier_vault_location` - The URI of the vault that was created.
- `glacier_vault_lock_id` - Glacier Vault name.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
