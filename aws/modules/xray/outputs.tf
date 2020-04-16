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
