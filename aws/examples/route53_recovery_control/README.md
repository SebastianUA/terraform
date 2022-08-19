# Work with ROUTE53_RECOVERY_CONTROL via terraform

A terraform module for making ROUTE53_RECOVERY_CONTROL.


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
  region = "us-west-2"
}

module "route53_recovery_control" {
  source = "../../modules/route53_recovery_control"

  name        = "TEST-Route53"
  environment = "stage"

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
- `tags` - A list of tag blocks. (`default = {}`)

## Module Output Variables
----------------------
