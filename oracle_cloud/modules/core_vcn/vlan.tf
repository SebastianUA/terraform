#-----------------------------------------------------------
# core vlan
#-----------------------------------------------------------
resource "oci_core_vlan" "core_vlan" {
  # TODO: Add multiple vlans  
  count = var.enable_core_vlan ? 1 : 0

  # Required
  cidr_block     = var.core_vlan_cidr_block
  compartment_id = var.compartment_id
  vcn_id         = var.core_vlan_vcn_id != "" && !var.enable_core_vcn ? var.core_vlan_vcn_id : (var.enable_core_vcn ? element(oci_core_vcn.core_vcn.*.id, 0) : null)

  # Optional
  display_name        = var.core_vlan_display_name != "" ? var.core_vlan_display_name : "${lower(var.name)}-vlan-${lower(var.environment)}"
  availability_domain = var.core_vlan_availability_domain
  nsg_ids             = var.core_vlan_nsg_ids
  route_table_id      = var.core_vlan_route_table_id != "" && !var.enable_core_route_table ? var.core_vlan_route_table_id : (var.enable_core_route_table ? element(oci_core_route_table.core_route_table.*.id, 0) : null)
  vlan_tag            = var.core_vlan_vlan_tag

  defined_tags = var.core_vlan_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.core_vlan_display_name != "" ? var.core_vlan_display_name : "${lower(var.name)}-vlan-${lower(var.environment)}"
    },
    var.tags
  )

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_vlan_timeouts)) > 0 ? [var.core_vlan_timeouts] : []

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