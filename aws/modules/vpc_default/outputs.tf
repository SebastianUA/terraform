#---------------------------------------------------------------
# AWS VPC
#---------------------------------------------------------------
output "default_vpc_arn" {
  description = "Amazon Resource Name (ARN) of VPC"
  value       = element(concat(aws_default_vpc.default_vpc.*.arn, [""]), 0)
}

output "default_vpc_id" {
  description = "The ID of the VPC"
  value       = element(concat(aws_default_vpc.default_vpc.*.id, [""]), 0)
}

output "default_vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = element(concat(aws_default_vpc.default_vpc.*.cidr_block, [""]), 0)
}

output "default_vpc_instance_tenancy" {
  description = "Tenancy of instances spin up within VPC."
  value       = element(concat(aws_default_vpc.default_vpc.*.instance_tenancy, [""]), 0)
}

output "default_vpc_enable_dns_support" {
  description = "Whether or not the VPC has DNS support"
  value       = element(concat(aws_default_vpc.default_vpc.*.enable_dns_support, [""]), 0)
}

output "default_vpc_enable_dns_hostnames" {
  description = "Whether or not the VPC has DNS hostname support"
  value       = element(concat(aws_default_vpc.default_vpc.*.enable_dns_hostnames, [""]), 0)
}

output "default_vpc_enable_classiclink" {
  description = "Whether or not the VPC has Classiclink enabled"
  value       = element(concat(aws_default_vpc.default_vpc.*.enable_classiclink, [""]), 0)
}

output "default_vpc_main_route_table_id" {
  description = "The ID of the main route table associated with this VPC. Note that you can change a VPC's main route table by using an aws_main_route_table_association."
  value       = element(concat(aws_default_vpc.default_vpc.*.main_route_table_id, [""]), 0)
}

output "default_vpc_default_network_acl_id" {
  description = "The ID of the network ACL created by default on VPC creation"
  value       = element(concat(aws_default_vpc.default_vpc.*.default_network_acl_id, [""]), 0)
}

output "default_vpc_default_security_group_id" {
  description = "The ID of the security group created by default on VPC creation"
  value       = element(concat(aws_default_vpc.default_vpc.*.default_security_group_id, [""]), 0)
}

output "default_vpc_default_route_table_id" {
  description = "The ID of the route table created by default on VPC creation"
  value       = element(concat(aws_default_vpc.default_vpc.*.default_route_table_id, [""]), 0)
}

output "default_vpc_ipv6_association_id" {
  description = "The association ID for the IPv6 CIDR block."
  value       = element(concat(aws_default_vpc.default_vpc.*.ipv6_association_id, [""]), 0)
}

output "default_vpc_ipv6_cidr_block" {
  description = "The IPv6 CIDR block."
  value       = element(concat(aws_default_vpc.default_vpc.*.ipv6_cidr_block, [""]), 0)
}

output "default_vpc_owner_id" {
  description = "The ID of the AWS account that owns the VPC."
  value       = element(concat(aws_default_vpc.default_vpc.*.id, [""]), 0)
}

#---------------------------------------------------------------
# AWS subnets
#---------------------------------------------------------------
output "default_subnet_id" {
  description = "The ID of the subnet"
  value       = element(concat(aws_default_subnet.default_subnet.*.id, [""]), 0)
}

output "default_subnet_availability_zone" {
  description = "The AZ for the subnet."
  value       = element(concat(aws_default_subnet.default_subnet.*.availability_zone, [""]), 0)
}

output "default_subnet_availability_zone_id" {
  description = "The AZ ID of the subnet."
  value       = element(concat(aws_default_subnet.default_subnet.*.availability_zone_id, [""]), 0)
}

output "default_cidr_block" {
  description = "The CIDR block for the subnet."
  value       = element(concat(aws_default_subnet.default_subnet.*.cidr_block, [""]), 0)
}

output "default_subnet_vpc_id" {
  description = "The VPC ID."
  value       = element(concat(aws_default_subnet.default_subnet.*.vpc_id, [""]), 0)
}

