#-----------------------------------------------------------
# core service gateway
#-----------------------------------------------------------
resource "oci_core_service_gateway" "core_service_gateway" {
  count = var.enable_core_service_gateway ? 1 : 0

  # Required
  compartment_id = var.core_service_gateway_compartment_id

  dynamic "services" {
    iterator = services
    for_each = var.core_service_gateway_services

    content {
      # Required
      service_id = lookup(services.value, "service_id", null)
    }
  }
  vcn_id = var.core_service_gateway_vcn_id != "" && !var.enable_core_vcn ? var.core_service_gateway_vcn_id : (var.enable_core_vcn ? element(oci_core_vcn.core_vcn.*.id, 0) : null)

  # Optional
  display_name = var.core_service_gateway_display_name != "" ? var.core_service_gateway_display_name : "${lower(var.name)}-svc-gtw-${lower(var.environment)}"
  # TODO: Fix this routes if so!
  route_table_id = var.core_service_gateway_route_table_id != "" && !var.enable_core_route_table ? var.core_service_gateway_route_table_id : (var.enable_core_route_table ? element(oci_core_route_table.core_route_table.*.id, 0) : null)

  defined_tags = merge(
    {
      "company.Name" = var.core_service_gateway_display_name != "" ? var.core_service_gateway_display_name : "${lower(var.name)}-svc-gtw-${lower(var.environment)}"
    },
    var.tags
  )
  freeform_tags = var.core_service_gateway_freeform_tags

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_service_gateway_timeouts)) > 0 ? [var.core_service_gateway_timeouts] : []

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
