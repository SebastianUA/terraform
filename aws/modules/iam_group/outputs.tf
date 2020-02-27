#-----------------------------------------------------------
# IAM group
#-----------------------------------------------------------
output "iam_group_arn" {
	description = "The ARN assigned by AWS for this group."
    value       = element(concat(aws_iam_group.iam_group.*.arn, [""]), 0)
}

output "iam_group_id" {
	description = "The group's ID."
    value       = element(concat(aws_iam_group.iam_group.*.id, [""]), 0)
}

output "iam_group_name" {
	description = "The group's name."
    value       = element(concat(aws_iam_group.iam_group.*.name, [""]), 0)
}

output "iam_group_path" {
	description = "The path of the group in IAM."
    value       = element(concat(aws_iam_group.iam_group.*.path, [""]), 0)
}

output "iam_group_unique_id" {
	description = "The unique ID assigned by AWS."
    value       = element(concat(aws_iam_group.iam_group.*.unique_id, [""]), 0)
}

#-----------------------------------------------------------
# IAM group policy
#-----------------------------------------------------------
output "iam_group_policy_id" {
	description = "The group policy ID."
    value       = element(concat(aws_iam_group_policy.iam_group_policy.*.id, [""]), 0)
}

output "iam_group_policy_group" {
	description = "The group to which this policy applies."
    value       = element(concat(aws_iam_group_policy.iam_group_policy.*.group, [""]), 0)
}

output "iam_group_policy_name" {
	description = "The name of the policy."
    value       = element(concat(aws_iam_group_policy.iam_group_policy.*.name, [""]), 0)
}

output "iam_group_policy_policy" {
	description = "The policy document attached to the group."
    value       = element(concat(aws_iam_group_policy.iam_group_policy.*.policy, [""]), 0)
}

#-----------------------------------------------------------
# IAM group policy attachment
#-----------------------------------------------------------
output "iam_group_policy_attachment_group" {
	description = "(Required) - The group the policy should be applied to"
    value       = element(concat(aws_iam_group_policy_attachment.iam_group_policy_attachment.*.group, [""]), 0)
}

output "iam_group_policy_attachment_policy_arn" {
	description = "(Required) - The ARN of the policy you want to apply"
    value       = element(concat(aws_iam_group_policy_attachment.iam_group_policy_attachment.*.policy_arn, [""]), 0)
}

#-----------------------------------------------------------
# IAM group membership
#-----------------------------------------------------------
output "iam_group_membership_name" {
	description = "The name to identify the Group Membership"
    value       = element(concat(aws_iam_group_membership.iam_group_membership.*.name, [""]), 0)
}

output "iam_group_membership_users" {
	description = "list of IAM User names"
    value       = concat(aws_iam_group_membership.iam_group_membership.*.users, [""])
}

output "iam_group_membership_group" {
	description = "IAM Group name"
    value       = element(concat(aws_iam_group_membership.iam_group_membership.*.group, [""]), 0)
}
