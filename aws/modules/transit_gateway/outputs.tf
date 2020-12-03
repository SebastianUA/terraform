#---------------------------------------------------
# AWS EC2 transit gateway
#---------------------------------------------------
output "transit_gateway_id" {
  description = "EC2 Transit Gateway identifier"
  value       = element(concat(aws_ec2_transit_gateway.transit_gateway.*.id, [""]), 0)
}

output "transit_gateway_arn" {
  description = "EC2 Transit Gateway Amazon Resource Name (ARN)"
  value       = element(concat(aws_ec2_transit_gateway.transit_gateway.*.arn, [""]), 0)
}

output "transit_gateway_association_default_route_table_id" {
  description = "Identifier of the default association route table"
  value       = element(concat(aws_ec2_transit_gateway.transit_gateway.*.association_default_route_table_id, [""]), 0)
}

output "transit_gateway_owner_id" {
  description = "Identifier of the AWS account that owns the EC2 Transit Gateway"
  value       = element(concat(aws_ec2_transit_gateway.transit_gateway.*.owner_id, [""]), 0)
}

output "transit_gateway_propagation_default_route_table_id" {
  description = "Identifier of the default propagation route table"
  value       = element(concat(aws_ec2_transit_gateway.transit_gateway.*.propagation_default_route_table_id, [""]), 0)
}

#---------------------------------------------------
# AWS EC2 transit gateway vpc attachment
#---------------------------------------------------
output "transit_gateway_vpc_attachment_id" {
  description = "EC2 Transit Gateway Attachment identifier"
  value       = element(concat(aws_ec2_transit_gateway_vpc_attachment.transit_gateway_vpc_attachment.*.id, [""]), 0)
}

output "transit_gateway_vpc_attachment_vpc_owner_id" {
  description = "Identifier of the AWS account that owns the EC2 VPC."
  value       = element(concat(aws_ec2_transit_gateway_vpc_attachment.transit_gateway_vpc_attachment.*.vpc_owner_id, [""]), 0)
}

#---------------------------------------------------
# AWS EC2 transit gateway vpc attachment accepter
#---------------------------------------------------
output "transit_gateway_vpc_attachment_accepter_id" {
  description = "EC2 Transit Gateway Attachment identifier"
  value       = element(concat(aws_ec2_transit_gateway_vpc_attachment_accepter.transit_gateway_vpc_attachment_accepter.*.id, [""]), 0)
}

output "transit_gateway_vpc_attachment_accepter_appliance_mode_support" {
  description = "Whether Appliance Mode support is enabled. Valid values: disable, enable."
  value       = element(concat(aws_ec2_transit_gateway_vpc_attachment_accepter.transit_gateway_vpc_attachment_accepter.*.appliance_mode_support, [""]), 0)
}

output "transit_gateway_vpc_attachment_accepter_dns_support" {
  description = "Whether DNS support is enabled. Valid values: disable, enable."
  value       = element(concat(aws_ec2_transit_gateway_vpc_attachment_accepter.transit_gateway_vpc_attachment_accepter.*.dns_support, [""]), 0)
}

output "transit_gateway_vpc_attachment_accepter_ipv6_support" {
  description = "Whether IPv6 support is enabled. Valid values: disable, enable."
  value       = element(concat(aws_ec2_transit_gateway_vpc_attachment_accepter.transit_gateway_vpc_attachment_accepter.*.ipv6_support, [""]), 0)
}

output "transit_gateway_vpc_attachment_accepter_subnet_ids" {
  description = "Identifiers of EC2 Subnets."
  value       = element(concat(aws_ec2_transit_gateway_vpc_attachment_accepter.transit_gateway_vpc_attachment_accepter.*.subnet_ids, [""]), 0)
}

output "transit_gateway_vpc_attachment_accepter_transit_gateway_id" {
  description = "Identifier of EC2 Transit Gateway."
  value       = element(concat(aws_ec2_transit_gateway_vpc_attachment_accepter.transit_gateway_vpc_attachment_accepter.*.transit_gateway_id, [""]), 0)
}

output "transit_gateway_vpc_attachment_accepter_vpc_id" {
  description = "Identifier of EC2 VPC."
  value       = element(concat(aws_ec2_transit_gateway_vpc_attachment_accepter.transit_gateway_vpc_attachment_accepter.*.vpc_id, [""]), 0)
}

output "transit_gateway_vpc_attachment_accepter_vpc_owner_id" {
  description = "Identifier of the AWS account that owns the EC2 VPC."
  value       = element(concat(aws_ec2_transit_gateway_vpc_attachment_accepter.transit_gateway_vpc_attachment_accepter.*.vpc_owner_id, [""]), 0)
}

