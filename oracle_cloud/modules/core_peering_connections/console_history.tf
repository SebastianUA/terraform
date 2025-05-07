#-----------------------------------------------------------
# core console history
#-----------------------------------------------------------
resource "oci_core_console_history" "core_console_history" {
  count = var.enable_core_console_history ? 1 : 0

  # Required
  instance_id = var.core_console_history_instance_id

  # Optional
  display_name = var.core_console_history_display_name != "" ? var.core_console_history_display_name : "${lower(var.name)}-console-history-${lower(var.environment)}-${count.index + 1}"

  defined_tags = var.core_console_history_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.core_console_history_display_name != "" ? var.core_console_history_display_name : "${lower(var.name)}-console-history-${lower(var.environment)}-${count.index + 1}"
    },
    var.tags
  )

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_console_history_timeouts)) > 0 ? [var.core_console_history_timeouts] : []

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