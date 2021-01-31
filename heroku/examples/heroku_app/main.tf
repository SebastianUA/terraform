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

module "heroku_app" {
  source = "../../modules/heroku_app"

  # Heroku app
  enable_app = true
  app_name   = "your-app-here"
  app_region = "us"

  app_buildpacks = [
    "heroku/go"
  ]

  app_config_vars = {
    FOOBAR = "baz"
  }

  app_sensitive_config_vars = {
    FOOBAR2 = "baz2"
  }

  app_organization = [
    {
      name = "my-cool-team"
    }
  ]

  # Heroku app config association
  enable_app_config_association         = false
  app_config_association_vars           = {}
  app_config_association_sensitive_vars = {}

  # Heroku app release
  enable_app_release      = true
  app_release_slug_id     = "01234567-89ab-cdef-0123-456789abcdef"
  app_release_description = ""

  # Heroku app feature
  enable_app_feature = false
  app_feature_app    = "test-app"
  app_feature_name   = "your-feature-app-name"

  # Heroku app webhook
  enable_app_webhook  = true
  app_webhook_level   = "notify"
  app_webhook_url     = "https://example.com/heroku_webhook"
  app_webhook_include = ["api:release"]

  app_webhook_secret        = null
  app_webhook_authorization = null
}
