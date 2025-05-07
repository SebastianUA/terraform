#-----------------------------------------------------------
# network firewall policy decryption rule
#-----------------------------------------------------------
resource "oci_network_firewall_network_firewall_policy_decryption_rule" "network_firewall_network_firewall_policy_decryption_rule" {
  count = var.enable_network_firewall_network_firewall_policy_decryption_rule ? 1 : 0

  # Required
  name   = var.network_firewall_network_firewall_policy_decryption_rule_name != "" ? var.network_firewall_network_firewall_policy_decryption_rule_name : "${lower(var.name)}-net-firewall-policy-decr-rule-${lower(var.environment)}"
  action = var.network_firewall_network_firewall_policy_decryption_rule_action

  dynamic "condition" {
    iterator = condition
    for_each = var.network_firewall_network_firewall_policy_decryption_rule_condition

    content {
      destination_address = lookup(condition.value, "destination_address", null)
      source_address      = lookup(condition.value, "source_address", null)
    }
  }
  dynamic "position" {
    iterator = position
    for_each = var.network_firewall_network_firewall_policy_decryption_rule_position

    content {
      # Optional
      after_rule  = lookup(position.value, "after_rule", null)
      before_rule = lookup(position.value, "before_rule", null)
    }
  }
  network_firewall_policy_id = var.network_firewall_network_firewall_policy_decryption_rule_network_firewall_policy_id != "" && !var.enable_network_firewall_network_firewall_policy ? var.network_firewall_network_firewall_policy_decryption_rule_network_firewall_policy_id : (var.enable_network_firewall_network_firewall_policy ? element(oci_network_firewall_network_firewall_policy.network_firewall_network_firewall_policy.*.id, 0) : null)

  # Optional
  decryption_profile = var.network_firewall_network_firewall_policy_decryption_rule_decryption_profile
  secret             = var.network_firewall_network_firewall_policy_decryption_rule_secret

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.network_firewall_network_firewall_policy_decryption_rule_timeouts)) > 0 ? [var.network_firewall_network_firewall_policy_decryption_rule_timeouts] : []

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