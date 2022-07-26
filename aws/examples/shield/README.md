# Work with SHIELD via terraform

A terraform module for making SHIELD.


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
    aws = "~> 2.49"
  }
}

provider "aws" {
  region                  = "us-east-1"
  profile                 = "default"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "shield" {
  source = "../../modules/shield"

  enable_shield_protection       = true
  shield_protection_name         = "my-first-shield-protection"
  shield_protection_resource_arn = ""
}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `enable_shield_protection` - Enable shield protection usage (`default = False`)
- `shield_protection_name` - A friendly name for the Protection you are creating. (`default = ""`)
- `shield_protection_resource_arn` - (Required) The ARN (Amazon Resource Name) of the resource to be protected. (`default = ""`)

## Module Output Variables
----------------------
- `shield_protection_id` - The unique identifier (ID) for the Protection object that is created.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
