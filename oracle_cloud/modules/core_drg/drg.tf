#-----------------------------------------------------------
# core drg
#-----------------------------------------------------------
resource "oci_core_drg" "core_drg" {
  count = var.enable_core_drg ? 1 : 0

  # Required
  compartment_id = var.core_drg_compartment_id

  # Optional
  display_name = var.core_drg_display_name != "" ? var.core_drg_display_name : "${lower(var.name)}-drg-${lower(var.environment)}"

  defined_tags = merge(
    {
      Name = var.core_drg_display_name != "" ? var.core_drg_display_name : "${lower(var.name)}-drg-${lower(var.environment)}"
    },
    var.tags
  )
  freeform_tags = var.core_drg_freeform_tags

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_drg_timeouts)) > 0 ? [var.core_drg_timeouts] : []

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