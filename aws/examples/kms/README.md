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
  required_version = "> 0.9.0"
}
provider "aws" {
    region  = "us-east-1"
    # alias = "us-east-1"
    shared_credentials_file = "${pathexpand("~/.aws/credentials")}"
     # access_key = "${var.aws_access_key}"
     # secret_key = "${var.aws_secret_key}"
}

module "kms" {
    source               = "../../modules/kms"
    name                 = "TEST-KMS"
    environment          = "PROD"

    aws_account_id       = "XXXXXXXXXXXXXXXXXX"           
}

```

Module Input Variables
----------------------

- `name` - Name to be used on all resources as prefix (`default = "TEST-KMS"`).
- `environment` - Environment for service (`default  = "STAGE"`).
- `orchestration` - Type of orchestration (`default  = "Terraform"`).
- `createdby` - Created by (`default  = "Vitaliy Natarov"`).
- `deletion_window_in_days` - Duration in days after which the key is deleted after destruction of the resource, must be between 7 and 30 days. Defaults to 30 days (`default = "10"`).
- `description` - The description of the key as viewed in AWS console (`default = "This key is used to encrypt <___> AWS service"`).
- `key_usage` - Specifies the intended use of the key. Defaults to ENCRYPT_DECRYPT, and only symmetric encryption and decryption are supported (`default = ""`).
- `is_enabled` - Specifies whether the key is enabled. Defaults to true (`default = "true"`).
- `enable_key_rotation` - Specifies whether key rotation is enabled. Defaults to false (`default = "false"`).
- `admin_user` - Admin user in IAM (`default = "root"`).
- `aws_account_id` - AWS account ID (`default  = ""`).

Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.
