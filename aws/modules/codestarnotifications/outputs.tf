#---------------------------------------------------
# AWS codestarnotifications notification rule
#---------------------------------------------------
output "codestarnotifications_notification_rule_id" {
  description = "The codestar notification rule ARN."
  value       = element(concat(aws_codestarnotifications_notification_rule.codestarnotifications_notification_rule.*.id, [""]), 0)
}

output "codestarnotifications_notification_rule_arn" {
  description = "The codestar notification rule ARN."
  value       = element(concat(aws_codestarnotifications_notification_rule.codestarnotifications_notification_rule.*.arn, [""]), 0)
}
