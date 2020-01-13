# Work with AWS KMS via terraform

A terraform module for making KMS.

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

Module Input Variables
----------------------

- `name` - Name to be used on all resources as prefix (`default     = "TEST-KMS"`).
- `region` - The region where to deploy this code (e.g. us-east-1). (`default     = "us-east-1"`).
- `environment` - Environment for service (`default     = "STAGE"`).
- `orchestration` - Type of orchestration (`default     = "Terraform"`).
- `createdby` - Created by (`default     = "Vitaliy Natarov"`).
- `tags` - A list of tag blocks. Each element should have keys named key, value, and propagate_at_launch. (`default     = {}`).
- `enable_kms_key` - Allow to create kms_key (`default     = false`).
- `kms_key_name` - Name for KMS (`default       = ""`).
- `deletion_window_in_days` - Duration in days after which the key is deleted after destruction of the resource, must be between 7 and 30 days. Defaults to 30 days. (`default     = 10`).
- `description` - The description of the key as viewed in AWS console. (`default     = "This key is used to encrypt <___> AWS service"`).
- `key_usage` - Specifies the intended use of the key. Defaults to ENCRYPT_DECRYPT, and only symmetric encryption and decryption are supported (`default     = ""`).
- `is_enabled` - Specifies whether the key is enabled. Defaults to true. (`default     = true`).
- `enable_key_rotation` - Specifies whether key rotation is enabled. Defaults to false. (`default     = false`).
- `policy` - Set policy (`default       = ""`).
- `enable_kms_alias` - Allow to create kms_alias (`default     = false`).
- `kms_alias_name` - (Optional) The display name of the alias. The name must start with the word 'alias' followed by a forward slash (alias/) (`default       = null`).
- `name_prefix` - (Optional) Creates an unique alias beginning with the specified prefix. The name must start with the word 'alias' followed by a forward slash (alias/). Conflicts with name. (`default     = null`).
- `target_key_id` - (Required) Identifier for the key for which the alias is for, can be either an ARN or key_id. (`default     = ""`).

Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.
