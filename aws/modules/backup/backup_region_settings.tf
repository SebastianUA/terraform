#---------------------------------------------------
# AWS Backup region settings
#---------------------------------------------------
resource "aws_backup_region_settings" "backup_region_settings" {
  count = var.enable_backup_region_settings ? 1 : 0

  resource_type_opt_in_preference = var.backup_region_settings_resource_type_opt_in_preference

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}