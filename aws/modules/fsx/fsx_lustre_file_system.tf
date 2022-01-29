#---------------------------------------------------
# AWS fsx lustre file system
#---------------------------------------------------
resource "aws_fsx_lustre_file_system" "fsx_lustre_file_system" {
  count = var.enable_fsx_lustre_file_system ? 1 : 0

  storage_capacity = var.fsx_lustre_file_system_storage_capacity
  subnet_ids       = var.fsx_lustre_file_system_subnet_ids

  export_path                   = var.fsx_lustre_file_system_export_path
  import_path                   = var.fsx_lustre_file_system_import_path
  imported_file_chunk_size      = var.fsx_lustre_file_system_imported_file_chunk_size
  security_group_ids            = var.fsx_lustre_file_system_security_group_ids
  weekly_maintenance_start_time = var.fsx_lustre_file_system_weekly_maintenance_start_time

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.fsx_lustre_file_system_timeouts)) > 0 ? [var.fsx_lustre_file_system_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.fsx_lustre_file_system_name != "" ? lower(var.fsx_lustre_file_system_name) : "${lower(var.name)}-fsx-lustre-file-system-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
