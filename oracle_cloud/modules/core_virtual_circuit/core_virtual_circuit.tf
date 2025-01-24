#-----------------------------------------------------------
# core virtual circuit
#-----------------------------------------------------------
resource "oci_core_virtual_circuit" "core_virtual_circuit" {
  count = var.enable_core_virtual_circuit ? 1 : 0

  # Required
  compartment_id = var.core_virtual_circuit_compartment_id
  type           = var.core_virtual_circuit_type

  # Optional
  bandwidth_shape_name = var.core_virtual_circuit_bandwidth_shape_name
  bgp_admin_state      = var.core_virtual_circuit_bgp_admin_state

  dynamic "cross_connect_mappings" {
    iterator = cross_connect_mappings
    for_each = var.core_virtual_circuit_cross_connect_mappings

    content {
      # Optional
      bgp_md5auth_key                         = lookup(cross_connect_mappings.value, "bgp_md5auth_key", null)
      cross_connect_or_cross_connect_group_id = lookup(cross_connect_mappings.value, "cross_connect_or_cross_connect_group_id", null)
      customer_bgp_peering_ip                 = lookup(cross_connect_mappings.value, "customer_bgp_peering_ip", null)
      customer_bgp_peering_ipv6               = lookup(cross_connect_mappings.value, "customer_bgp_peering_ipv6", null)
      oracle_bgp_peering_ip                   = lookup(cross_connect_mappings.value, "oracle_bgp_peering_ip", null)
      oracle_bgp_peering_ipv6                 = lookup(cross_connect_mappings.value, "oracle_bgp_peering_ipv6", null)
      vlan                                    = lookup(cross_connect_mappings.value, "vlan", null)
    }
  }

  customer_asn              = var.core_virtual_circuit_customer_asn
  customer_bgp_asn          = var.core_virtual_circuit_customer_bgp_asn
  display_name              = var.core_virtual_circuit_display_name != "" ? var.core_virtual_circuit_display_name : "${lower(var.name)}-virtual-circuit-${lower(var.environment)}"
  ip_mtu                    = var.core_virtual_circuit_ip_mtu
  is_bfd_enabled            = var.core_virtual_circuit_is_bfd_enabled
  is_transport_mode         = var.core_virtual_circuit_is_transport_mode
  gateway_id                = var.core_virtual_circuit_gateway_id
  provider_service_id       = var.core_virtual_circuit_provider_service_id
  provider_service_key_name = var.core_virtual_circuit_provider_service_key_name
  region                    = var.core_virtual_circuit_region
  routing_policy            = var.core_virtual_circuit_routing_policy

  dynamic "public_prefixes" {
    iterator = public_prefixes
    for_each = var.core_virtual_circuit_public_prefixes

    content {
      # Required
      cidr_block = lookup(public_prefixes.value, "cidr_block", null)
    }
  }

  defined_tags = merge(
    {
      "company.Name" = var.core_virtual_circuit_display_name != "" ? var.core_virtual_circuit_display_name : "${lower(var.name)}-virtual-circuit-${lower(var.environment)}"
    },
    var.tags
  )
  freeform_tags = var.core_virtual_circuit_freeform_tags

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_virtual_circuit_timeouts)) > 0 ? [var.core_virtual_circuit_timeouts] : []

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
