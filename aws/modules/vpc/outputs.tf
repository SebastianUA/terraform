#---------------------------------------------------------------
# AWS VPC
#---------------------------------------------------------------
output "vpc_arn" {
  description = "Amazon Resource Name (ARN) of VPC"
  value       = element(concat(aws_vpc.vpc.*.arn, [""]), 0)
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = element(concat(aws_vpc.vpc.*.id, [""]), 0)
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = element(concat(aws_vpc.vpc.*.cidr_block, [""]), 0)
}

output "vpc_instance_tenancy" {
  description = "Tenancy of instances spin up within VPC."
  value       = element(concat(aws_vpc.vpc.*.instance_tenancy, [""]), 0)
}

output "vpc_enable_dns_support" {
  description = "Whether or not the VPC has DNS support"
  value       = element(concat(aws_vpc.vpc.*.enable_dns_support, [""]), 0)
}

output "vpc_enable_dns_hostnames" {
  description = "Whether or not the VPC has DNS hostname support"
  value       = element(concat(aws_vpc.vpc.*.enable_dns_hostnames, [""]), 0)
}

output "vpc_enable_classiclink" {
  description = "Whether or not the VPC has Classiclink enabled"
  value       = element(concat(aws_vpc.vpc.*.enable_classiclink, [""]), 0)
}

output "vpc_main_route_table_id" {
  description = "The ID of the main route table associated with this VPC. Note that you can change a VPC's main route table by using an aws_main_route_table_association."
  value       = element(concat(aws_vpc.vpc.*.main_route_table_id, [""]), 0)
}

output "vpc_default_network_acl_id" {
  description = "The ID of the network ACL created by default on VPC creation"
  value       = element(concat(aws_vpc.vpc.*.default_network_acl_id, [""]), 0)
}

output "vpc_default_security_group_id" {
  description = "The ID of the security group created by default on VPC creation"
  value       = element(concat(aws_vpc.vpc.*.default_security_group_id, [""]), 0)
}

output "vpc_default_route_table_id" {
  description = "The ID of the route table created by default on VPC creation"
  value       = element(concat(aws_vpc.vpc.*.default_route_table_id, [""]), 0)
}

output "vpc_ipv6_association_id" {
  description = "The association ID for the IPv6 CIDR block."
  value       = element(concat(aws_vpc.vpc.*.ipv6_association_id, [""]), 0)
}

output "vpc_ipv6_cidr_block" {
  description = "The IPv6 CIDR block."
  value       = element(concat(aws_vpc.vpc.*.ipv6_cidr_block, [""]), 0)
}

output "vpc_owner_id" {
  description = "The ID of the AWS account that owns the VPC."
  value       = element(concat(aws_vpc.vpc.*.id, [""]), 0)
}

#---------------------------------------------------------------
# AWS subnets
#---------------------------------------------------------------
output "private_subnets_id" {
  description = "The ID of the subnet"
  value       = element(concat(aws_subnet.private_subnets.*.id, [""]), 0)
}

output "private_subnets_ids" {
  description = "The IDs of the subnet"
  value       = aws_subnet.private_subnets.*.id
}

output "k8s_private_subnets_ids" {
  description = "The IDs of the subnet"
  value       = aws_subnet.k8s_private_subnets.*.id
}

output "private_subnets_arn" {
  description = "The ARN of the subnet."
  value       = element(concat(aws_subnet.private_subnets.*.arn, [""]), 0)
}

output "private_subnets_owner_id" {
  description = "The ID of the AWS account that owns the subnet."
  value       = element(concat(aws_subnet.private_subnets.*.owner_id, [""]), 0)
}

output "public_subnets_id" {
  description = "The ID of the subnet"
  value       = element(concat(aws_subnet.public_subnets.*.id, [""]), 0)
}

output "public_subnets_ids" {
  description = "The IDs of the subnet"
  value       = aws_subnet.public_subnets.*.id
}

output "k8s_public_subnets_ids" {
  description = "The IDs of the subnet"
  value       = aws_subnet.k8s_public_subnets.*.id
}

