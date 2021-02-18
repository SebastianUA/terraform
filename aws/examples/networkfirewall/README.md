# Work with AWS mediaconvert via terraform

A terraform module for making mediaconvert.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.13"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "networkfirewall" {
  source      = "../../modules/networkfirewall"
  name        = "TEST"
  environment = "stage"
}
```
