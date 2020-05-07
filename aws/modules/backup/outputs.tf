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
