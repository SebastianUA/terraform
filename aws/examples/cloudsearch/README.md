# Work with CLOUDSEARCH via terraform

A terraform module for making CLOUDSEARCH.


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
  region                   = "us-east-1"
  shared_credentials_files = [pathexpand("~/.aws/credentials")]
  profile                  = "default"

}

module "cloudsearch" {
  source      = "../../modules/cloudsearch"
  name        = ""
  environment = "staging"

  tags = tomap({
    "Environment" = "dev",
    "Createdby"   = "Vitaliy Natarov"
  })

}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - Add additional tags (`default = {}`)

## Module Output Variables
----------------------
