#-----------------------------------------------------------
# core network security group security rule
#-----------------------------------------------------------
resource "oci_core_network_security_group_security_rule" "core_network_security_group_security_rule" {
  count = var.enable_core_network_security_group_security_rule ? 1 : 0

  # Required
  network_security_group_id = var.core_network_security_group_security_rule_network_security_group_id != "" && !var.enable_core_network_security_group ? var.core_network_security_group_security_rule_network_security_group_id : (var.enable_core_network_security_group ? element(oci_core_network_security_group.core_network_security_group.*.id, 0) : null)
  direction                 = var.core_network_security_group_security_rule_direction
  protocol                  = var.core_network_security_group_security_rule_protocol

  #Optional
  description      = var.core_network_security_group_security_rule_description
  destination      = var.core_network_security_group_security_rule_destination
  destination_type = var.core_network_security_group_security_rule_destination_type
  source           = var.core_network_security_group_security_rule_source
  source_type      = var.core_network_security_group_security_rule_source_type
  stateless        = var.core_network_security_group_security_rule_stateless

  dynamic "icmp_options" {
    iterator = icmp_options
    for_each = var.core_network_security_group_security_rule_icmp_options

    content {
      # Required
      type = lookup(icmp_options.value, "type", null)

      # Optional
      code = lookup(icmp_options.value, "type", null)
    }
  }

  dynamic "tcp_options" {
    iterator = tcp_options
    for_each = var.core_network_security_group_security_rule_tcp_options

    content {
      # Optional
      dynamic "destination_port_range" {
        iterator = destination_port_range
        for_each = length(keys(lookup(tcp_options.value, "destination_port_range", {}))) > 0 ? [lookup(tcp_options.value, "destination_port_range", {})] : []

        content {
          # Required
          max = lookup(destination_port_range.value, "max", null)
          min = lookup(destination_port_range.value, "max", null)
        }
      }
      dynamic "source_port_range" {
        iterator = source_port_range
        for_each = length(keys(lookup(tcp_options.value, "source_port_range", {}))) > 0 ? [lookup(tcp_options.value, "source_port_range", {})] : []

        content {
          # Required
          max = lookup(source_port_range.value, "max", null)
          min = lookup(source_port_range.value, "min", null)
        }
      }
    }
  }

  dynamic "udp_options" {
    iterator = udp_options
    for_each = var.core_network_security_group_security_rule_udp_options

    content {
      # Optional
      dynamic "destination_port_range" {
        iterator = destination_port_range
        for_each = length(keys(lookup(udp_options.value, "destination_port_range", {}))) > 0 ? [lookup(udp_options.value, "destination_port_range", {})] : []

        content {
          # Required
          max = lookup(destination_port_range.value, "max", null)
          min = lookup(destination_port_range.value, "max", null)
        }
      }
      dynamic "source_port_range" {
        iterator = source_port_range
        for_each = length(keys(lookup(udp_options.value, "source_port_range", {}))) > 0 ? [lookup(udp_options.value, "source_port_range", {})] : []

        content {
          # Required
          max = lookup(source_port_range.value, "max", null)
          min = lookup(source_port_range.value, "min", null)
        }
      }
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_network_security_group_security_rule_timeouts)) > 0 ? [var.core_network_security_group_security_rule_timeouts] : []

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
