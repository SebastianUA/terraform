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

module "heroku_space" {
  source = "../../modules/heroku_space"

  # Working with space
  enable_space       = true
  space_name         = "space-name"
  space_organization = "org-name"

  space_region = "virginia"

  # Working with space app access
  enable_space_app_access      = true
  space_app_access_email       = "your_member_email_here"
  space_app_access_permissions = []

  # Working with space inbound ruleset
  enable_space_inbound_ruleset = true
  space_inbound_ruleset_rule = [
    {
      action = "allow"
      source = "0.0.0.0/0"
    },
    {
      action = "deny"
      source = "8.8.4.4/32"
    }
  ]

  # Working with space vpn connection
  enable_space_vpn_connection         = true
  space_vpn_connection_name           = "home"
  space_vpn_connection_public_ip      = "203.0.113.1"
  space_vpn_connection_routable_cidrs = ["192.168.1.0/24"]

  # Working with space peering connection accepter
  enable_space_peering_connection_accepter                    = false
  space_peering_connection_accepter_vpc_peering_connection_id = ""

}
