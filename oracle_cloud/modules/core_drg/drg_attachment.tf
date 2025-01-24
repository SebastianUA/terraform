#-----------------------------------------------------------
# core drg attachment
#-----------------------------------------------------------
resource "oci_core_drg_attachment" "core_drg_attachment" {
  count = var.enable_core_drg_attachment ? 1 : 0

  # Required
  drg_id = var.core_drg_attachment_drg_id != "" && !var.enable_core_drg ? var.core_drg_attachment_drg_id : (var.enable_core_drg ? element(oci_core_drg.core_drg.*.id, 0) : null)

  # Optional
  display_name       = var.core_drg_attachment_display_name != "" ? var.core_drg_attachment_display_name : "${lower(var.name)}-drg-attachment-${lower(var.environment)}"
  drg_route_table_id = var.core_drg_attachment_drg_route_table_id != "" && !var.enable_core_drg_route_table ? var.core_drg_attachment_drg_route_table_id : (var.enable_core_drg_route_table ? element(oci_core_drg_route_table.core_drg_route_table.*.id, 0) : null)

  dynamic "network_details" {
    iterator = network_details
    for_each = var.core_drg_attachment_network_details

    content {
      # Required
      type = lookup(network_details.value, "type", null)

      # Optional
      id             = lookup(network_details.value, "id", null)
      route_table_id = lookup(network_details.value, "route_table_id", null)
      vcn_route_type = lookup(network_details.value, "vcn_route_type", null)
    }
  }

  defined_tags = var.core_drg_attachment_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.core_drg_attachment_display_name != "" ? var.core_drg_attachment_display_name : "${lower(var.name)}-drg-attachment-${lower(var.environment)}"
    },
    var.tags
  )

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_drg_attachment_timeouts)) > 0 ? [var.core_drg_attachment_timeouts] : []

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