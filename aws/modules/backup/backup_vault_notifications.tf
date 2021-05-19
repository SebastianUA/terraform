#---------------------------------------------------
# AWS Backup vault notifications
#---------------------------------------------------
resource "aws_backup_vault_notifications" "backup_vault_notifications" {
  count = var.enable_backup_vault_notifications ? 1 : 0

  backup_vault_name   = var.backup_vault_notifications_backup_vault_name != "" ? var.backup_vault_notifications_backup_vault_name : (var.enable_backup_vault ? element(aws_backup_vault.backup_vault.*.name, 0) : null)
  sns_topic_arn       = var.backup_vault_notifications_sns_topic_arn
  backup_vault_events = var.backup_vault_notifications_backup_vault_events

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_backup_vault.backup_vault
  ]
}
