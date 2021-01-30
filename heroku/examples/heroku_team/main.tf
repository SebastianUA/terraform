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

module "team_collaborator" {
  source = "../../modules/heroku_team"

  enable_team_collaborator      = true
  team_collaborator_app         = "your_app_here"
  team_collaborator_email       = "your_email_here"
  team_collaborator_permissions = ["view", "operate", "manage"]
}

module "team_member" {
  source = "../../modules/heroku_team"

  enable_team_member = true
  team_member_team   = ""
  team_member_email  = "your_email_here"
  team_member_role   = "member"
}