output "public_subnets_arn" {
  description = "The ARN of the subnet."
  value       = element(concat(aws_subnet.public_subnets.*.arn, [""]), 0)
}

output "public_subnets_owner_id" {
  description = "The ID of the AWS account that owns the subnet."
  value       = element(concat(aws_subnet.public_subnets.*.owner_id, [""]), 0)
}

#---------------------------------------------------------------
# AWS Internet gateway (IGW)
#---------------------------------------------------------------
output "internet_gateway_id" {
  description = "The ID of the Internet Gateway."
  value       = element(concat(aws_internet_gateway.internet_gateway.*.id, [""]), 0)
}

output "internet_gateway_arn" {
  description = "The ARN of the Internet Gateway."
  value       = element(concat(aws_internet_gateway.internet_gateway.*.arn, [""]), 0)
}

output "internet_gateway_owner_id" {
  description = "The ID of the AWS account that owns the internet gateway."
  value       = element(concat(aws_internet_gateway.internet_gateway.*.owner_id, [""]), 0)
}

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

#---------------------------------------------------------------
# AWS DHCP
#---------------------------------------------------------------
output "vpc_dhcp_options_id" {
  description = "The ID of the DHCP Options Set."
  value       = element(concat(aws_vpc_dhcp_options.vpc_dhcp_options.*.id, [""]), 0)
}

output "vpc_dhcp_options_owner_id" {
  description = "The ID of the AWS account that owns the DHCP options set."
  value       = element(concat(aws_vpc_dhcp_options.vpc_dhcp_options.*.owner_id, [""]), 0)
}

