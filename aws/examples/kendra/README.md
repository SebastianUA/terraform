# Work with KENDRA via terraform

A terraform module for making KENDRA.


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

module "kendra" {
  source = "../../modules/kendra"

  name        = "TEST"
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
- `name` - Name to be used on all resources (`default = TEST`)
- `tags` - A list of tag blocks. Each element should have keys (`default = {}`)

## Module Output Variables
----------------------
