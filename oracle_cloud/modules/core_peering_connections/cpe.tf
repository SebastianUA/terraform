#-----------------------------------------------------------
# Core cpe
#-----------------------------------------------------------
resource "oci_core_cpe" "core_cpe" {
  count = var.enable_core_cpe ? 1 : 0

  # Required
  compartment_id = var.compartment_id
  ip_address     = var.core_cpe_ip_address

  # Optional
  cpe_device_shape_id = var.core_cpe_cpe_device_shape_id
  display_name        = var.core_cpe_display_name != "" ? var.core_cpe_display_name : "${lower(var.name)}-cpe-${lower(var.environment)}-${count.index + 1}"
  is_private          = var.core_cpe_is_private

  defined_tags = var.core_cpe_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.core_cpe_display_name != "" ? var.core_cpe_display_name : "${lower(var.name)}-cpe-${lower(var.environment)}-${count.index + 1}"
    },
    var.tags
  )

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_cpe_timeouts)) > 0 ? [var.core_cpe_timeouts] : []

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