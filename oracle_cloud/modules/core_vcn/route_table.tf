#-----------------------------------------------------------
# core route table
#-----------------------------------------------------------
resource "oci_core_route_table" "core_route_table" {
  count = var.enable_core_route_table ? 1 : 0

  # Required
  compartment_id = var.core_route_table_compartment_id
  vcn_id         = var.core_route_table_vcn_id != "" && !var.enable_core_vcn ? var.core_route_table_vcn_id : (var.enable_core_vcn ? element(oci_core_vcn.core_vcn.*.id, 0) : null)

  #Optional
  display_name = var.core_route_table_display_name != "" ? var.core_route_table_display_name : "${lower(var.name)}-route-table-${lower(var.environment)}"

  dynamic "route_rules" {
    iterator = route_rules
    for_each = var.core_route_table_route_rules

    content {
      # Required
      network_entity_id = lookup(route_rules.value, "network_entity_id", null) #oci_core_internet_gateway.core_internet_gateway.id

      # Optional
      cidr_block       = lookup(route_rules.value, "cidr_block", null)
      description      = lookup(route_rules.value, "description", null)
      destination      = lookup(route_rules.value, "destination", null)
      destination_type = lookup(route_rules.value, "destination_type", null)
    }
  }

  defined_tags = merge(
    {
      "company.Name" = var.core_route_table_display_name != "" ? var.core_route_table_display_name : "${lower(var.name)}-route-table-${lower(var.environment)}"
    },
    var.tags
  )
  freeform_tags = var.core_route_table_freeform_tags

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_route_table_timeouts)) > 0 ? [var.core_route_table_timeouts] : []

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