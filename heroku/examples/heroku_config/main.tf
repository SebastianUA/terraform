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
