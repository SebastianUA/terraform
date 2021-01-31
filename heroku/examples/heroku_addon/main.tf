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

module "heroku_addon" {
  source = "../../modules/heroku_addon"

  # Heroku Addon
  enable_addon = true
  addon_name   = "your-addon"
  addon_app    = "your-app-here"
  addon_plan   = "heroku-postgresql:hobby-basic"

  addon_config = {
    url = "http://google.com"
  }

  # Heroku Addon attachment
  enable_addon_attachment    = true
  addon_attachment_name      = "addon-attach"
  addon_attachment_app_id    = "your-app-id-here"
  addon_attachment_namespace = "credential: cred_name_here"
}
