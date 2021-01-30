#---------------------------------------------------
# Heroku team collaborator
#---------------------------------------------------
output "space_id" {
  description = "The ID of the space."
  value       = heroku_space.space.*.id
}

output "space_name" {
  description = "The space's name."
  value       = heroku_space.space.*.name
}

output "space_organization" {
  description = "The space's Heroku Team."
  value       = heroku_space.space.*.organization
}

output "space_region" {
  description = "The space's region."
  value       = heroku_space.space.*.region
}

output "space_cidr" {
  description = "The space's CIDR."
  value       = heroku_space.space.*.cidr
}

output "space_data_cidr" {
  description = "The space's Data CIDR."
  value       = heroku_space.space.*.data_cidr
}

// output "space_outbound_ips" {
//   description = "The space's stable outbound NAT IPs."
//   value       = heroku_space.space.*.outbound_ips
// }

#---------------------------------------------------
# Heroku space app access
#---------------------------------------------------
output "space_app_access_id" {
  description = "ID of space app access"
  value       = heroku_space_app_access.space_app_access.*.id
}

#---------------------------------------------------
# Heroku space inbound ruleset
#---------------------------------------------------
output "space_inbound_ruleset_id" {
  description = "The ID of the inbound ruleset."
  value       = heroku_space_inbound_ruleset.space_inbound_ruleset.*.id
}

#---------------------------------------------------
# Heroku space vpn connection
#---------------------------------------------------
output "space_vpn_connection_id" {
  description = "The ID of the vpn connection."
  value       = heroku_space_vpn_connection.space_vpn_connection.*.id
}

output "space_vpn_connection_space_cidr_block" {
  description = "The CIDR block for the Heroku Private Space. The network where the VPN will be established should be configured to route traffic destined for this CIDR block over the VPN link."
  value       = heroku_space_vpn_connection.space_vpn_connection.*.space_cidr_block
}

output "space_vpn_connection_ike_version" {
  description = "The IKE version used to setup the IPsec tunnel."
  value       = heroku_space_vpn_connection.space_vpn_connection.*.ike_version
}

#---------------------------------------------------
# Heroku space peering connection accepter
#---------------------------------------------------
output "space_peering_connection_accepter_id" {
  description = "The ID of the peering connection accepter."
  value       = heroku_space_peering_connection_accepter.space_peering_connection_accepter.*.id
}

output "space_peering_connection_accepter_status" {
  description = "The status of the peering connection request."
  value       = heroku_space_peering_connection_accepter.space_peering_connection_accepter.*.status
}

output "space_peering_connection_accepter_type" {
  description = "The type of the peering connection."
  value       = heroku_space_peering_connection_accepter.space_peering_connection_accepter.*.type
}
