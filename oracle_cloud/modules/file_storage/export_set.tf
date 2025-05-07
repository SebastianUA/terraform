#-----------------------------------------------------------
# export set
#-----------------------------------------------------------
resource "oci_file_storage_export_set" "file_storage_export_set" {
  count = var.enable_file_storage_export_set ? 1 : 0

  # Required
  mount_target_id = var.file_storage_export_set_mount_target_id != "" && !var.enable_file_storage_mount_target ? var.file_storage_export_set_mount_target_id : (var.enable_file_storage_mount_target ? element(oci_file_storage_mount_target.file_storage_mount_target.*.id, 0) : null)

  # Optional
  display_name      = var.file_storage_export_set_display_name != "" ? var.file_storage_export_set_display_name : "${lower(var.name)}-nfs-export-set-${lower(var.environment)}"
  max_fs_stat_bytes = var.file_storage_export_set_max_fs_stat_bytes
  max_fs_stat_files = var.file_storage_export_set_max_fs_stat_files

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.file_storage_export_set_timeouts)) > 0 ? [var.file_storage_export_set_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}