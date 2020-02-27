#---------------------------------------------------
# AWS KMS key
#---------------------------------------------------
output "kms_key_arn" {
    description = "The globally unique identifier for the key."
    value       = element(concat(aws_kms_key.kms_key.*.arn, [""]), 0)
}

output "kms_key_id" {
    description = "The globally unique identifier for the key."
    value       = element(concat(aws_kms_key.kms_key.*.key_id, [""]), 0)
}

output "kms_alias_arn" {
    value = element(concat(aws_kms_alias.kms_alias.*.arn, [""]), 0)
}
