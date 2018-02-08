output "instance_profile_id" {
    value = "${aws_iam_instance_profile.iam_instance_profile.id}"
}

output "instance_profile_uid" {
    value = "${aws_iam_instance_profile.iam_instance_profile.unique_id}"
}

output "role_arn" {
    value = "${aws_iam_role.iam_role.arn}"
}

output "role_name" {
    value = "${aws_iam_role.iam_role.name}"
}

output "policy_name" {
    value = "${aws_iam_policy.iam_policy.name}"
}

output "AWS region" {
    value = "${var.region}"
}

output "role_id" {
  value = "${aws_iam_role.iam_role.id}"
}

output "cross_account_assume_role_arns" {
  value = "${aws_iam_role.cross_account_assume_role.*.arn}"
}
