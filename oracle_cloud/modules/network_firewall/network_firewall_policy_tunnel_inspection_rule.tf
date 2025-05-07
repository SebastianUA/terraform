#-----------------------------------------------------------
# network firewall policy tunnel inspection rule
#-----------------------------------------------------------
resource "oci_network_firewall_network_firewall_policy_tunnel_inspection_rule" "network_firewall_network_firewall_policy_tunnel_inspection_rule" {
  count = var.enable_network_firewall_network_firewall_policy_tunnel_inspection_rule ? 1 : 0

  # Required
  dynamic "condition" {
    iterator = condition
    for_each = var.network_firewall_network_firewall_policy_tunnel_inspection_rule_condition

    content {
      # Optional
      destination_address = lookup(condition.value, "destination_address", null)
      source_address      = lookup(condition.value, "source_address", null)
    }
  }
  name                       = var.network_firewall_network_firewall_policy_tunnel_inspection_rule_name != "" ? var.network_firewall_network_firewall_policy_tunnel_inspection_rule_name : "${lower(var.name)}-net-firewall-policy-tunnel-inspection-rule-${lower(var.environment)}"
  network_firewall_policy_id = var.network_firewall_network_firewall_policy_tunnel_inspection_rule_network_firewall_policy_id != "" && !var.enable_network_firewall_network_firewall_policy ? var.network_firewall_network_firewall_policy_tunnel_inspection_rule_network_firewall_policy_id : (var.enable_network_firewall_network_firewall_policy ? element(oci_network_firewall_network_firewall_policy.network_firewall_network_firewall_policy.*.id, 0) : null)
  protocol                   = var.network_firewall_network_firewall_policy_tunnel_inspection_rule_protocol

  # Optional
  action = var.network_firewall_network_firewall_policy_tunnel_inspection_rule_action
  dynamic "position" {
    iterator = position
    for_each = var.network_firewall_network_firewall_policy_tunnel_inspection_rule_position

    content {
      # Optional
      after_rule  = lookup(position.value, "after_rule", null)
      before_rule = lookup(position.value, "before_rule", null)
    }
  }
  dynamic "profile" {
    iterator = profile
    for_each = length(keys(var.network_firewall_network_firewall_policy_tunnel_inspection_rule_profile)) > 0 ? [var.network_firewall_network_firewall_policy_tunnel_inspection_rule_profile] : []

    content {
      # Optional
      must_return_traffic_to_source = lookup(profile.value, "must_return_traffic_to_source", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.network_firewall_network_firewall_policy_tunnel_inspection_rule_timeouts)) > 0 ? [var.network_firewall_network_firewall_policy_tunnel_inspection_rule_timeouts] : []

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