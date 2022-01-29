#---------------------------------------------------
# AWS fsx windows file system
#---------------------------------------------------
resource "aws_fsx_windows_file_system" "fsx_windows_file_system" {
  count = var.enable_fsx_windows_file_system ? 1 : 0

  storage_capacity    = var.fsx_windows_file_system_storage_capacity
  subnet_ids          = var.fsx_windows_file_system_subnet_ids
  throughput_capacity = var.fsx_windows_file_system_throughput_capacity

  active_directory_id               = var.fsx_windows_file_system_active_directory_id
  automatic_backup_retention_days   = var.fsx_windows_file_system_automatic_backup_retention_days
  copy_tags_to_backups              = var.fsx_windows_file_system_copy_tags_to_backups
  daily_automatic_backup_start_time = var.fsx_windows_file_system_daily_automatic_backup_start_time
  kms_key_id                        = var.fsx_windows_file_system_kms_key_id
  security_group_ids                = var.fsx_windows_file_system_security_group_ids
  skip_final_backup                 = var.fsx_windows_file_system_skip_final_backup
  weekly_maintenance_start_time     = var.fsx_windows_file_system_weekly_maintenance_start_time

  dynamic "self_managed_active_directory" {
    iterator = self_managed_active_directory
    for_each = var.fsx_windows_file_system_self_managed_active_directory

    content {
      dns_ips     = lookup(self_managed_active_directory.value, "dns_ips", null)
      domain_name = lookup(self_managed_active_directory.value, "domain_name", null)
      password    = lookup(self_managed_active_directory.value, "password", null)
      username    = lookup(self_managed_active_directory.value, "username", null)

      file_system_administrators_group       = lookup(self_managed_active_directory.value, "file_system_administrators_group", null)
      organizational_unit_distinguished_name = lookup(self_managed_active_directory.value, "organizational_unit_distinguished_name", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.fsx_windows_file_system_timeouts)) > 0 ? [var.fsx_windows_file_system_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.fsx_windows_file_system_name != "" ? lower(var.fsx_windows_file_system_name) : "${lower(var.name)}-fsx-windows-file-system-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
