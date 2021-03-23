#---------------------------------------------------
# ssoadmin account assignment
#---------------------------------------------------
output "ssoadmin_account_assignment_id" {
  description = "The identifier of the Account Assignment i.e. principal_id, principal_type, target_id, target_type, permission_set_arn, instance_arn separated by commas (,)."
  value       = element(concat(aws_ssoadmin_account_assignment.ssoadmin_account_assignment.*.id, [""]), 0)
}

#---------------------------------------------------
# ssoadmin managed policy attachment
#---------------------------------------------------
output "ssoadmin_managed_policy_attachment_id" {
  description = "The Amazon Resource Names (ARNs) of the Managed Policy, Permission Set, and SSO Instance, separated by a comma (,)."
  value       = element(concat(aws_ssoadmin_managed_policy_attachment.ssoadmin_managed_policy_attachment.*.id, [""]), 0)
}

output "ssoadmin_managed_policy_attachment_managed_policy_name" {
  description = "The name of the IAM Managed Policy."
  value       = element(concat(aws_ssoadmin_managed_policy_attachment.ssoadmin_managed_policy_attachment.*.managed_policy_name, [""]), 0)
}

#---------------------------------------------------
# ssoadmin permission set
#---------------------------------------------------
output "ssoadmin_permission_set_id" {
  description = "The Amazon Resource Names (ARNs) of the Permission Set and SSO Instance, separated by a comma (,)."
  value       = element(concat(aws_ssoadmin_permission_set.ssoadmin_permission_set.*.id, [""]), 0)
}

output "ssoadmin_permission_set_arn" {
  description = "The Amazon Resource Name (ARN) of the Permission Set."
  value       = element(concat(aws_ssoadmin_permission_set.ssoadmin_permission_set.*.arn, [""]), 0)
}

output "ssoadmin_permission_set_created_date" {
  description = "The date the Permission Set was created in RFC3339 format."
  value       = element(concat(aws_ssoadmin_permission_set.ssoadmin_permission_set.*.created_date, [""]), 0)
}

#---------------------------------------------------
# ssoadmin permission set inline policy
#---------------------------------------------------
output "ssoadmin_permission_set_inline_policy_id" {
  description = "The Amazon Resource Names (ARNs) of the Permission Set and SSO Instance, separated by a comma (,)."
  value       = element(concat(aws_ssoadmin_permission_set_inline_policy.ssoadmin_permission_set_inline_policy.*.id, [""]), 0)
}
