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
