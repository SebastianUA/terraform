# Work with HEROKU_CONFIG via terraform

A terraform module for making HEROKU_CONFIG.


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

module "heroku_config" {
  source = "../../modules/heroku_config"

  enable_config = true

  config_vars = {
    x = "https://..."
    y = "https://..."
    z = "https://..."
  }

  config_sensitive_vars = {
    PRIVATE_KEY = "some_private_key"
  }
}

```

## Module Input Variables
----------------------
- `enable_config` - Enable Heroku config usage (`default = False`)
- `config_vars` - Map of vars that are can be outputted in plaintext. (`default = null`)
- `config_sensitive_vars` - This is the same as vars. The main difference between the two attributes is sensitive_vars outputs are redacted on-screen and replaced by a <sensitive> placeholder, following a terraform plan or apply. It is recommended to put private keys, passwords, etc in this argument. (`default = null`)

## Module Output Variables
----------------------
- `config_id` - The ID of the config.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
