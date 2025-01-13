#-----------------------------------------------------------
# export
#-----------------------------------------------------------
resource "oci_file_storage_export" "file_storage_export" {
  count = var.enable_file_storage_export ? 1 : 0

  # Required
  export_set_id  = var.file_storage_export_export_set_id != "" && !var.enable_file_storage_export_set ? var.file_storage_export_export_set_id : (var.enable_file_storage_export_set ? element(oci_file_storage_export_set.file_storage_export_set.*.id, 0) : null)
  file_system_id = var.file_storage_export_file_system_id != "" && !var.enable_file_storage_file_system ? var.file_storage_export_file_system_id : (var.enable_file_storage_file_system ? element(oci_file_storage_file_system.file_storage_file_system.*.id, 0) : null)
  path           = var.file_storage_export_path

  # Optional
  is_idmap_groups_for_sys_auth = var.file_storage_export_is_idmap_groups_for_sys_auth

  dynamic "export_options" {
    iterator = export_options
    for_each = var.file_storage_export_export_options

    content {
      # Required
      source = lookup(export_options.value, "source", null)

      # Optional
      access                         = lookup(export_options.value, "access", null)
      allowed_auth                   = lookup(export_options.value, "allowed_auth", null)
      anonymous_gid                  = lookup(export_options.value, "anonymous_gid", null)
      anonymous_uid                  = lookup(export_options.value, "anonymous_uid", null)
      identity_squash                = lookup(export_options.value, "identity_squash", null)
      is_anonymous_access_allowed    = lookup(export_options.value, "is_anonymous_access_allowed", null)
      require_privileged_source_port = lookup(export_options.value, "require_privileged_source_port", null)
    }
  }

  dynamic "locks" {
    iterator = locks
    for_each = var.file_storage_export_locks

    content {
      # Required
      type = lookup(locks.value, "type", null)

      # Optional
      message             = lookup(locks.value, "message", null)
      related_resource_id = lookup(locks.value, "related_resource_id", null)
      time_created        = lookup(locks.value, "time_created", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.file_storage_export_timeouts)) > 0 ? [var.file_storage_export_timeouts] : []

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