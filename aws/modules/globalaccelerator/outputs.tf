#---------------------------------------------------
# AWS globalaccelerator accelerator
#---------------------------------------------------
output "globalaccelerator_accelerator_id" {
  description = "The Amazon Resource Name (ARN) of the accelerator."
  value       = element(concat(aws_globalaccelerator_accelerator.globalaccelerator_accelerator.*.id, [""]), 0)
}

output "globalaccelerator_accelerator_dns_name" {
  description = "The DNS name of the accelerator. For example, a5d53ff5ee6bca4ce.awsglobalaccelerator.com."
  value       = element(concat(aws_globalaccelerator_accelerator.globalaccelerator_accelerator.*.dns_name, [""]), 0)
}

output "globalaccelerator_accelerator_hosted_zone_id" {
  description = "The Global Accelerator Route 53 zone ID that can be used to route an Alias Resource Record Set to the Global Accelerator. This attribute is simply an alias for the zone ID Z2BJ6XQ5FK7U4H."
  value       = element(concat(aws_globalaccelerator_accelerator.globalaccelerator_accelerator.*.hosted_zone_id, [""]), 0)
}

output "globalaccelerator_accelerator_ip_sets" {
  description = "IP address set associated with the accelerator."
  value       = element(concat(aws_globalaccelerator_accelerator.globalaccelerator_accelerator.*.ip_sets, [""]), 0)
}

#---------------------------------------------------
# AWS globalaccelerator listener
#---------------------------------------------------
output "globalaccelerator_listener_id" {
  description = "The Amazon Resource Name (ARN) of the listener."
  value       = element(concat(aws_globalaccelerator_listener.globalaccelerator_listener.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS globalaccelerator endpoint group
#---------------------------------------------------
output "globalaccelerator_endpoint_group_id" {
  description = "The Amazon Resource Name (ARN) of the endpoint group."
  value       = element(concat(aws_globalaccelerator_endpoint_group.globalaccelerator_endpoint_group.*.id, [""]), 0)
}
