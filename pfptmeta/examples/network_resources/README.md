# Work with NETWORK_RESOURCES via terraform

A terraform module for making NETWORK_RESOURCES.


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
    pfptmeta = {
      source  = "nsofnetworks/pfptmeta"
      version = "0.1.23"
    }
  }
}

provider "pfptmeta" {
  # Configuration options
}

```

## Module Input Variables
----------------------
