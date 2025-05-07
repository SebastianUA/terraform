#-----------------------------------------------------------
# network firewall policy security rule
#-----------------------------------------------------------
resource "oci_network_firewall_network_firewall_policy_security_rule" "network_firewall_network_firewall_policy_security_rule" {
  count = var.enable_network_firewall_network_firewall_policy_security_rule ? 1 : 0

  # Required
  action = var.network_firewall_network_firewall_policy_security_rule_action
  name   = var.network_firewall_network_firewall_policy_security_rule_name != "" ? var.network_firewall_network_firewall_policy_security_rule_name : "${lower(var.name)}-net-firewall-policy-sec-rule-${lower(var.environment)}"
  dynamic "condition" {
    iterator = condition
    for_each = var.network_firewall_network_firewall_policy_security_rule_condition

    content {
      application         = lookup(condition.value, "application", null)
      destination_address = lookup(condition.value, "destination_address", null)
      service             = lookup(condition.value, "service", null)
      source_address      = lookup(condition.value, "source_address", null)
      url                 = lookup(condition.value, "url", null)
    }
  }
  network_firewall_policy_id = var.network_firewall_network_firewall_policy_security_rule_network_firewall_policy_id != "" && !var.enable_network_firewall_network_firewall_policy ? var.network_firewall_network_firewall_policy_security_rule_network_firewall_policy_id : (var.enable_network_firewall_network_firewall_policy ? element(oci_network_firewall_network_firewall_policy.network_firewall_network_firewall_policy.*.id, 0) : null)

  # Optional
  inspection = var.network_firewall_network_firewall_policy_security_rule_inspection

  dynamic "position" {
    iterator = position
    for_each = var.network_firewall_network_firewall_policy_security_rule_position

    content {
      # Optional
      after_rule  = lookup(position.value, "after_rule", null)
      before_rule = lookup(position.value, "before_rule", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.network_firewall_network_firewall_policy_security_rule_timeouts)) > 0 ? [var.network_firewall_network_firewall_policy_security_rule_timeouts] : []

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