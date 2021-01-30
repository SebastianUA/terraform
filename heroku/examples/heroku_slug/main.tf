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

module "heroku_slug" {
  source = "../../modules/heroku_slug"

  enable_slug = true
  slug_app    = "your_app_here"
  slug_process_types = {
    web = "ruby server.rb"
  }
  slug_stack                          = "slug-name"
  slug_buildpack_provided_description = "Ruby"
  slug_file_path                      = null
  # Or:
  slug_file_url = "https://example.com/slugs/app-v1.tgzs"
}
