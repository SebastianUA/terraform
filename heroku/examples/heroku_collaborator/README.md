# Work with HEROKU_COLLABORATOR via terraform

A terraform module for making HEROKU_COLLABORATOR.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.13"

  required_providers {
    heroku = {
      source  = "heroku/heroku"
      version = "~> 3.2.0"
    }
  }
}

provider "heroku" {
  email   = null
  api_key = null

  headers = null

  delays {
    post_app_create_delay    = 5
    post_space_create_delay  = 5
    post_domain_create_delay = 5
  }

  timeouts {
    addon_create_timeout = 20
  }
}

module "heroku_collaborator" {
  source = "../../modules/heroku_collaborator"

  enable_collaborator = true
  collaborator_app    = "your-app-here"
  collaborator_email  = "solo.metal@bigmir.net"
}

```

## Module Input Variables
----------------------
- `enable_collaborator` - Enable Heroku collaborator usage (`default = False`)
- `collaborator_app` - (Required) The name of the app that the collaborator will be added to. (`default = null`)
- `collaborator_email` - (Required) Email address of the collaborator (`default = null`)

## Module Output Variables
----------------------
- `collaborator_id` - The ID of the collaborator.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
