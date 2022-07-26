# Work with PINPOINT via terraform

A terraform module for making PINPOINT.


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

module "pinpoint" {
  source      = "../../modules/pinpoint"
  name        = "TEST"
  environment = "stage"
}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `region` - The region where to deploy this code (e.g. us-east-1). (`default = us-east-1`)
- `environment` - Environment for service (`default = STAGE`)
- `orchestration` - Type of orchestration (`default = Terraform`)
- `createdby` - Created by (`default = Vitaliy Natarov`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)

## Module Output Variables
----------------------
