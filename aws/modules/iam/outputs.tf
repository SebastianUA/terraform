#-----------------------------------------------------------
# IAM role
#-----------------------------------------------------------
output "role_arn" {
	description = ""
    value       = "${element(concat(aws_iam_role.iam_role.*.arn, list("")), 0)}"
}		

output "role_name" {
	description = ""
    value       = "${element(concat(aws_iam_role.iam_role.*.name, list("")), 0)}"
}

output "role_id" {
	description = ""
    value       = "${element(concat(aws_iam_role.iam_role.*.id, list("")), 0)}"
}

#-----------------------------------------------------------
# IAM policy
#-----------------------------------------------------------
output "policy_name" {
	description = ""
    value       = "${element(concat(aws_iam_policy.iam_policy.*.name, list("")), 0)}"
}

#-----------------------------------------------------------
# IAM instance profile
#-----------------------------------------------------------
output "instance_profile_id" {
	description = ""
    value       = "${element(concat(aws_iam_instance_profile.iam_instance_profile.*.id, list("")), 0)}"
}

output "instance_profile_uid" {
	description = ""
    value       = "${element(concat(aws_iam_instance_profile.iam_instance_profile.*.unique_id, list("")), 0)}"
}

#-----------------------------------------------------------
# IAM cross acc assume role
#-----------------------------------------------------------
output "cross_account_assume_role_arns" {
	description = ""
    value       = "${element(concat(aws_iam_role.cross_account_assume_role.*.arn, list("")), 0)}"
}

