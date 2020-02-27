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
    value       = element(concat(aws_vpc.vpc.*.id, [""]), 0)
}

output "private_subnets_arn" {
    description = "The ARN of the subnet."
    value       = element(concat(aws_vpc.vpc.*.arn, [""]), 0)
}

output "private_subnets_owner_id" {
    description = "The ID of the AWS account that owns the subnet."
    value       = element(concat(aws_vpc.vpc.*.owner_id, [""]), 0)
}

output "public_subnets_id" {
    description = "The ID of the subnet"
    value       = element(concat(aws_vpc.vpc.*.id, [""]), 0)
}

output "public_subnets_arn" {
    description = "The ARN of the subnet."
    value       = element(concat(aws_vpc.vpc.*.arn, [""]), 0)
}

output "public_subnets_owner_id" {
    description = "The ID of the AWS account that owns the subnet."
    value       = element(concat(aws_vpc.vpc.*.owner_id, [""]), 0)
}

#---------------------------------------------------------------
# AWS VPN gateway
#---------------------------------------------------------------
output "vpn_gw_id" {
    description = "The ID of the VPN Gateway."
    value       = element(concat(aws_vpn_gateway.vpn_gw.*.id, [""]), 0)
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
output "nat_gw_id" {
    description = "The ID of the NAT Gateway."
    value       = element(concat(aws_nat_gateway.nat_gw.*.id, [""]), 0)
}

output "nat_gw_allocation_id" {
    description = "The Allocation ID of the Elastic IP address for the gateway."
    value       = element(concat(aws_nat_gateway.nat_gw.*.allocation_id, [""]), 0)
}

output "nat_gw_subnet_id" {
    description = "The Subnet ID of the subnet in which the NAT gateway is placed."
    value       = element(concat(aws_nat_gateway.nat_gw.*.subnet_id, [""]), 0)
}

output "nat_gw_network_interface_id" {
    description = "The ENI ID of the network interface created by the NAT gateway."
    value       = element(concat(aws_nat_gateway.nat_gw.*.network_interface_id, [""]), 0)
}

output "nat_gw_private_ip" {
    description = "The private IP address of the NAT Gateway."
    value       = element(concat(aws_nat_gateway.nat_gw.*.private_ip, [""]), 0)
}

output "nat_gw_public_ip" {
    description = "The public IP address of the NAT Gateway."
    value       = element(concat(aws_nat_gateway.nat_gw.*.public_ip, [""]), 0)
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

#---------------------------------------------------
# Route Table Associations
#---------------------------------------------------
output "private_route_table_associations_id" {
    description = "The ID of the association"
    value       = element(concat(aws_route_table_association.private_route_table_associations.*.id, [""]), 0)
}

output "public_route_table_associations_id" {
    description = "The ID of the association"
    value       = element(concat(aws_route_table_association.public_route_table_associations.*.id, [""]), 0)
}
