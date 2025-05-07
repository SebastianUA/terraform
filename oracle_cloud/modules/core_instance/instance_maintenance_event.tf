#-----------------------------------------------------------
# instance maintenance event
#-----------------------------------------------------------
resource "oci_core_instance_maintenance_event" "core_instance_maintenance_event" {
  count = var.enable_core_instance_maintenance_event ? 1 : 0

  # Required
  instance_maintenance_event_id = var.core_instance_maintenance_event_instance_maintenance_event_id != "" ? var.core_instance_maintenance_event_core_instance_maintenance_event_instance_maintenance_event_id : element(oci_core_instance_maintenance_event.core_instance_maintenance_event.*.id, 0)

  # Optional
  alternative_resolution_action = var.core_instance_maintenance_event_alternative_resolution_action
  can_delete_local_storage      = var.core_instance_maintenance_event_can_delete_local_storage
  display_name                  = var.core_instance_maintenance_event_display_name != "" ? var.core_instance_maintenance_event_display_name : "${lower(var.name)}-instance-mw-event-${lower(var.environment)}"
  time_window_start             = var.core_instance_maintenance_event_time_window_start

  defined_tags = var.core_instance_maintenance_event_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.core_instance_maintenance_event_display_name != "" ? var.core_instance_maintenance_event_display_name : "${lower(var.name)}-instance-mw-event-${lower(var.environment)}"
    },
    var.tags
  )
  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_instance_maintenance_event_timeouts)) > 0 ? [var.core_instance_maintenance_event_timeouts] : []

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