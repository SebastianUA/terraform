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
  value       = element(concat(aws_vpc_endpoint_service_allowed_principal.vpc_endpoint_service_allowed_principal.*.id, [""]), 0)
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
# AWS VPC endpoint route table association
#---------------------------------------------------
// output "vpc_endpoint_route_table_association_id" {
//   description = "A hash of the EC2 Route Table and VPC Endpoint identifiers."
//   value       = aws_vpc_endpoint_route_table_association.vpc_endpoint_route_table_association.*.id
// }

#---------------------------------------------------
# AWS VPC endpoint subnet association
#---------------------------------------------------
// output "vpc_endpoint_subnet_association_id" {
//   description = "The ID of the association."
//   value       = aws_vpc_endpoint_subnet_association.vpc_endpoint_subnet_association.*.id
// }