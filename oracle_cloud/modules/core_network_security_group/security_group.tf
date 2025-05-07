#-----------------------------------------------------------
# core network security group
#-----------------------------------------------------------
resource "oci_core_network_security_group" "core_network_security_group" {
  count = var.enable_core_network_security_group ? 1 : 0

  # Required
  compartment_id = var.core_network_security_group_compartment_id
  vcn_id         = var.core_network_security_group_vcn_id

  # Optional
  display_name = var.core_network_security_group_display_name != "" ? var.core_network_security_group_display_name : "${lower(var.name)}-nsg-${lower(var.environment)}"

  defined_tags = var.core_network_security_group_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.core_network_security_group_display_name != "" ? var.core_network_security_group_display_name : "${lower(var.name)}-nsg-${lower(var.environment)}"
    },
    var.tags
  )

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_network_security_group_timeouts)) > 0 ? [var.core_network_security_group_timeouts] : []

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
