#-----------------------------------------------------------
# instance console connection
#-----------------------------------------------------------
resource "oci_core_instance_console_connection" "core_instance_console_connection" {
  count = var.enable_core_instance_console_connection ? 1 : 0

  # Required
  instance_id = var.core_instance_console_connection_instance_id != "" && !var.enable_core_instance ? var.core_instance_console_connection_instance_id : element(oci_core_instance.core_instance.*.id, 0)
  public_key  = var.core_instance_console_connection_public_key

  # Optional
  defined_tags = var.core_instance_console_connection_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.core_instance_console_connection_name != "" ? var.core_instance_console_connection_name : "${lower(var.name)}-instance-console-connection-${lower(var.environment)}"
    },
    var.tags
  )
  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_instance_console_connection_timeouts)) > 0 ? [var.core_instance_console_connection_timeouts] : []

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