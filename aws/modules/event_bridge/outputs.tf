#---------------------------------------------------
# AWS directory service directory
#---------------------------------------------------
output "directory_service_directory_id" {
  description = "The directory identifier."
  value       = element(concat(aws_directory_service_directory.directory_service_directory.*.id, [""]), 0)
}

output "directory_service_directory_access_url" {
  description = "The access URL for the directory, such as http://alias.awsapps.com."
  value       = element(concat(aws_directory_service_directory.directory_service_directory.*.access_url, [""]), 0)
}

output "directory_service_directory_dns_ip_addresses" {
  description = "A list of IP addresses of the DNS servers for the directory or connector."
  value       = element(concat(aws_directory_service_directory.directory_service_directory.*.dns_ip_addresses, [""]), 0)
}

output "directory_service_directory_security_group_id" {
  description = "The ID of the security group created by the directory."
  value       = element(concat(aws_directory_service_directory.directory_service_directory.*.security_group_id, [""]), 0)
}

output "directory_service_directory_connect_settings" {
  description = "connect_settings: The IP addresses of the AD Connector servers."
  value       = aws_directory_service_directory.directory_service_directory.*.connect_settings
}

#---------------------------------------------------
# AWS directory service log subscription
#---------------------------------------------------
output "directory_service_log_subscription_id" {
  description = "The directory identifier for log subscription."
  value       = element(concat(aws_directory_service_log_subscription.directory_service_log_subscription.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS directory service conditional forwarder
#---------------------------------------------------
output "directory_service_conditional_forwarder_id" {
  description = "The directory identifier for conditional forwarder"
  value       = element(concat(aws_directory_service_conditional_forwarder.directory_service_conditional_forwarder.*.id, [""]), 0)
}
