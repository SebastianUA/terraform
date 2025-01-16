#-----------------------------------------------------------
# core volume backup policy
#-----------------------------------------------------------
resource "oci_core_volume_backup_policy" "core_volume_backup_policy" {
  count = var.enable_core_volume_backup_policy ? 1 : 0

  # Required
  compartment_id = var.core_volume_backup_policy_compartment_id

  # Optional
  destination_region = var.core_volume_backup_policy_destination_region
  display_name       = var.core_volume_backup_policy_display_name != "" ? var.core_volume_backup_policy_display_name : "${lower(var.name)}-volume-backup-policy-${lower(var.environment)}"

  dynamic "schedules" {
    iterator = schedules
    for_each = var.core_volume_backup_policy_schedules

    content {
      # Required
      backup_type       = lookup(schedules.value, "backup_type", null)
      period            = lookup(schedules.value, "period", null)
      retention_seconds = lookup(schedules.value, "retention_seconds", null)

      # Optional
      day_of_month   = lookup(schedules.value, "day_of_month", null)
      day_of_week    = lookup(schedules.value, "day_of_week", null)
      hour_of_day    = lookup(schedules.value, "hour_of_day", null)
      month          = lookup(schedules.value, "month", null)
      offset_seconds = lookup(schedules.value, "offset_seconds", null)
      offset_type    = lookup(schedules.value, "offset_type", null)
      time_zone      = lookup(schedules.value, "time_zone", null)
    }
  }

  defined_tags = merge(
    {
      Name = var.core_volume_backup_policy_display_name != "" ? var.core_volume_backup_policy_display_name : "${lower(var.name)}-volume-backup-policy-${lower(var.environment)}"
    },
    var.tags
  )
  freeform_tags = var.core_volume_backup_policy_freeform_tags

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_volume_backup_policy_timeouts)) > 0 ? [var.core_volume_backup_policy_timeouts] : []

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