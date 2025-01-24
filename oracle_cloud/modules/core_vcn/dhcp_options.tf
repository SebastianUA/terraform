#-----------------------------------------------------------
# core dhcp options
#-----------------------------------------------------------
resource "oci_core_dhcp_options" "core_dhcp_options" {
  count = var.enable_core_dhcp_options ? 1 : 0

  # Required
  compartment_id = var.core_dhcp_options_compartment_id

  dynamic "options" {
    iterator = options
    for_each = var.core_dhcp_options_options

    content {
      type        = lookup(options.value, "type", null)
      server_type = lookup(options.value, "server_type", null)

      # Handle custom_dns_servers with default to empty list and validate length
      custom_dns_servers = lookup(options.value, "custom_dns_servers", [])

      search_domain_names = lookup(options.value, "search_domain_names", null)
    }
  }

  vcn_id = var.core_dhcp_options_vcn_id != "" && !var.enable_core_vcn ? var.core_dhcp_options_vcn_id : (var.enable_core_vcn ? element(oci_core_vcn.core_vcn.*.id, 0) : null)

  # Optional
  display_name = var.core_dhcp_options_display_name != "" ? var.core_dhcp_options_display_name : "${lower(var.name)}-dhcp-options-${lower(var.environment)}"

  defined_tags = var.core_dhcp_options_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.core_dhcp_options_display_name != "" ? var.core_dhcp_options_display_name : "${lower(var.name)}-dhcp-options-${lower(var.environment)}"
    },
    var.tags
  )

  # freeform_tags = var.core_dhcp_options_freeform_tags

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_dhcp_options_timeouts)) > 0 ? [var.core_dhcp_options_timeouts] : []

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