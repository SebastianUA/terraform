# Work with PROJECT via terraform

A terraform module for making PROJECT.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
  required_version = ">= 0.13.0"

  required_providers {
    argocd = {
      source  = "oboukili/argocd"
      version = "0.4.7"
    }
  }
}

provider "argocd" {
  server_addr = "argocd.local:443" # env ARGOCD_SERVER
  auth_token  = "1234..."          # env ARGOCD_AUTH_TOKEN
  # username  = "admin"            # env ARGOCD_AUTH_USERNAME
  # password  = "foo"              # env ARGOCD_AUTH_PASSWORD
  insecure = false # env ARGOCD_INSECURE
}

module "argocd_project" {
  source = "../../modules/project"

}

```

## Module Input Variables
----------------------
- `name` - The name for resources (`default = test`)
- `environment` - The environment for resources (`default = dev`)

## Module Output Variables
----------------------
