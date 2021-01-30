#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.13"

  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "~> 2.17.0"
    }
  }
}

provider "heroku" {
  email   = "your_email_here"
  api_key = "api_key_here"

  headers = []

  delays {
    post_app_create_delay    = "5s"
    post_space_create_delay  = "5s"
    post_domain_create_delay = "5s"
  }

  timeouts {
    addon_create_timeout = "20m"
  }
}

module "heroku_collaborator" {
  source = "../../modules/heroku_collaborator"

}
