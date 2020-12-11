#---------------------------------------------------
# AWS secretsmanager secret
#---------------------------------------------------
output "secretsmanager_secret_id" {
  description = "Amazon Resource Name (ID) of the secret."
  value       = element(concat(aws_secretsmanager_secret.secretsmanager_secret.*.id, [""]), 0)
}

output "secretsmanager_secret_arn" {
  description = "Amazon Resource Name (ARN) of the secret."
  value       = element(concat(aws_secretsmanager_secret.secretsmanager_secret.*.arn, [""]), 0)
}

output "secretsmanager_secret_rotation_enabled" {
  description = "Specifies whether automatic rotation is enabled for this secret."
  value       = element(concat(aws_secretsmanager_secret.secretsmanager_secret.*.rotation_enabled, [""]), 0)
}

#---------------------------------------------------
# AWS secretsmanager secret version
#---------------------------------------------------
output "secretsmanager_secret_version_id" {
  description = "A pipe delimited combination of secret ID and version ID."
  value       = element(concat(aws_secretsmanager_secret_version.secretsmanager_secret_version.*.id, [""]), 0)
}

output "secretsmanager_secret_version_arn" {
  description = "The ARN of the secret."
  value       = element(concat(aws_secretsmanager_secret_version.secretsmanager_secret_version.*.arn, [""]), 0)
}

output "secretsmanager_secret_version_version_id" {
  description = "The unique identifier of the version of the secret."
  value       = element(concat(aws_secretsmanager_secret_version.secretsmanager_secret_version.*.version_id, [""]), 0)
}

output "secretsmanager_secret_version_secret_string" {
  description = "Get secret string"
  value       = concat(aws_secretsmanager_secret_version.secretsmanager_secret_version.*.secret_string, [""])
}

#---------------------------------------------------
# AWS secretsmanager secret rotation
#---------------------------------------------------
output "secretsmanager_secret_rotation_id" {
  description = "Amazon Resource Name (ARN) of the secret."
  value       = element(concat(aws_secretsmanager_secret_rotation.secretsmanager_secret_rotation.*.id, [""]), 0)
}

output "secretsmanager_secret_rotation_arn" {
  description = "Amazon Resource Name (ARN) of the secret."
  value       = element(concat(aws_secretsmanager_secret_rotation.secretsmanager_secret_rotation.*.arn, [""]), 0)
}

output "secretsmanager_secret_rotation_rotation_enabled" {
  description = "Specifies whether automatic rotation is enabled for this secret."
  value       = concat(aws_secretsmanager_secret_rotation.secretsmanager_secret_rotation.*.rotation_enabled, [""])
}

#---------------------------------------------------
# AWS secretsmanager secret policy
#---------------------------------------------------
output "secretsmanager_secret_policy_id" {
  description = "Amazon Resource Name (ARN) of the secret."
  value       = element(concat(aws_secretsmanager_secret_policy.secretsmanager_secret_policy.*.id, [""]), 0)
}
