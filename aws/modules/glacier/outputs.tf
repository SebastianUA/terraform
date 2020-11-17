#---------------------------------------------------
# AWS glacier vault
#---------------------------------------------------
output "glacier_vault_id" {
  description = "ID of glacier vault"
  value       = element(concat(aws_glacier_vault.glacier_vault.*.id, [""]), 0)
}

output "glacier_vault_arn" {
  description = "The ARN of the vault."
  value       = element(concat(aws_glacier_vault.glacier_vault.*.arn, [""]), 0)
}

output "glacier_vault_location" {
  description = "The URI of the vault that was created."
  value       = element(concat(aws_glacier_vault.glacier_vault.*.location, [""]), 0)
}

#---------------------------------------------------
# AWS glacier vault lock
#---------------------------------------------------
output "glacier_vault_lock_id" {
  description = "Glacier Vault name."
  value       = element(concat(aws_glacier_vault_lock.glacier_vault_lock.*.id, [""]), 0)
}
