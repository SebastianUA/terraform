# Work with AWS KMS via terraform

A terraform module for making AWS KMS.

## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
    required_version = "~> 0.12.12"
}

provider "aws" {
    region                  = "us-east-1"
    # alias                  = "us-east-1"
    shared_credentials_file = pathexpand("~/.aws/credentials")
}

data "template_file" "kms_key_policy" {
    template = file("policies/kms_key_policy.json.tpl")
}

module "kms" {
    source              = "../../modules/kms"

    enable_kms_key      = true
    name                = "TESTKMS"
    environment         = "stage"

    policy              = data.template_file.kms_key_policy.rendered

}
```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST-KMS`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, and propagate_at_launch. (`default = ""`)
- `enable_kms_key` - Allow to create kms_key (`default = ""`)
- `kms_key_name` - Name for KMS (`default = ""`)
- `deletion_window_in_days` - Duration in days after which the key is deleted after destruction of the resource, must be between 7 and 30 days. Defaults to 30 days. (`default = 10`)
- `description` - The description of the key as viewed in AWS console. (`default = This key is used to encrypt <___> AWS service`)
- `key_usage` - Specifies the intended use of the key. Defaults to ENCRYPT_DECRYPT, and only symmetric encryption and decryption are supported (`default = ENCRYPT_DECRYPT`)
- `is_enabled` - Specifies whether the key is enabled. Defaults to true. (`default = True`)
- `enable_key_rotation` - Specifies whether key rotation is enabled. Defaults to false. (`default = ""`)
- `policy` - Set policy (`default = ""`)
- `enable_kms_alias` - Allow to create kms_alias (`default = ""`)
- `kms_alias_name` - (Optional) The display name of the alias. The name must start with the word 'alias' followed by a forward slash (alias/) (`default = ""`)
- `name_prefix` - (Optional) Creates an unique alias beginning with the specified prefix. The name must start with the word 'alias' followed by a forward slash (alias/). Conflicts with name. (`default = ""`)
- `target_key_id` - (Required) Identifier for the key for which the alias is for, can be either an ARN or key_id. (`default = ""`)

## Module Output Variables
----------------------
- `kms_key_arn` - The globally unique identifier for the key.
- `kms_key_id` - The globally unique identifier for the key.
- `kms_alias_arn` - Alias arn of KMS


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
