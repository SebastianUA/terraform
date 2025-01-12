#-----------------------------------------------------------
# compute cloud at customer ccc upgrade schedule
#-----------------------------------------------------------
resource "oci_compute_cloud_at_customer_ccc_upgrade_schedule" "ccc_upgrade_schedule" {
  count = var.enable_ccc_upgrade_schedule ? 1 : 0

  # Required
  compartment_id = var.ccc_upgrade_schedule_compartment_id
  display_name   = var.ccc_upgrade_schedule_display_name != "" ? var.ccc_upgrade_schedule_display_name : "${lower(var.name)}-ccc-upgrade-schedules-${lower(var.environment)}"

  dynamic "events" {
    iterator = events
    for_each = var.ccc_upgrade_schedule_events

    content {
      # Required
      description             = lookup(events.value, "description", null)
      schedule_event_duration = lookup(events.value, "schedule_event_duration", null)
      time_start              = lookup(events.value, "time_start", null)

      # Optional
      schedule_event_recurrences = lookup(events.value, "schedule_event_recurrences", null)
    }
  }

  # Optional
  description = var.ccc_upgrade_schedule_descriptions

  defined_tags = merge(
    {
      Name = var.ccc_upgrade_schedule_display_name != "" ? var.ccc_upgrade_schedule_display_name : "${lower(var.name)}-ccc-upgrade-schedules-${lower(var.environment)}"
    },
    var.tags
  )

  freeform_tags = var.ccc_upgrade_schedule_freeform_tags

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.ccc_upgrade_schedule_timeouts)) > 0 ? [var.ccc_upgrade_schedule_timeouts] : []

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