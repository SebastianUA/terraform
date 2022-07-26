# Work with HEROKU_SPACE via terraform

A terraform module for making HEROKU_SPACE.


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

```

## Module Input Variables
----------------------
- `name` - Set name if some variables will be unset for resources (`default = heroku`)
- `environment` - Set Env name (`default = dev`)
- `enable_space` - Enable Heroku space usage (`default = False`)
- `space_name` - The name of the Private Space. (`default = ""`)
- `space_organization` - (Required) The name of the Heroku Team which will own the Private Space. (`default = ""`)
- `space_cidr` - (Optional) The RFC-1918 CIDR the Private Space will use. It must be a /16 in 10.0.0.0/8, 172.16.0.0/12 or 192.168.0.0/16 (`default = null`)
- `space_data_cidr` - (Optional) The RFC-1918 CIDR that the Private Space will use for the Heroku-managed peering connection that’s automatically created when using Heroku Data add-ons. It must be between a /16 and a /20 (`default = null`)
- `space_region` - (Optional) provision in a specific Private Spaces region. (`default = null`)
- `space_shield` - (Optional) provision as a Shield Private Space. (`default = null`)
- `enable_space_app_access` - Enable Heroku space app access usage (`default = False`)
- `space_app_access_space` - The name of the Private Space. (`default = ""`)
- `space_app_access_email` - (Required) The email of the existing Heroku Team member. (`default = null`)
- `space_app_access_permissions` - (Required) The permissions to grant the team member for the Private Space. Currently create_apps is the only supported permission. If not provided the member will have no permissions to the space. Members with admin role will always have create_apps permissions, which cannot be removed. (`default = []`)
- `enable_space_inbound_ruleset` - Enable Heroku space inbound ruleset usage (`default = False`)
- `space_inbound_ruleset_space` - The UUID of the space. (`default = ""`)
- `space_inbound_ruleset_rule` - (Required) At least one rule block. (`default = []`)
- `enable_space_vpn_connection` - Enable Heroku space vpn connection usage (`default = False`)
- `space_vpn_connection_name` - The name of the VPN connection. (`default = ""`)
- `space_vpn_connection_space` - The UUID of the Heroku Private Space where the VPN connection will be established. (`default = ""`)
- `space_vpn_connection_public_ip` - (Required) The public IP address of the VPN endpoint on the network where the VPN connection will be established. (`default = null`)
- `space_vpn_connection_routable_cidrs` - (Required) A list of IPv4 CIDR blocks used by the network where the VPN connection will be established. (`default = []`)
- `enable_space_peering_connection_accepter` - Enable Heroku space peering connection accepter usage (`default = False`)
- `space_peering_connection_accepter_space` - The UUID of the space. (`default = ""`)
- `space_peering_connection_accepter_vpc_peering_connection_id` - (Required) The peering connection request ID. (`default = null`)

## Module Output Variables
----------------------
- `space_id` - The ID of the space.
- `space_name` - The space's name.
- `space_organization` - The space's Heroku Team.
- `space_region` - The space's region.
- `space_cidr` - The space's CIDR.
- `space_data_cidr` - The space's Data CIDR.
- `space_app_access_id` - ID of space app access
- `space_inbound_ruleset_id` - The ID of the inbound ruleset.
- `space_vpn_connection_id` - The ID of the vpn connection.
- `space_vpn_connection_space_cidr_block` - The CIDR block for the Heroku Private Space. The network where the VPN will be established should be configured to route traffic destined for this CIDR block over the VPN link.
- `space_vpn_connection_ike_version` - The IKE version used to setup the IPsec tunnel.
- `space_peering_connection_accepter_id` - The ID of the peering connection accepter.
- `space_peering_connection_accepter_status` - The status of the peering connection request.
- `space_peering_connection_accepter_type` - The type of the peering connection.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
