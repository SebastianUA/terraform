#---------------------------------------------------------------
# AWS VPC network interface
#---------------------------------------------------------------
output "network_interface_id" {
  description = "The ID of the network interface."
  value       = element(concat(aws_network_interface.network_interface.*.id, [""]), 0)
}

output "network_interface_subnet_id" {
  description = "Subnet ID the ENI is in."
  value       = element(concat(aws_network_interface.network_interface.*.subnet_id, [""]), 0)
}

output "network_interface_mac_address" {
  description = "The MAC address of the network interface."
  value       = element(concat(aws_network_interface.network_interface.*.mac_address, [""]), 0)
}

output "network_interface_private_dns_name" {
  description = "The private DNS name of the network interface (IPv4)."
  value       = element(concat(aws_network_interface.network_interface.*.private_dns_name, [""]), 0)
}

output "network_interface_description" {
  description = "A description for the network interface."
  value       = element(concat(aws_network_interface.network_interface.*.description, [""]), 0)
}

output "network_interface_private_ips" {
  description = "List of private IPs assigned to the ENI."
  value       = element(concat(aws_network_interface.network_interface.*.private_ips, [""]), 0)
}

output "network_interface_security_groups" {
  description = "List of security groups attached to the ENI."
  value       = element(concat(aws_network_interface.network_interface.*.security_groups, [""]), 0)
}

output "network_interface_attachment" {
  description = "Block defining the attachment of the ENI."
  value       = concat(aws_network_interface.network_interface.*.attachment, [""])
}

output "network_interface_source_dest_check" {
  description = "Whether source destination checking is enabled"
  value       = element(concat(aws_network_interface.network_interface.*.source_dest_check, [""]), 0)
}

output "network_interface_tags" {
  description = "Tags assigned to the ENI."
  value       = concat(aws_network_interface.network_interface.*.tags, [""])
}

#---------------------------------------------------
# AWS VPC network interface attachment
#---------------------------------------------------
output "network_interface_attachment_instance_id" {
  description = "Instance ID."
  value       = concat(aws_network_interface_attachment.network_interface_attachment.*.instance_id, [""])
}

output "network_interface_attachment_network_interface_id" {
  description = "Network interface ID."
  value       = concat(aws_network_interface_attachment.network_interface_attachment.*.network_interface_id, [""])
}

output "network_interface_attachment_attachment_id" {
  description = "The ENI Attachment ID."
  value       = concat(aws_network_interface_attachment.network_interface_attachment.*.attachment_id, [""])
}

output "network_interface_attachment_status" {
  description = "The status of the Network Interface Attachment."
  value       = concat(aws_network_interface_attachment.network_interface_attachment.*.status, [""])
}
