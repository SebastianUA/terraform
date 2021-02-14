#---------------------------------------------------
# AWS Backup vault
#---------------------------------------------------
resource "aws_backup_vault" "backup_vault" {
  count = var.enable_backup_vault ? 1 : 0

  name = var.backup_vault_name != "" ? lower(var.backup_vault_name) : "${lower(var.name)}-backup-vault-${lower(var.environment)}"

  kms_key_arn = var.backup_vault_kms_key_arn

  tags = merge(
    {
      Name = var.backup_vault_name != "" ? lower(var.backup_vault_name) : "${lower(var.name)}-backup-vault-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
