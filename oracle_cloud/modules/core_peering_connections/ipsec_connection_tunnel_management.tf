#-----------------------------------------------------------
# core ipsec connection tunnel management
#-----------------------------------------------------------
resource "oci_core_ipsec_connection_tunnel_management" "core_ipsec_connection_tunnel_management" {
  count = var.enable_core_ipsec_connection_tunnel_management ? 1 : 0

  # Required
  ipsec_id  = var.core_ipsec_connection_tunnel_management_ipsec_id != "" && !var.enable_core_ipsec ? var.core_ipsec_connection_tunnel_management_ipsec_id : (var.enable_core_ipsec ? element(oci_core_ipsec.core_ipsec.*.id, 0) : null)
  tunnel_id = var.core_ipsec_connection_tunnel_management_tunnel_id

  # Optional
  routing = var.core_ipsec_connection_tunnel_management_routing

  dynamic "bgp_session_info" {
    iterator = bgp_session_info
    for_each = var.core_ipsec_connection_tunnel_management_bgp_session_info

    content {
      # Optional
      customer_bgp_asn      = lookup(bgp_session_info.value, "customer_bgp_asn", null)
      customer_interface_ip = lookup(bgp_session_info.value, "customer_interface_ip", null)
      oracle_interface_ip   = lookup(bgp_session_info.value, "oracle_interface_ip", null)
    }
  }

  display_name = var.core_ipsec_connection_tunnel_management_display_name

  dynamic "encryption_domain_config" {
    iterator = encryption_domain_config
    for_each = var.core_ipsec_connection_tunnel_management_encryption_domain_config

    content {
      # Optional
      cpe_traffic_selector    = lookup(encryption_domain_config.value, "cpe_traffic_selector", null)
      oracle_traffic_selector = lookup(encryption_domain_config.value, "oracle_traffic_selector", null)
    }
  }

  shared_secret = var.core_ipsec_connection_tunnel_management_shared_secret
  ike_version   = var.core_ipsec_connection_tunnel_management_ike_version

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}