#---------------------------------------------------
# AWS EC2 transit gateway route table
#---------------------------------------------------
output "transit_gateway_route_table_id" {
  description = "EC2 Transit Gateway Route Table identifier"
  value       = element(concat(aws_ec2_transit_gateway_route_table.transit_gateway_route_table.*.id, [""]), 0)
}

output "transit_gateway_route_table_arn" {
  description = "EC2 Transit Gateway Route Table Amazon Resource Name (ARN)."
  value       = element(concat(aws_ec2_transit_gateway_route_table.transit_gateway_route_table.*.arn, [""]), 0)
}

output "transit_gateway_route_table_default_association_route_table" {
  description = "Boolean whether this is the default association route table for the EC2 Transit Gateway."
  value       = element(concat(aws_ec2_transit_gateway_route_table.transit_gateway_route_table.*.default_association_route_table, [""]), 0)
}

output "transit_gateway_route_table_default_propagation_route_table" {
  description = "Boolean whether this is the default propagation route table for the EC2 Transit Gateway."
  value       = element(concat(aws_ec2_transit_gateway_route_table.transit_gateway_route_table.*.default_propagation_route_table, [""]), 0)
}

#---------------------------------------------------
# AWS EC2 transit gateway route
#---------------------------------------------------
output "transit_gateway_route_id" {
  description = "EC2 Transit Gateway Route Table identifier combined with destination"
  value       = element(concat(aws_ec2_transit_gateway_route.transit_gateway_route.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS EC2 transit gateway route table propagation
#---------------------------------------------------
output "transit_gateway_route_table_propagation_id" {
  description = "EC2 Transit Gateway Route Table identifier combined with EC2 Transit Gateway Attachment identifier"
  value       = element(concat(aws_ec2_transit_gateway_route_table_propagation.transit_gateway_route_table_propagation.*.id, [""]), 0)
}

output "transit_gateway_route_table_propagation_resource_type" {
  description = "Type of the resource"
  value       = element(concat(aws_ec2_transit_gateway_route_table_propagation.transit_gateway_route_table_propagation.*.resource_type, [""]), 0)
}

output "transit_gateway_route_table_propagation_resource_id" {
  description = "Identifier of the resource"
  value       = element(concat(aws_ec2_transit_gateway_route_table_propagation.transit_gateway_route_table_propagation.*.resource_id, [""]), 0)
}

#---------------------------------------------------
# AWS EC2 transit gateway route table association
#---------------------------------------------------
output "transit_gateway_route_table_association_id" {
  description = "EC2 Transit Gateway Route Table identifier combined with EC2 Transit Gateway Attachment identifier"
  value       = element(concat(aws_ec2_transit_gateway_route_table_association.transit_gateway_route_table_association.*.id, [""]), 0)
}

output "transit_gateway_route_table_association_resource_id" {
  description = "Identifier of the resource"
  value       = element(concat(aws_ec2_transit_gateway_route_table_association.transit_gateway_route_table_association.*.resource_id, [""]), 0)
}

output "transit_gateway_route_table_association_resource_type" {
  description = "Type of the resource"
  value       = element(concat(aws_ec2_transit_gateway_route_table_association.transit_gateway_route_table_association.*.resource_type, [""]), 0)
}

#---------------------------------------------------
# AWS EC2 transit gateway peering attachment
#---------------------------------------------------
output "transit_gateway_peering_attachment_id" {
  description = "EC2 Transit Gateway Attachment identifier"
  value       = element(concat(aws_ec2_transit_gateway_peering_attachment.transit_gateway_peering_attachment.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS EC2 transit gateway peering attachment accepter
#---------------------------------------------------
output "transit_gateway_peering_attachment_accepter_id" {
  description = "EC2 Transit Gateway Attachment identifier"
  value       = element(concat(aws_ec2_transit_gateway_peering_attachment_accepter.transit_gateway_peering_attachment_accepter.*.id, [""]), 0)
}

output "transit_gateway_peering_attachment_accepter_transit_gateway_id" {
  description = "Identifier of EC2 Transit Gateway."
  value       = element(concat(aws_ec2_transit_gateway_peering_attachment_accepter.transit_gateway_peering_attachment_accepter.*.transit_gateway_id, [""]), 0)
}

output "transit_gateway_peering_attachment_accepter_peer_transit_gateway_id" {
  description = "Identifier of EC2 Transit Gateway to peer with."
  value       = element(concat(aws_ec2_transit_gateway_peering_attachment_accepter.transit_gateway_peering_attachment_accepter.*.peer_transit_gateway_id, [""]), 0)
}

output "transit_gateway_peering_attachment_accepter_peer_account_id" {
  description = "Identifier of the AWS account that owns the EC2 TGW peering."
  value       = element(concat(aws_ec2_transit_gateway_peering_attachment_accepter.transit_gateway_peering_attachment_accepter.*.peer_account_id, [""]), 0)
}
