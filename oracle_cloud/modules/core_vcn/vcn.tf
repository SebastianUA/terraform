#-----------------------------------------------------------
# core vcn
#-----------------------------------------------------------
resource "oci_core_vcn" "core_vcn" {
  count = var.enable_core_vcn ? 1 : 0

  # Required
  compartment_id = var.core_vcn_compartment_id

  # Optional
  dynamic "byoipv6cidr_details" {
    iterator = byoipv6cidr_details
    for_each = var.core_vcn_byoipv6cidr_details

    content {
      # Required
      byoipv6range_id = lookup(byoipv6cidr_details.value, "byoipv6range_id", null)
      ipv6cidr_block  = lookup(byoipv6cidr_details.value, "ipv6cidr_block", null)
    }
  }

  display_name                     = var.core_vcn_display_name != "" ? var.core_vcn_display_name : "${lower(var.name)}-vcn-${lower(var.environment)}"
  cidr_blocks                      = var.core_vcn_cidr_blocks
  dns_label                        = var.core_vcn_dns_label
  ipv6private_cidr_blocks          = var.core_vcn_ipv6private_cidr_blocks
  is_ipv6enabled                   = var.core_vcn_is_ipv6enabled
  is_oracle_gua_allocation_enabled = var.core_vcn_is_oracle_gua_allocation_enabled
  security_attributes              = var.core_vcn_security_attributes

  defined_tags = merge(
    {
      "company.Name" = var.core_vcn_display_name != "" ? var.core_vcn_display_name : "${lower(var.name)}-vcn-${lower(var.environment)}"
    },
    var.tags
  )
  freeform_tags = var.core_vcn_freeform_tags

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_vcn_timeouts)) > 0 ? [var.core_vcn_timeouts] : []

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