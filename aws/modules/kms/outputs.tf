output "kms_key_id" {
    description = "The globally unique identifier for the key."
    value       = "${aws_kms_key.kms_key.key_id}"
}

output "kms_alias_arn" {
    value = "${aws_kms_alias.kms_alias.arn}"
}

output "region" {
    value = "${var.region}"
}

output "aws_account_id" {
    value = "${var.aws_account_id}"
}
