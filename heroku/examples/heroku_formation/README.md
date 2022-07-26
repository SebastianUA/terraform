# Work with HEROKU_FORMATION via terraform

A terraform module for making HEROKU_FORMATION.


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

module "heroku_formation" {
  source = "../../modules/heroku_formation"

  enable_formation   = true
  formation_app      = "your-app-here"
  formation_type     = "web"
  formation_quantity = 2
  formation_size     = "standard-2x"
}

```

## Module Input Variables
----------------------
- `enable_formation` - Enable Heroku formation usage (`default = False`)
- `formation_app` - (Required) The name of the application (`default = null`)
- `formation_type` - (Required) type of process such as 'web' (`default = null`)
- `formation_quantity` - (Required) number of processes to maintain (`default = null`)
- `formation_size` - (Required) dyno size (Example: “standard-1X”). Capitalization does not matter. (`default = null`)

## Module Output Variables
----------------------
- `formation_id` - Heroku formation ID


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
