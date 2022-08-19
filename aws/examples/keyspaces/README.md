# Work with KEYSPACES via terraform

A terraform module for making KEYSPACES.


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
  shared_credentials_file = pathexpand("/Users/captain/.aws/credentials")
  profile                 = "default"

}

module "keyspaces" {
  source      = "../../modules/keyspaces"
  name        = "keyspaces"
  environment = "staging"

  tags = tomap({
    "Environment" = "dev",
    "Createdby"   = "Vitaliy Natarov"
  })

}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources (`default = TEST`)
- `tags` - A list of tag blocks. Each element should have keys (`default = {}`)

## Module Output Variables
----------------------
