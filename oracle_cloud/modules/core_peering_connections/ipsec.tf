#-----------------------------------------------------------
# core ipsec
#-----------------------------------------------------------
resource "oci_core_ipsec" "core_ipsec" {
  count = var.enable_core_ipsec ? 1 : 0

  # Required
  compartment_id = var.compartment_id
  cpe_id         = var.core_ipsec_cpe_id
  drg_id         = var.core_ipsec_drg_id
  static_routes  = var.core_ipsec_static_routes

  # Optional
  cpe_local_identifier      = var.core_ipsec_cpe_local_identifier
  cpe_local_identifier_type = var.core_ipsec_cpe_local_identifier_type
  display_name              = var.core_ipsec_display_name != "" ? var.core_ipsec_display_name : "${lower(var.name)}-ipsec-${lower(var.environment)}-${count.index + 1}"

  dynamic "tunnel_configuration" {
    iterator = tunnel_configuration
    for_each = var.core_ipsec_tunnel_configuration

    content {
      oracle_tunnel_ip            = lookup(tunnel_configuration.value, "oracle_tunnel_ip", null)
      associated_virtual_circuits = lookup(tunnel_configuration.value, "associated_virtual_circuits", null)
      drg_route_table_id          = lookup(tunnel_configuration.value, "drg_route_table_id", null)
    }
  }

  defined_tags = var.var.core_ipsec_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.core_ipsec_display_name != "" ? var.core_ipsec_display_name : "${lower(var.name)}-ipsec-${lower(var.environment)}-${count.index + 1}"
    },
    var.tags
  )

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_ipsec_timeouts)) > 0 ? [var.core_ipsec_timeouts] : []

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