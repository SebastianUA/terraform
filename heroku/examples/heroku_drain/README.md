# Work with HEROKU_DRAIN via terraform

A terraform module for making HEROKU_DRAIN.


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

module "heroku_drain" {
  source = "../../modules/heroku_drain"

  enable_drain = true
  drain_app    = "your-app-here"
  drain_url    = "syslog://terraform.example.com:1234"
}

```

## Module Input Variables
----------------------
- `enable_drain` - Enable Heroku drain usage (`default = False`)
- `drain_app` - (Required) The URL for Heroku to drain your logs to. (`default = null`)
- `drain_url` - (Required) The Heroku app to link to. (`default = null`)

## Module Output Variables
----------------------
- `drain_id` - The ID of token
- `drain_token` - The unique token for your created drain.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
