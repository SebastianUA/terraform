#---------------------------------------------------
# Global
#---------------------------------------------------
variable "name" {
  description = "Set name if some variables will be unset for resources"
  default     = "heroku"
}

variable "environment" {
  description = "Set Env name"
  default     = "dev"
}

#---------------------------------------------------
# Heroku space
#---------------------------------------------------
variable "enable_space" {
  description = "Enable Heroku space usage"
  default     = false
}

variable "space_name" {
  description = "The name of the Private Space."
  default     = ""
}

variable "space_organization" {
  description = "(Required) The name of the Heroku Team which will own the Private Space."
  default     = ""
}

variable "space_cidr" {
  description = "(Optional) The RFC-1918 CIDR the Private Space will use. It must be a /16 in 10.0.0.0/8, 172.16.0.0/12 or 192.168.0.0/16"
  default     = null
}

variable "space_data_cidr" {
  description = "(Optional) The RFC-1918 CIDR that the Private Space will use for the Heroku-managed peering connection that’s automatically created when using Heroku Data add-ons. It must be between a /16 and a /20"
  default     = null
}

variable "space_region" {
  description = "(Optional) provision in a specific Private Spaces region."
  default     = null
}

variable "space_shield" {
  description = "(Optional) provision as a Shield Private Space."
  default     = null
}

#---------------------------------------------------
# Heroku space app access
#---------------------------------------------------
variable "enable_space_app_access" {
  description = "Enable Heroku space app access usage"
  default     = false
}

variable "space_app_access_space" {
  description = "The name of the Private Space."
  default     = ""
}

variable "space_app_access_email" {
  description = "(Required) The email of the existing Heroku Team member."
  default     = null
}

variable "space_app_access_permissions" {
  description = "(Required) The permissions to grant the team member for the Private Space. Currently create_apps is the only supported permission. If not provided the member will have no permissions to the space. Members with admin role will always have create_apps permissions, which cannot be removed."
  default     = []
}

#---------------------------------------------------
# Heroku space inbound ruleset
#---------------------------------------------------
variable "enable_space_inbound_ruleset" {
  description = "Enable Heroku space inbound ruleset usage"
  default     = false
}

variable "space_inbound_ruleset_space" {
  description = "The UUID of the space."
  default     = ""
}

variable "space_inbound_ruleset_rule" {
  description = "(Required) At least one rule block."
  default     = []
}

#---------------------------------------------------
# Heroku space vpn connection
#---------------------------------------------------
variable "enable_space_vpn_connection" {
  description = "Enable Heroku space vpn connection usage"
  default     = false
}

variable "space_vpn_connection_name" {
  description = "The name of the VPN connection."
  default     = ""
}

variable "space_vpn_connection_space" {
  description = "The UUID of the Heroku Private Space where the VPN connection will be established."
  default     = ""
}

variable "space_vpn_connection_public_ip" {
  description = "(Required) The public IP address of the VPN endpoint on the network where the VPN connection will be established."
  default     = null
}

variable "space_vpn_connection_routable_cidrs" {
  description = "(Required) A list of IPv4 CIDR blocks used by the network where the VPN connection will be established."
  default     = []
}

#---------------------------------------------------
# Heroku space peering connection accepter
#---------------------------------------------------
variable "enable_space_peering_connection_accepter" {
  description = "Enable Heroku space peering connection accepter usage"
  default     = false
}

variable "space_peering_connection_accepter_space" {
  description = "The UUID of the space."
  default     = ""
}

variable "space_peering_connection_accepter_vpc_peering_connection_id" {
  description = "(Required) The peering connection request ID."
  default     = null
}
