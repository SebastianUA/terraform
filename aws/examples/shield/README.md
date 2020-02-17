# Work with AWS Shield via terraform

A terraform module for making AWS Shield.

## Usage
----------------------

Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
    required_version = "~> 0.12.12"

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
    source                          = "../../modules/shield"

    region                          = "us-east-1"

    enable_shield_protection        = true
    shield_protection_name          = "my-first-shield-protection"
    shield_protection_resource_arn  = ""
                        
}
```

Module Input Variables
----------------------

- `name` - Name to be used on all resources as prefix (`default     = "TEST"`).
- `region` - The region where to deploy this code (e.g. us-east-1). (`default     = "us-east-1"`).
- `environment` - Environment for service (`default     = "STAGE"`).
- `enable_shield_protection` - Enable shield protection usage (`default     = false`).
- `shield_protection_name` - A friendly name for the Protection you are creating. (`default     = ""`).
- `shield_protection_resource_arn` - (Required) The ARN (Amazon Resource Name) of the resource to be protected. (`default     = ""`).


Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.
