#---------------------------------------------------
# AWS xray sampling rule
#---------------------------------------------------
output "xray_sampling_rule_id" {
  description = "The name of the sampling rule."
  value       = element(concat(aws_xray_sampling_rule.xray_sampling_rule.*.id, [""]), 0)
}

output "xray_sampling_rule_arn" {
  description = "The ARN of the sampling rule."
  value       = element(concat(aws_xray_sampling_rule.xray_sampling_rule.*.arn, [""]), 0)
}

#---------------------------------------------------
# AWS xray encryption config
#---------------------------------------------------
output "xray_encryption_config_id" {
  description = "Region name."
  value       = element(concat(aws_xray_encryption_config.xray_encryption_config.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS xray group
#---------------------------------------------------
output "xray_group_id" {
  description = "The ID of the Group."
  value       = element(concat(aws_xray_group.xray_group.*.id, [""]), 0)
}

output "xray_group_arn" {
  description = "The ARN of the Group."
  value       = element(concat(aws_xray_group.xray_group.*.arn, [""]), 0)
}
