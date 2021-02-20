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

#---------------------------------------------------
# AWS KMS alias
#---------------------------------------------------
output "kms_alias_id" {
  description = "ID of KMS alias"
  value       = element(concat(aws_kms_alias.kms_alias.*.id, [""]), 0)
}

output "kms_alias_arn" {
  description = "The Amazon Resource Name (ARN) of the key alias."
  value       = element(concat(aws_kms_alias.kms_alias.*.arn, [""]), 0)
}

output "kms_alias_target_key_arn" {
  description = "The Amazon Resource Name (ARN) of the target key identifier."
  value       = element(concat(aws_kms_alias.kms_alias.*.target_key_arn, [""]), 0)
}

#---------------------------------------------------
# KSM grant
#---------------------------------------------------
output "kms_grant_id" {
  description = "ID of KMS grant"
  value       = element(concat(aws_kms_grant.kms_grant.*.id, [""]), 0)
}

output "kms_grant_grant_id" {
  description = "The unique identifier for the grant."
  value       = element(concat(aws_kms_grant.kms_grant.*.grant_id, [""]), 0)
}

output "kms_grant_token" {
  description = "The grant token for the created grant. For more information, see Grant Tokens."
  value       = element(concat(aws_kms_grant.kms_grant.*.grant_token, [""]), 0)
}

#---------------------------------------------------
# KSM external key
#---------------------------------------------------
output "kms_external_key_id" {
  description = "The unique identifier for the key."
  value       = element(concat(aws_kms_external_key.kms_external_key.*.id, [""]), 0)
}

output "kms_external_key_arn" {
  description = "The Amazon Resource Name (ARN) of the key."
  value       = element(concat(aws_kms_external_key.kms_external_key.*.arn, [""]), 0)
}

output "kms_external_key_expiration_model" {
  description = "Whether the key material expires. Empty when pending key material import, otherwise KEY_MATERIAL_EXPIRES or KEY_MATERIAL_DOES_NOT_EXPIRE."
  value       = element(concat(aws_kms_external_key.kms_external_key.*.expiration_model, [""]), 0)
}

output "kms_external_key_state" {
  description = "The state of the CMK."
  value       = element(concat(aws_kms_external_key.kms_external_key.*.key_state, [""]), 0)
}

output "kms_external_key_usage" {
  description = "The cryptographic operations for which you can use the CMK."
  value       = element(concat(aws_kms_external_key.kms_external_key.*.key_usage, [""]), 0)
}

#---------------------------------------------------
# KSM ciphertext
#---------------------------------------------------
output "kms_ciphertext_id" {
  description = "The unique identifier for the ciphertext."
  value       = element(concat(aws_kms_ciphertext.kms_ciphertext.*.id, [""]), 0)
}

output "kms_ciphertext_ciphertext_blob" {
  description = "Base64 encoded ciphertext"
  value       = element(concat(aws_kms_ciphertext.kms_ciphertext.*.ciphertext_blob, [""]), 0)
}
