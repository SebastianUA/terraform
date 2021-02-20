#---------------------------------------------------
# AWS Backup plan
#---------------------------------------------------
output "backup_plan_id" {
  description = "The id of the backup plan."
  value       = element(concat(aws_backup_plan.backup_plan.*.id, [""]), 0)
}

output "backup_plan_arn" {
  description = "The ARN of the backup plan."
  value       = element(concat(aws_backup_plan.backup_plan.*.arn, [""]), 0)
}

output "backup_plan_version" {
  description = "Unique, randomly generated, Unicode, UTF-8 encoded string that serves as the version ID of the backup plan."
  value       = element(concat(aws_backup_plan.backup_plan.*.version, [""]), 0)
}

#---------------------------------------------------
# AWS Backup selection
#---------------------------------------------------
output "backup_selection_id" {
  description = "Backup Selection identifier"
  value       = element(concat(aws_backup_selection.backup_selection.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS Backup global settings
#---------------------------------------------------
output "backup_global_settings_id" {
  description = "The AWS Account ID."
  value       = element(concat(aws_backup_global_settings.backup_global_settings.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS Backup region settings
#---------------------------------------------------
output "backup_region_settings_id" {
  description = "The AWS Account ID."
  value       = element(concat(aws_backup_region_settings.backup_region_settings.*.id, [""]), 0)
}

#---------------------------------------------------
# AWS Backup vault
#---------------------------------------------------
output "backup_vault_id" {
  description = "The name of the vault."
  value       = element(concat(aws_backup_vault.backup_vault.*.id, [""]), 0)
}

output "backup_vault_arn" {
  description = "The ARN of the vault."
  value       = element(concat(aws_backup_vault.backup_vault.*.arn, [""]), 0)
}

output "backup_vault_recovery_points" {
  description = "The number of recovery points that are stored in a backup vault."
  value       = element(concat(aws_backup_vault.backup_vault.*.recovery_points, [""]), 0)
}

#---------------------------------------------------
# AWS Backup vault policy
#---------------------------------------------------
output "backup_vault_policy_id" {
  description = "The name of the vault policy."
  value       = element(concat(aws_backup_vault_policy.backup_vault_policy.*.id, [""]), 0)
}

output "backup_vault_policy_backup_vault_arn" {
  description = "The ARN of the vault."
  value       = element(concat(aws_backup_vault_policy.backup_vault_policy.*.backup_vault_arn, [""]), 0)
}

#---------------------------------------------------
# AWS Backup vault notifications
#---------------------------------------------------
output "backup_vault_notifications_id" {
  description = "The name of the vault notifications."
  value       = element(concat(aws_backup_vault_notifications.backup_vault_notifications.*.id, [""]), 0)
}

output "backup_vault_notifications_backup_vault_arn" {
  description = "The ARN of the vault."
  value       = element(concat(aws_backup_vault_notifications.backup_vault_notifications.*.backup_vault_arn, [""]), 0)
}
