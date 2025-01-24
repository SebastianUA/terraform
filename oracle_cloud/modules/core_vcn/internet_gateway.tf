#-----------------------------------------------------------
# core internet gateway
#-----------------------------------------------------------
resource "oci_core_internet_gateway" "core_internet_gateway" {
  # TODO: Add it for private subnets  
  count = var.enable_core_internet_gateway ? 1 : 0

  # Required
  compartment_id = var.core_internet_gateway_compartment_id
  vcn_id         = var.core_internet_gateway_vcn_id != "" && !var.enable_core_vcn ? var.core_internet_gateway_vcn_id : (var.enable_core_vcn ? element(oci_core_vcn.core_vcn.*.id, 0) : null)

  # Optional
  enabled        = var.core_internet_gateway_enabled
  display_name   = var.core_internet_gateway_display_name != "" ? var.core_internet_gateway_display_name : "${lower(var.name)}-internet-gtw-${lower(var.environment)}"
  route_table_id = var.core_internet_gateway_route_table_id != "" && !var.enable_core_route_table ? var.core_nat_gateway_route_table_id : (var.enable_core_route_table ? element(oci_core_route_table.core_route_table.*.id, 0) : null)

  defined_tags = merge(
    {
      "company.Name" = var.core_internet_gateway_display_name != "" ? var.core_internet_gateway_display_name : "${lower(var.name)}-internet-gtw-${lower(var.environment)}"
    },
    var.tags
  )
  freeform_tags = var.core_internet_gateway_freeform_tags

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_internet_gateway_timeouts)) > 0 ? [var.core_internet_gateway_timeouts] : []

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