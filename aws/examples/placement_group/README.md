# Work with PLACEMENT_GROUP via terraform

A terraform module for making PLACEMENT_GROUP.


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

module "sfn" {
  source      = "../../modules/placement_group"
  name        = "TEST"
  environment = "dev"

  enable_placement_group   = true
  placement_group_name     = ""
  placement_group_strategy = "cluster"


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
- `enable_placement_group` - Enable placement group (`default = False`)
- `placement_group_name` - The name of the placement group. (`default = ""`)
- `placement_group_strategy` - (Required) The placement strategy. Can be 'cluster', 'partition' or 'spread'. (`default = cluster`)

## Module Output Variables
----------------------
- `placement_group_name` - The name of the placement group.
- `placement_group_arn` - Amazon Resource Name (ARN) of the placement group.
- `placement_group_id` - The ID of the placement group.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
