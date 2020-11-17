#-----------------------------------------------------------
# IAM role
#-----------------------------------------------------------
output "iam_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the role."
  value       = element(concat(aws_iam_role.iam_role.*.arn, [""]), 0)
}

output "iam_role_name" {
  description = "The name of the role."
  value       = element(concat(aws_iam_role.iam_role.*.name, [""]), 0)
}

output "iam_role_id" {
  description = "The name of the role."
  value       = element(concat(aws_iam_role.iam_role.*.id, [""]), 0)
}

#-----------------------------------------------------------
# IAM policy
#-----------------------------------------------------------
output "iam_role_policy_id" {
  description = "The role policy ID, in the form of role_name:role_policy_name."
  value       = element(concat(aws_iam_role_policy.iam_role_policy.*.id, [""]), 0)
}

output "iam_role_policy_name" {
  description = "The name of the policy."
  value       = element(concat(aws_iam_role_policy.iam_role_policy.*.name, [""]), 0)
}

output "iam_role_policy_policy" {
  description = "The policy document attached to the role."
  value       = element(concat(aws_iam_role_policy.iam_role_policy.*.policy, [""]), 0)
}

output "iam_role_policy_role" {
  description = "The name of the role associated with the policy."
  value       = element(concat(aws_iam_role_policy.iam_role_policy.*.role, [""]), 0)
}

#-----------------------------------------------------------
# IAM policy attachment
#-----------------------------------------------------------
output "iam_role_policy_attachment_id" {
  description = "ID"
  value       = element(concat(aws_iam_role_policy_attachment.iam_role_policy_attachment.*.id, [""]), 0)
}

output "iam_role_policy_attachment_role" {
  description = "(Required) - The role the policy should be applied to"
  value       = element(concat(aws_iam_role_policy_attachment.iam_role_policy_attachment.*.role, [""]), 0)
}

output "iam_role_policy_attachment_policy_arn" {
  description = "(Required) - The ARN of the policy you want to apply"
  value       = element(concat(aws_iam_role_policy_attachment.iam_role_policy_attachment.*.policy_arn, [""]), 0)
}

#-----------------------------------------------------------
# IAM instance profile
#-----------------------------------------------------------
output "instance_profile_id" {
  description = "The instance profile's ID."
  value       = element(concat(aws_iam_instance_profile.iam_instance_profile.*.id, [""]), 0)
}

output "instance_profile_uid" {
  description = "The unique ID assigned by AWS."
  value       = element(concat(aws_iam_instance_profile.iam_instance_profile.*.unique_id, [""]), 0)
}

output "instance_profile_arn" {
  description = "The ARN assigned by AWS to the instance profile."
  value       = element(concat(aws_iam_instance_profile.iam_instance_profile.*.arn, [""]), 0)
}

output "instance_profile_create_date" {
  description = "The creation timestamp of the instance profile."
  value       = element(concat(aws_iam_instance_profile.iam_instance_profile.*.create_date, [""]), 0)
}

output "instance_profile_name" {
  description = "The instance profile's name."
  value       = element(concat(aws_iam_instance_profile.iam_instance_profile.*.name, [""]), 0)
}

output "instance_profile_path" {
  description = "The path of the instance profile in IAM."
  value       = element(concat(aws_iam_instance_profile.iam_instance_profile.*.path, [""]), 0)
}

output "instance_profile_role" {
  description = "The role assigned to the instance profile."
  value       = element(concat(aws_iam_instance_profile.iam_instance_profile.*.role, [""]), 0)
}
