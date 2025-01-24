#-----------------------------------------------------------
# filesystem snapshot policy
#-----------------------------------------------------------
resource "oci_file_storage_filesystem_snapshot_policy" "file_storage_filesystem_snapshot_policy" {
  count = var.enable_file_storage_filesystem_snapshot_policy ? 1 : 0

  # Required
  availability_domain = var.file_storage_filesystem_snapshot_policy_availability_domain
  compartment_id      = var.file_storage_filesystem_snapshot_policy_compartment_id

  # Optional
  display_name  = var.file_storage_filesystem_snapshot_policy_display_name != "" ? var.file_storage_filesystem_snapshot_policy_display_name : "${lower(var.name)}-nfs-snapshot-policy-${lower(var.environment)}"
  policy_prefix = var.file_storage_filesystem_snapshot_policy_policy_prefix

  dynamic "locks" {
    iterator = locks
    for_each = var.file_storage_filesystem_snapshot_policy_locks

    content {
      # Required
      type = lookup(locks.value, "type", null)

      # Optional
      message             = lookup(locks.value, "message", null)
      related_resource_id = lookup(locks.value, "related_resource_id", null)
      time_created        = lookup(locks.value, "time_created", null)
    }
  }

  dynamic "schedules" {
    iterator = schedules
    for_each = var.file_storage_filesystem_snapshot_policy_schedules

    content {
      # Required
      period    = lookup(schedules.value, "period", null)
      time_zone = lookup(schedules.value, "time_zone", null)

      # Optional
      day_of_month                  = lookup(schedules.value, "day_of_month", null)
      day_of_week                   = lookup(schedules.value, "day_of_week", null)
      hour_of_day                   = lookup(schedules.value, "hour_of_day", null)
      month                         = lookup(schedules.value, "month", null)
      retention_duration_in_seconds = lookup(schedules.value, "retention_duration_in_seconds", null)
      schedule_prefix               = lookup(schedules.value, "schedule_prefix", null)
      time_schedule_start           = lookup(schedules.value, "time_schedule_start", null)
    }
  }

  defined_tags = merge(
    {
      "company.Name" = var.file_storage_filesystem_snapshot_policy_display_name != "" ? var.file_storage_filesystem_snapshot_policy_display_name : "${lower(var.name)}-nfs-snapshot-policy-${lower(var.environment)}"
    },
    var.tags
  )
  freeform_tags = var.file_storage_filesystem_snapshot_policy_freeform_tags

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.file_storage_filesystem_snapshot_policy_timeouts)) > 0 ? [var.file_storage_filesystem_snapshot_policy_timeouts] : []

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