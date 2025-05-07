#-----------------------------------------------------------
# network firewall policy service
#-----------------------------------------------------------
resource "oci_network_firewall_network_firewall_policy_service" "network_firewall_network_firewall_policy_service" {
  count = var.enable_network_firewall_network_firewall_policy_service ? 1 : 0

  # Required
  name                       = var.network_firewall_network_firewall_policy_service_name != "" ? var.network_firewall_network_firewall_policy_service_name : "${lower(var.name)}-net-firewall-policy-svc-${lower(var.environment)}"
  network_firewall_policy_id = var.network_firewall_network_firewall_policy_service_network_firewall_policy_id != "" && !var.enable_network_firewall_network_firewall_policy ? var.network_firewall_network_firewall_policy_service_network_firewall_policy_id : (var.enable_network_firewall_network_firewall_policy ? element(oci_network_firewall_network_firewall_policy.network_firewall_network_firewall_policy.*.id, 0) : null)

  dynamic "port_ranges" {
    iterator = port_ranges
    for_each = var.network_firewall_network_firewall_policy_service_port_ranges

    content {
      # Required
      minimum_port = lookup(port_ranges.value, "minimum_port", null)

      # Optional
      maximum_port = lookup(port_ranges.value, "maximum_port", null)
    }
  }

  type = var.network_firewall_network_firewall_policy_service_type

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.network_firewall_network_firewall_policy_service_timeouts)) > 0 ? [var.network_firewall_network_firewall_policy_service_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [position]
  }

  depends_on = []
}