#---------------------------------------------------------------
# DHCP Options Set Association
#---------------------------------------------------------------
output "vpc_dhcp_options_association_id" {
  description = "The ID of the DHCP Options Set Association."
  value       = element(concat(aws_vpc_dhcp_options_association.vpc_dhcp_options_association.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS NAT gw
#---------------------------------------------------
output "nat_gateway_id" {
  description = "The ID of the NAT Gateway."
  value       = element(concat(aws_nat_gateway.nat_gateway.*.id, [""]), 0)
}

output "nat_gateway_allocation_id" {
  description = "The Allocation ID of the Elastic IP address for the gateway."
  value       = element(concat(aws_nat_gateway.nat_gateway.*.allocation_id, [""]), 0)
}

output "nat_gateway_subnet_id" {
  description = "The Subnet ID of the subnet in which the NAT gateway is placed."
  value       = element(concat(aws_nat_gateway.nat_gateway.*.subnet_id, [""]), 0)
}

output "nat_gateway_network_interface_id" {
  description = "The ENI ID of the network interface created by the NAT gateway."
  value       = element(concat(aws_nat_gateway.nat_gateway.*.network_interface_id, [""]), 0)
}

output "nat_gateway_private_ip" {
  description = "The private IP address of the NAT Gateway."
  value       = element(concat(aws_nat_gateway.nat_gateway.*.private_ip, [""]), 0)
}

output "nat_gateway_public_ip" {
  description = "The public IP address of the NAT Gateway."
  value       = element(concat(aws_nat_gateway.nat_gateway.*.public_ip, [""]), 0)
}

#---------------------------------------------------
# AWS EIP
#---------------------------------------------------
output "nat_eip_id" {
  description = "The ID of the NAT Gateway."
  value       = element(concat(aws_eip.nat_eip.*.id, [""]), 0)
}

output "nat_eip_vpc" {
  description = "(Optional) Boolean if the EIP is in a VPC or not."
  value       = element(concat(aws_eip.nat_eip.*.vpc, [""]), 0)
}

output "nat_eip_instance" {
  description = "(Optional) EC2 instance ID."
  value       = element(concat(aws_eip.nat_eip.*.instance, [""]), 0)
}

output "nat_eip_network_interface" {
  description = "(Optional) Network interface ID to associate with."
  value       = element(concat(aws_eip.nat_eip.*.network_interface, [""]), 0)
}

output "nat_eip_associate_with_private_ip" {
  description = "(Optional) A user specified primary or secondary private IP address to associate with the Elastic IP address. If no private IP address is specified, the Elastic IP address is associated with the primary private IP address."
  value       = element(concat(aws_eip.nat_eip.*.associate_with_private_ip, [""]), 0)
}

output "nat_eip_tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  value       = aws_eip.nat_eip.*.tags
}

output "nat_eip_public_ipv4_pool" {
  description = "(Optional) EC2 IPv4 address pool identifier or amazon. This option is only available for VPC EIPs."
  value       = element(concat(aws_eip.nat_eip.*.public_ipv4_pool, [""]), 0)
}

#---------------------------------------------------
# AWS Route
#---------------------------------------------------
output "private_nat_gateway_id" {
  description = "Route Table identifier and destination"
  value       = element(concat(aws_route.private_nat_gateway.*.id, [""]), 0)
}

output "public_internet_gateway_id" {
  description = "Route Table identifier and destination"
  value       = element(concat(aws_route.public_internet_gateway.*.id, [""]), 0)
}

output "private_custom_route_id" {
  description = "Route Table identifier and destination for private custom route"
  value       = element(concat(aws_route.private_custom_route.*.id, [""]), 0)
}

output "public_custom_route_id" {
  description = "Route Table identifier and destination for public custom route"
  value       = element(concat(aws_route.public_custom_route.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS Route table
#---------------------------------------------------
output "private_route_tables_id" {
  description = "The ID of the routing table."
  value       = element(concat(aws_route_table.private_route_tables.*.id, [""]), 0)
}

output "private_route_tables_owner_id" {
  description = "The ID of the AWS account that owns the route table."
  value       = element(concat(aws_route_table.private_route_tables.*.owner_id, [""]), 0)
}

output "public_route_tables_id" {
  description = "The ID of the routing table."
  value       = element(concat(aws_route_table.public_route_tables.*.id, [""]), 0)
}

output "public_route_tables_owner_id" {
  description = "The ID of the AWS account that owns the route table."
  value       = element(concat(aws_route_table.public_route_tables.*.owner_id, [""]), 0)
}

# K8S
output "k8s_private_route_tables_id" {
  description = "The ID of the routing table of K8S."
  value       = element(concat(aws_route_table.k8s_private_route_tables.*.id, [""]), 0)
}

output "k8s_public_route_tables_id" {
  description = "The ID of the routing table of K8S."
  value       = element(concat(aws_route_table.k8s_public_route_tables.*.id, [""]), 0)
}

#---------------------------------------------------
# Route Table Associations
#---------------------------------------------------
output "private_route_table_associations_ids" {
  description = "The IDs of the private association"
  value       = aws_route_table_association.private_route_table_associations.*.id
}

output "public_route_table_associations_ids" {
  description = "The IDs of the public association"
  value       = aws_route_table_association.public_route_table_associations.*.id
}

output "custom_route_table_associations_ids" {
  description = "The IDs of the custom association"
  value       = aws_route_table_association.custom_route_table_associations.*.id
}

#---------------------------------------------------
# AWS VPC flow log
#---------------------------------------------------
output "flow_log_id" {
  description = "The Flow Log ID"
  value       = element(concat(aws_flow_log.flow_log.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS VPC network acl
#---------------------------------------------------
output "network_acl_id" {
  description = "The ID of the network ACL"
  value       = element(concat(aws_network_acl.network_acl.*.id, [""]), 0)
}

output "network_acl_owner_id" {
  description = "The ID of the AWS account that owns the network ACL."
  value       = element(concat(aws_network_acl.network_acl.*.owner_id, [""]), 0)
}

#---------------------------------------------------
# AWS VPC network acl rule
#---------------------------------------------------
output "network_acl_rule_id" {
  description = "The ID of the network ACL Rule"
  value       = element(concat(aws_network_acl_rule.network_acl_rule.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS VPC ipv4 cidr block association
#---------------------------------------------------
output "vpc_ipv4_cidr_block_association_id" {
  description = "The ID of the VPC CIDR association"
  value       = element(concat(aws_vpc_ipv4_cidr_block_association.vpc_ipv4_cidr_block_association.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS egress only internet gateway
#---------------------------------------------------
output "egress_only_internet_gateway_id" {
  description = "The ID of the egress-only Internet gateway."
  value       = element(concat(aws_egress_only_internet_gateway.egress_only_internet_gateway.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS VPC main route table association
#---------------------------------------------------
output "main_route_table_association_id" {
  description = "The ID of the Route Table Association"
  value       = element(concat(aws_main_route_table_association.main_route_table_association.*.id, [""]), 0)
}

output "main_route_table_association_original_route_table_id" {
  description = "Used internally"
  value       = element(concat(aws_main_route_table_association.main_route_table_association.*.original_route_table_id, [""]), 0)
}

#---------------------------------------------------
# AWS VPC peering connection
#---------------------------------------------------
output "vpc_peering_connection_id" {
  description = "The ID of the VPC Peering Connection."
  value       = element(concat(aws_vpc_peering_connection.vpc_peering_connection.*.id, [""]), 0)
}

output "vpc_peering_connection_accept_status" {
  description = "The status of the VPC Peering Connection request."
  value       = element(concat(aws_vpc_peering_connection.vpc_peering_connection.*.accept_status, [""]), 0)
}

#---------------------------------------------------
# AWS VPC peering connection options
#---------------------------------------------------
output "vpc_peering_connection_options_id" {
  description = "The ID of the VPC Peering Connection Options."
  value       = element(concat(aws_vpc_peering_connection_options.vpc_peering_connection_options.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS VPC peering connection accepter
#---------------------------------------------------
output "vpc_peering_connection_accepter_id" {
  description = "The ID of the VPC Peering Connection."
  value       = element(concat(aws_vpc_peering_connection_accepter.vpc_peering_connection_accepter.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS VPC endpoint subnet association
#---------------------------------------------------
// output "vpc_endpoint_subnet_association_ids" {
//   description = "The ID of the association."
//   value       = aws_vpc_endpoint_subnet_association.vpc_endpoint_subnet_association.*.id, [""])
// }

#---------------------------------------------------
# AWS VPC endpoint service
#---------------------------------------------------
output "vpc_endpoint_service_id" {
  description = "The ID of the VPC endpoint service."
  value       = element(concat(aws_vpc_endpoint_service.vpc_endpoint_service.*.id, [""]), 0)
}

output "vpc_endpoint_service_availability_zones" {
  description = "The Availability Zones in which the service is available."
  value       = element(concat(aws_vpc_endpoint_service.vpc_endpoint_service.*.availability_zones, [""]), 0)
}

output "vpc_endpoint_service_base_endpoint_dns_names" {
  description = "The DNS names for the service."
  value       = element(concat(aws_vpc_endpoint_service.vpc_endpoint_service.*.base_endpoint_dns_names, [""]), 0)
}

output "vpc_endpoint_service_manages_vpc_endpoints" {
  description = "Whether or not the service manages its VPC endpoints - true or false."
  value       = element(concat(aws_vpc_endpoint_service.vpc_endpoint_service.*.manages_vpc_endpoints, [""]), 0)
}

output "vpc_endpoint_service_private_dns_name" {
  description = "The private DNS name for the service."
  value       = element(concat(aws_vpc_endpoint_service.vpc_endpoint_service.*.private_dns_name, [""]), 0)
}

output "vpc_endpoint_service_service_name" {
  description = "The service name."
  value       = element(concat(aws_vpc_endpoint_service.vpc_endpoint_service.*.service_name, [""]), 0)
}

output "vpc_endpoint_service_service_type" {
  description = "The service type, Gateway or Interface."
  value       = element(concat(aws_vpc_endpoint_service.vpc_endpoint_service.*.service_type, [""]), 0)
}

output "vpc_endpoint_service_state" {
  description = "The state of the VPC endpoint service."
  value       = element(concat(aws_vpc_endpoint_service.vpc_endpoint_service.*.state, [""]), 0)
}

#---------------------------------------------------
# AWS VPC endpoint service allowed principal
#---------------------------------------------------
output "vpc_endpoint_service_allowed_principal_id" {
  description = "The ID of the association."
  value       = aws_vpc_endpoint_service_allowed_principal.vpc_endpoint_service_allowed_principal.*.id
}

#---------------------------------------------------
# AWS VPC endpoint route table association
#---------------------------------------------------
// output "vpc_endpoint_route_table_association_ids" {
//   description = "A hash of the EC2 Route Table and VPC Endpoint identifiers."
//   value       = aws_vpc_endpoint_route_table_association.vpc_endpoint_route_table_association.*.id
// }

#---------------------------------------------------
# AWS VPC endpoint connection notification
#---------------------------------------------------
output "vpc_endpoint_connection_notification_id" {
  description = "The ID of the VPC connection notification."
  value       = element(concat(aws_vpc_endpoint_connection_notification.vpc_endpoint_connection_notification.*.id, [""]), 0)
}

output "vpc_endpoint_connection_notification_state" {
  description = "The state of the notification."
  value       = element(concat(aws_vpc_endpoint_connection_notification.vpc_endpoint_connection_notification.*.state, [""]), 0)
}

output "vpc_endpoint_connection_notification_notification_type" {
  description = "The type of notification."
  value       = element(concat(aws_vpc_endpoint_connection_notification.vpc_endpoint_connection_notification.*.notification_type, [""]), 0)
}

#---------------------------------------------------
# AWS VPC endpoint
#---------------------------------------------------
output "vpc_endpoint_id" {
  description = "The ID of the VPC endpoint."
  value       = element(concat(aws_vpc_endpoint.vpc_endpoint.*.id, [""]), 0)
}

output "vpc_endpoint_arn" {
  description = "The Amazon Resource Name (ARN) of the VPC endpoint."
  value       = element(concat(aws_vpc_endpoint.vpc_endpoint.*.arn, [""]), 0)
}

output "vpc_endpoint_cidr_blocks" {
  description = "The list of CIDR blocks for the exposed AWS service. Applicable for endpoints of type Gateway."
  value       = concat(aws_vpc_endpoint.vpc_endpoint.*.cidr_blocks, [""])
}

output "vpc_endpoint_dns_entry" {
  description = "The DNS entries for the VPC Endpoint. Applicable for endpoints of type Interface."
  value       = concat(aws_vpc_endpoint.vpc_endpoint.*.dns_entry, [""])
}

output "vpc_endpoint_network_interface_ids" {
  description = "One or more network interfaces for the VPC Endpoint. Applicable for endpoints of type Interface."
  value       = concat(aws_vpc_endpoint.vpc_endpoint.*.network_interface_ids, [""])
}

output "vpc_endpoint_owner_id" {
  description = "The ID of the AWS account that owns the VPC endpoint."
  value       = element(concat(aws_vpc_endpoint.vpc_endpoint.*.owner_id, [""]), 0)
}

output "vpc_endpoint_prefix_list_id" {
  description = "The prefix list ID of the exposed AWS service. Applicable for endpoints of type Gateway."
  value       = concat(aws_vpc_endpoint.vpc_endpoint.*.prefix_list_id, [""])
}

output "vpc_endpoint_requester_managed" {
  description = "Whether or not the VPC Endpoint is being managed by its service - true or false."
  value       = element(concat(aws_vpc_endpoint.vpc_endpoint.*.requester_managed, [""]), 0)
}

output "vpc_endpoint_state" {
  description = "The state of the VPC endpoint."
  value       = concat(aws_vpc_endpoint.vpc_endpoint.*.id, [""])
}

// output "vpc_endpoint_tags_all" {
//   description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
//   value       = concat(aws_vpc_endpoint.vpc_endpoint.*.tags_all, [""])
// }