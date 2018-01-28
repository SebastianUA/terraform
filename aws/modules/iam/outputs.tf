output "instance_profile_id" {
    value = "${aws_iam_instance_profile.profile.id}"
}
output "instance_profile_uid" {
    value = "${aws_iam_instance_profile.profile.unique_id}"
}
output "role_arn" {
    value = "${aws_iam_role.role.arn}"
}

output "role_name" {
    value = "${aws_iam_role.role.name}"
}

output "policy_name" {
    value = "${aws_iam_policy.policy.name}"
}
output "AWS region" {
    value = "${var.region}"
}

output "role_id" {
  value = "${aws_iam_role.role.id}"
}
