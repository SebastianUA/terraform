#-----------------------------------------------------------
# snapshot
#-----------------------------------------------------------
resource "oci_file_storage_snapshot" "file_storage_snapshot" {
  count = var.enable_file_storage_snapshot ? 1 : 0

  # Required
  file_system_id = var.file_storage_snapshot_file_system_id != "" && !var.enable_file_storage_file_system ? var.file_storage_snapshot_file_system_id : (var.enable_file_storage_file_system ? element(oci_file_storage_file_system.file_storage_file_system.*.id, 0) : null)
  name           = var.file_storage_snapshot_name != "" ? var.file_storage_snapshot_name : "${lower(var.name)}-nfs-snapshot-${lower(var.environment)}"

  # Optional
  expiration_time = var.file_storage_snapshot_expiration_time

  dynamic "locks" {
    iterator = locks
    for_each = var.file_storage_snapshot_locks

    content {
      # Required
      type = lookup(locks.value, "type", null)

      # Optional
      message             = lookup(locks.value, "message", null)
      related_resource_id = lookup(locks.value, "related_resource_id", null)
      time_created        = lookup(locks.value, "time_created", null)
    }
  }

  defined_tags = merge(
    {
      Name = var.file_storage_snapshot_name != "" ? var.file_storage_snapshot_name : "${lower(var.name)}-nfs-snapshot-${lower(var.environment)}"
    },
    var.tags
  )
  freeform_tags = var.file_storage_snapshot_freeform_tags

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.file_storage_snapshot_timeouts)) > 0 ? [var.file_storage_snapshot_timeouts] : []

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