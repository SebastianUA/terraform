#---------------------------------------------------
# AWS dms certificate
#---------------------------------------------------
output "dms_certificates" {
  description = "A map of maps containing the certificates created and their full output of attributes and values"
  value       = aws_dms_certificate.dms_certificate
  sensitive   = true
}

#---------------------------------------------------
# AWS dms endpoint
#---------------------------------------------------
output "dms_endpoints" {
  description = "A map of maps containing the endpoints created and their full output of attributes and values"
  value       = aws_dms_endpoint.dms_endpoint
  sensitive   = true
}

#---------------------------------------------------
# AWS dms replication subnet group
#---------------------------------------------------
output "dms_replication_subnet_group_id" {
  description = "The Amazon Resource Name (ID) for the replication subnet group."
  value       = element(concat(aws_dms_replication_subnet_group.dms_replication_subnet_group.*.id, [""]), 0)
}

output "dms_replication_subnet_group_tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
  value       = concat(aws_dms_replication_subnet_group.dms_replication_subnet_group.*.tags_all, [""])
}

output "dms_replication_subnet_group_vpc_id" {
  description = "The ID of the VPC the subnet group is in."
  value       = element(concat(aws_dms_replication_subnet_group.dms_replication_subnet_group.*.vpc_id, [""]), 0)
}

#---------------------------------------------------
# AWS dms replication instance
#---------------------------------------------------
output "dms_replication_instance_id" {
  description = "The Amazon Resource Name (ID) for the replication instance."
  value       = element(concat(aws_dms_replication_instance.dms_replication_instance.*.id, [""]), 0)
}

output "dms_replication_instance_replication_instance_arn" {
  description = "The Amazon Resource Name (ARN) of the replication instance."
  value       = element(concat(aws_dms_replication_instance.dms_replication_instance.*.replication_instance_arn, [""]), 0)
}

output "dms_replication_instance_replication_instance_private_ips" {
  description = "A list of the private IP addresses of the replication instance."
  value       = element(concat(aws_dms_replication_instance.dms_replication_instance.*.replication_instance_private_ips, [""]), 0)
}

output "dms_replication_instance_replication_instance_public_ips" {
  description = "A list of the public IP addresses of the replication instance."
  value       = element(concat(aws_dms_replication_instance.dms_replication_instance.*.replication_instance_public_ips, [""]), 0)
}

output "dms_replication_instance_tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block"
  value       = concat(aws_dms_replication_instance.dms_replication_instance.*.tags_all, [""])
}

#---------------------------------------------------
# AWS dms replication task
#---------------------------------------------------
output "dms_replication_tasks" {
  description = "The Amazon Resource Name (ID) for the replication tasks."
  value       = aws_dms_replication_task.dms_replication_task
}

#---------------------------------------------------
# AWS dms event subscription
#---------------------------------------------------
output "dms_event_subscriptions" {
  description = "A map of maps containing the event subscriptions created and their full output of attributes and values"
  value       = aws_dms_event_subscription.dms_event_subscription
}