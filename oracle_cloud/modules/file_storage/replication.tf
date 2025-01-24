#-----------------------------------------------------------
# replication
#-----------------------------------------------------------
resource "oci_file_storage_replication" "file_storage_replication" {
  count = var.enable_file_storage_replication ? 1 : 0

  # Required
  compartment_id = var.file_storage_replication_compartment_id
  source_id      = var.file_storage_replication_source_id
  target_id      = var.file_storage_replication_target_id

  # Optional
  display_name         = var.file_storage_replication_display_name != "" ? var.file_storage_replication_display_name : "${lower(var.name)}-nfs-replication-${lower(var.environment)}"
  replication_interval = var.file_storage_replication_replication_interval

  dynamic "locks" {
    iterator = locks
    for_each = var.file_storage_replication_locks

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
      "company.Name" = var.file_storage_replication_display_name != "" ? var.file_storage_replication_display_name : "${lower(var.name)}-nfs-replication-${lower(var.environment)}"
    },
    var.tags
  )
  freeform_tags = var.file_storage_replication_freeform_tags

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.file_storage_replication_timeouts)) > 0 ? [var.file_storage_replication_timeouts] : []

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