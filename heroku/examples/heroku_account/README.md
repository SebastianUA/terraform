# Work with HEROKU_ACCOUNT via terraform

A terraform module for making HEROKU_ACCOUNT.


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

module "heroku_account" {
  source = "../../modules/heroku_account"

  enable_account_feature  = true
  account_feature_name    = "metrics-request-volume"
  account_feature_enabled = true
}

```

## Module Input Variables
----------------------
- `enable_account_feature` - Enable Heroku account feature usage (`default = False`)
- `account_feature_name` - (Required) Name of the account feature (`default = ""`)
- `account_feature_enabled` - (Required) Enable or disable the account feature (`default = True`)

## Module Output Variables
----------------------
- `heroku_account_feature_id` - Comprised of acount email & feature name
- `heroku_account_feature_description` - Description of account feature
- `heroku_account_feature_state` - State of account feature


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
