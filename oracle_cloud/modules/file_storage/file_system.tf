#-----------------------------------------------------------
# file system
#-----------------------------------------------------------
resource "oci_file_storage_file_system" "file_storage_file_system" {
  count = var.enable_file_storage_file_system ? 1 : 0

  # Required
  availability_domain = var.file_storage_file_system_availability_domain
  compartment_id      = var.file_storage_file_system_compartment_id

  # Optional
  clone_attach_status           = var.file_storage_file_system_clone_attach_status
  display_name                  = var.file_storage_file_system_display_name != "" ? var.file_storage_file_system_display_name : "${lower(var.name)}-nfs-${lower(var.environment)}"
  filesystem_snapshot_policy_id = var.file_storage_file_system_filesystem_snapshot_policy_id != "" && !var.enable_file_storage_file_system ? var.file_storage_file_system_filesystem_snapshot_policy_id : (var.enable_file_storage_file_system ? element(oci_file_storage_filesystem_snapshot_policy.file_storage_filesystem_snapshot_policy.*.id, 0) : null)
  kms_key_id                    = var.file_storage_file_system_kms_key_id
  source_snapshot_id            = var.file_storage_file_system_source_snapshot_id != "" && !var.enable_file_storage_snapshot ? var.file_storage_file_system_source_snapshot_id : (var.enable_file_storage_snapshot ? element(oci_file_storage_snapshot.file_storage_snapshot.*.id, 0) : null)

  dynamic "locks" {
    iterator = locks
    for_each = var.file_storage_file_system_locks

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
      "company.Name" = var.file_storage_file_system_display_name != "" ? var.file_storage_file_system_display_name : "${lower(var.name)}-nfs-${lower(var.environment)}"
    },
    var.tags
  )
  freeform_tags = var.file_storage_file_system_freeform_tags

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.file_storage_file_system_timeouts)) > 0 ? [var.file_storage_file_system_timeouts] : []

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