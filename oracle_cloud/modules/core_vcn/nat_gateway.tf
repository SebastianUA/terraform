#-----------------------------------------------------------
# core nat gateway
#-----------------------------------------------------------
resource "oci_core_nat_gateway" "core_nat_gateway" {
  # TODO: Add it for public IPs
  count = var.enable_core_nat_gateway ? 1 : 0

  # Required
  compartment_id = var.core_nat_gateway_compartment_id
  vcn_id         = var.core_nat_gateway_vcn_id != "" && !var.enable_core_vcn ? var.core_nat_gateway_vcn_id : (var.enable_core_vcn ? element(oci_core_vcn.core_vcn.*.id, 0) : null)

  # Optional
  block_traffic  = var.core_nat_gateway_block_traffic
  display_name   = var.core_nat_gateway_display_name != "" ? var.core_nat_gateway_display_name : "${lower(var.name)}-nat-gtw-${lower(var.environment)}"
  public_ip_id   = var.core_nat_gateway_public_ip_id != "" && !var.enable_core_public_ip ? var.core_nat_gateway_route_table_id : (var.enable_core_public_ip ? element(oci_core_public_ip.core_public_ip.*.id, 0) : null)
  route_table_id = var.core_nat_gateway_route_table_id != "" && !var.enable_core_route_table ? var.core_nat_gateway_route_table_id : (var.enable_core_route_table ? element(oci_core_route_table.core_route_table.*.id, 0) : null)

  defined_tags = var.core_nat_gateway_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.core_nat_gateway_display_name != "" ? var.core_nat_gateway_display_name : "${lower(var.name)}-nat-gtw-${lower(var.environment)}"
    },
    var.tags
  )

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_nat_gateway_timeouts)) > 0 ? [var.core_nat_gateway_timeouts] : []

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