output "default_subnet_ipv6_cidr_block" {
  description = "The IPv6 CIDR block."
  value       = element(concat(aws_default_subnet.default_subnet.*.ipv6_cidr_block, [""]), 0)
}

output "default_subnet_owner_id" {
  description = "The ID of the AWS account that owns the subnet."
  value       = element(concat(aws_default_subnet.default_subnet.*.owner_id, [""]), 0)
}

#---------------------------------------------------
# AWS default vpc dhcp options
#---------------------------------------------------
output "default_vpc_dhcp_options_id" {
  description = "The ID of the DHCP Options Set."
  value       = element(concat(aws_default_vpc_dhcp_options.default_vpc_dhcp_options.*.id, [""]), 0)
}

output "default_vpc_dhcp_options_owner_id" {
  description = "The ID of the AWS account that owns the DHCP options set."
  value       = element(concat(aws_default_vpc_dhcp_options.default_vpc_dhcp_options.*.owner_id, [""]), 0)
}

#---------------------------------------------------
# AWS default security group
#---------------------------------------------------
output "default_security_group_id" {
  description = "The ID of the security group"
  value       = element(concat(aws_default_security_group.default_security_group.*.id, [""]), 0)
}

output "default_security_group_vpc_id" {
  description = "The VPC ID."
  value       = element(concat(aws_default_security_group.default_security_group.*.vpc_id, [""]), 0)
}

output "default_security_group_owner_id" {
  description = "The owner ID."
  value       = element(concat(aws_default_security_group.default_security_group.*.owner_id, [""]), 0)
}

output "default_security_group_name" {
  description = "The name of the security group"
  value       = element(concat(aws_default_security_group.default_security_group.*.name, [""]), 0)
}

output "default_security_group_description" {
  description = "The description of the security group"
  value       = element(concat(aws_default_security_group.default_security_group.*.description, [""]), 0)
}

output "default_security_group_ingress" {
  description = "The ingress rules. See above for more."
  value       = element(concat(aws_default_security_group.default_security_group.*.ingress, [""]), 0)
}

output "default_security_group_egress" {
  description = "The egress rules. See above for more."
  value       = element(concat(aws_default_security_group.default_security_group.*.egress, [""]), 0)
}

#---------------------------------------------------
# AWS default network acl
#---------------------------------------------------
output "default_network_acl_id" {
  description = "The ID of the Default Network ACL"
  value       = element(concat(aws_default_network_acl.default_network_acl.*.id, [""]), 0)
}

output "default_network_acl_vpc_id" {
  description = "The ID of the associated VPC"
  value       = element(concat(aws_default_network_acl.default_network_acl.*.vpc_id, [""]), 0)
}

output "default_network_acl_ingress" {
  description = "Set of ingress rules"
  value       = element(concat(aws_default_network_acl.default_network_acl.*.ingress, [""]), 0)
}

output "default_network_acl_egress" {
  description = "Set of egress rules"
  value       = element(concat(aws_default_network_acl.default_network_acl.*.egress, [""]), 0)
}

output "default_network_acl_subnet_ids" {
  description = "IDs of associated Subnets"
  value       = concat(aws_default_network_acl.default_network_acl.*.subnet_ids, [""])
}

output "default_network_acl_owner_id" {
  description = "The ID of the AWS account that owns the Default Network ACL"
  value       = element(concat(aws_default_network_acl.default_network_acl.*.owner_id, [""]), 0)
}

#---------------------------------------------------
# AWS default route table
#---------------------------------------------------
# output "default_route_table_id" {
#     description = "The ID of the routing table"
#     value       = element(concat(aws_default_route_table.default_route_table.*.id, [""]), 0)
# }

# output "default_route_table_owner_id" {
#     description = "The ID of the AWS account that owns the route table"
#     value       = element(concat(aws_default_route_table.default_route_table.*.owner_id, [""]), 0)
# }
