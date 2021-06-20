#---------------------------------------------------
# AWS dms certificate
#---------------------------------------------------
output "dms_certificate_id" {
  description = "The Amazon Resource Name (ID) for the certificate."
  value       = element(concat(aws_dms_certificate.dms_certificate.*.id, [""]), 0)
}

output "dms_certificate_certificate_arn" {
  description = "The Amazon Resource Name (ARN) for the certificate."
  value       = element(concat(aws_dms_certificate.dms_certificate.*.arn, [""]), 0)
}

output "dms_certificate_tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
  value       = concat(aws_dms_certificate.dms_certificate.*.tags_all, [""])
}

#---------------------------------------------------
# AWS dms endpoint
#---------------------------------------------------
output "dms_endpoint_id" {
  description = "The Amazon Resource Name (ID) for the endpoint."
  value       = element(concat(aws_dms_endpoint.dms_endpoint.*.id, [""]), 0)
}

output "dms_endpoint_endpoint_arn" {
  description = "The Amazon Resource Name (ARN) for the endpoint."
  value       = element(concat(aws_dms_endpoint.dms_endpoint.*.endpoint_arn, [""]), 0)
}

output "dms_endpoint_tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
  value       = concat(aws_dms_endpoint.dms_endpoint.*.tags_all, [""])
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
output "dms_replication_task_id" {
  description = "The Amazon Resource Name (ID) for the replication task."
  value       = element(concat(aws_dms_replication_task.dms_replication_task.*.id, [""]), 0)
}

output "dms_replication_task_replication_task_arn" {
  description = "The Amazon Resource Name (ARN) for the replication task."
  value       = element(concat(aws_dms_replication_task.dms_replication_task.*.replication_task_arn, [""]), 0)
}

output "dms_replication_task_tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
  value       = concat(aws_dms_replication_task.dms_replication_task.*.tags_all, [""])
}

#---------------------------------------------------
# AWS dms event subscription
#---------------------------------------------------
output "dms_event_subscription_id" {
  description = "The Amazon Resource Name (ID) for the event subscription."
  value       = element(concat(aws_dms_event_subscription.dms_event_subscription.*.id, [""]), 0)
}

output "dms_event_subscription_arn" {
  description = "Amazon Resource Name (ARN) of the DMS Event Subscription."
  value       = element(concat(aws_dms_event_subscription.dms_event_subscription.*.arn, [""]), 0)
}

output "dms_event_subscription_tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
  value       = concat(aws_dms_event_subscription.dms_event_subscription.*.tags_all, [""])
}
