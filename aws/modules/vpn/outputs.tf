#---------------------------------------------------------------
# AWS VPN gateway
#---------------------------------------------------------------
output "vpn_gateway_id" {
  description = "The ID of the VPN Gateway."
  value       = element(concat(aws_vpn_gateway.vpn_gateway.*.id, [""]), 0)
}

#---------------------------------------------------------------
# AWS VPN gateway attachment
#---------------------------------------------------------------
output "vpn_gateway_attachment_id" {
  description = "The ID of the VPN Gateway attachment."
  value       = element(concat(aws_vpn_gateway_attachment.vpn_gateway_attachment.*.id, [""]), 0)
}

output "vpn_gateway_attachment_vpc_id" {
  description = "The ID of the VPC that Virtual Private Gateway is attached to."
  value       = element(concat(aws_vpn_gateway_attachment.vpn_gateway_attachment.*.vpc_id, [""]), 0)
}

output "vpn_gateway_attachment_vpn_gateway_id" {
  description = "The ID of the Virtual Private Gateway."
  value       = element(concat(aws_vpn_gateway_attachment.vpn_gateway_attachment.*.vpn_gateway_id, [""]), 0)
}

#---------------------------------------------------------------
# AWS VPN gateway route propagation
#---------------------------------------------------------------
output "vpn_gateway_route_propagation_id" {
  description = "The ID of the VPN Gateway route propagation."
  value       = element(concat(aws_vpn_gateway_route_propagation.vpn_gateway_route_propagation.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS VPN connection
#---------------------------------------------------
output "vpn_connection_id" {
  description = "The amazon-assigned ID of the VPN connection."
  value       = element(concat(aws_vpn_connection.vpn_connection.*.id, [""]), 0)
}

output "vpn_connection_customer_gateway_configuration" {
  description = "The configuration information for the VPN connection's customer gateway (in the native XML format)."
  value       = element(concat(aws_vpn_connection.vpn_connection.*.customer_gateway_configuration, [""]), 0)
}

output "vpn_connection_customer_gateway_id" {
  description = "The ID of the customer gateway to which the connection is attached."
  value       = element(concat(aws_vpn_connection.vpn_connection.*.customer_gateway_id, [""]), 0)
}

output "vpn_connection_static_routes_only" {
  description = "Whether the VPN connection uses static routes exclusively."
  value       = element(concat(aws_vpn_connection.vpn_connection.*.static_routes_only, [""]), 0)
}

output "vpn_connection_tags" {
  description = "Tags applied to the connection."
  value       = concat(aws_vpn_connection.vpn_connection.*.tags, [""])
}

output "vpn_connection_transit_gateway_attachment_id" {
  description = "When associated with an EC2 Transit Gateway (transit_gateway_id argument), the attachment ID."
  value       = element(concat(aws_vpn_connection.vpn_connection.*.transit_gateway_attachment_id, [""]), 0)
}

output "vpn_connection_tunnel1_address" {
  description = "The public IP address of the first VPN tunnel."
  value       = element(concat(aws_vpn_connection.vpn_connection.*.tunnel1_address, [""]), 0)
}

output "vpn_connection_tunnel1_cgw_inside_address" {
  description = "The RFC 6890 link-local address of the first VPN tunnel (Customer Gateway Side)."
  value       = element(concat(aws_vpn_connection.vpn_connection.*.tunnel1_cgw_inside_address, [""]), 0)
}

output "vpn_connection_tunnel1_vgw_inside_address" {
  description = "The RFC 6890 link-local address of the first VPN tunnel (VPN Gateway Side)."
  value       = element(concat(aws_vpn_connection.vpn_connection.*.tunnel1_vgw_inside_address, [""]), 0)
}

output "vpn_connection_tunnel1_preshared_key" {
  description = "The preshared key of the first VPN tunnel."
  value       = element(concat(aws_vpn_connection.vpn_connection.*.tunnel1_preshared_key, [""]), 0)
}

output "vpn_connection_tunnel1_bgp_asn" {
  description = "The bgp asn number of the first VPN tunnel."
  value       = element(concat(aws_vpn_connection.vpn_connection.*.tunnel1_bgp_asn, [""]), 0)
}

output "vpn_connection_tunnel1_bgp_holdtime" {
  description = "The bgp holdtime of the first VPN tunnel."
  value       = element(concat(aws_vpn_connection.vpn_connection.*.tunnel1_bgp_holdtime, [""]), 0)
}

output "vpn_connection_tunnel2_address" {
  description = "The public IP address of the second VPN tunnel."
  value       = element(concat(aws_vpn_connection.vpn_connection.*.tunnel2_address, [""]), 0)
}

output "vpn_connection_tunnel2_cgw_inside_address" {
  description = "The RFC 6890 link-local address of the second VPN tunnel (Customer Gateway Side)."
  value       = element(concat(aws_vpn_connection.vpn_connection.*.tunnel2_cgw_inside_address, [""]), 0)
}

output "vpn_connection_tunnel2_vgw_inside_address" {
  description = "The RFC 6890 link-local address of the second VPN tunnel (VPN Gateway Side)."
  value       = element(concat(aws_vpn_connection.vpn_connection.*.tunnel2_vgw_inside_address, [""]), 0)
}

output "vpn_connection_tunnel2_preshared_key" {
  description = "The preshared key of the second VPN tunnel."
  value       = element(concat(aws_vpn_connection.vpn_connection.*.tunnel2_preshared_key, [""]), 0)
}

output "vpn_connection_tunnel2_bgp_asn" {
  description = "The bgp asn number of the second VPN tunnel."
  value       = element(concat(aws_vpn_connection.vpn_connection.*.tunnel2_bgp_asn, [""]), 0)
}

output "vpn_connection_tunnel2_bgp_holdtime" {
  description = "The bgp holdtime of the second VPN tunnel."
  value       = element(concat(aws_vpn_connection.vpn_connection.*.tunnel2_bgp_holdtime, [""]), 0)
}

output "vpn_connection_type" {
  description = "The type of VPN connection."
  value       = element(concat(aws_vpn_connection.vpn_connection.*.type, [""]), 0)
}

output "vpn_connection_vpn_gateway_id" {
  description = "The ID of the virtual private gateway to which the connection is attached."
  value       = element(concat(aws_vpn_connection.vpn_connection.*.vpn_gateway_id, [""]), 0)
}

#---------------------------------------------------
# AWS VPN connection route
#---------------------------------------------------
output "vpn_connection_route_destination_cidr_block" {
  description = "The CIDR block associated with the local subnet of the customer network."
  value       = element(concat(aws_vpn_connection_route.vpn_connection_route.*.destination_cidr_block, [""]), 0)
}

output "vpn_connection_route_vpn_connection_id" {
  description = "The ID of the VPN connection."
  value       = element(concat(aws_vpn_connection_route.vpn_connection_route.*.vpn_connection_id, [""]), 0)
}

#---------------------------------------------------
# AWS customer gateway
#---------------------------------------------------
output "customer_gateway_id" {
  description = "The amazon-assigned ID of the gateway."
  value       = element(concat(aws_customer_gateway.customer_gateway.*.id, [""]), 0)
}

output "customer_gateway_bgp_asn" {
  description = "The gateway's Border Gateway Protocol (BGP) Autonomous System Number (ASN)."
  value       = element(concat(aws_customer_gateway.customer_gateway.*.bgp_asn, [""]), 0)
}

output "customer_gateway_ip_address" {
  description = "The IP address of the gateway's Internet-routable external interface."
  value       = element(concat(aws_customer_gateway.customer_gateway.*.ip_address, [""]), 0)
}

output "customer_gateway_type" {
  description = "The type of customer gateway."
  value       = element(concat(aws_customer_gateway.customer_gateway.*.type, [""]), 0)
}

output "customer_gateway_tags" {
  description = "Tags applied to the gateway."
  value       = concat(aws_customer_gateway.customer_gateway.*.tags, [""])
}