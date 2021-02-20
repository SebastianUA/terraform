#---------------------------------------------------
# AWS Backup vault policy
#---------------------------------------------------
resource "aws_backup_vault_policy" "backup_vault_policy" {
  count = var.enable_backup_vault_policy ? 1 : 0

  backup_vault_name = var.backup_vault_policy_backup_vault_name != "" ? var.backup_vault_policy_backup_vault_name : (var.enable_backup_vault ? element(aws_backup_vault.backup_vault.*.name, 0) : null)

  policy = var.backup_vault_policy

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_backup_vault.backup_vault
  ]
}