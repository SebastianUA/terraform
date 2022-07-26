# Work with HEROKU_DOMAIN via terraform

A terraform module for making HEROKU_DOMAIN.


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

module "heroku_domain" {
  source = "../../modules/heroku_domain"

  enable_domain   = true
  domain_app      = "your-app-here"
  domain_hostname = "terraform.linux-notes.org"
}

```

## Module Input Variables
----------------------
- `enable_domain` - Enable Heroku domain usage (`default = False`)
- `domain_app` - (Required) The Heroku app to link to. (`default = null`)
- `domain_hostname` - (Required) The hostname to serve requests from. (`default = null`)

## Module Output Variables
----------------------
- `domain_id` - The ID of the of the domain record.
- `domain_hostname` - The hostname traffic will be served as.
- `domain_cname` - The CNAME traffic should route to.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
