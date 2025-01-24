#-----------------------------------------------------------
# core local peering gateway
#-----------------------------------------------------------
resource "oci_core_local_peering_gateway" "core_local_peering_gateway" {
  count = var.enable_core_local_peering_gateway ? 1 : 0

  # Required
  compartment_id = var.core_local_peering_gateway_compartment_id
  vcn_id         = var.core_local_peering_gateway_vcn_id != "" && !var.enable_core_vcn ? var.core_local_peering_gateway_vcn_id : (var.enable_core_vcn ? element(oci_core_vcn.core_vcn.*.id, 0) : null)

  # Optional
  display_name   = var.core_local_peering_gateway_display_name != "" ? var.core_local_peering_gateway_display_name : "${lower(var.name)}-local-peering-gtw-${lower(var.environment)}"
  peer_id        = var.core_local_peering_gateway_peer_id
  route_table_id = var.core_local_peering_gateway_route_table_id != "" && !var.enable_core_route_table ? var.core_local_peering_gateway_route_table_id : (var.enable_core_route_table ? element(oci_core_route_table.core_route_table.*.id, 0) : null)

  defined_tags = var.core_local_peering_gateway_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.core_local_peering_gateway_display_name != "" ? var.core_local_peering_gateway_display_name : "${lower(var.name)}-local-peering-gtw-${lower(var.environment)}"
    },
    var.tags
  )

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_local_peering_gateway_timeouts)) > 0 ? [var.core_local_peering_gateway_timeouts] : []

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