#---------------------------------------------------
# AWS Backup global settings
#---------------------------------------------------
resource "aws_backup_global_settings" "backup_global_settings" {
  count = var.enable_backup_global_settings ? 1 : 0

  global_settings = var.backup_global_settings

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
