#-----------------------------------------------------------
# network firewall policy application
#-----------------------------------------------------------
resource "oci_network_firewall_network_firewall_policy_application" "network_firewall_network_firewall_policy_application" {
  count = var.enable_network_firewall_network_firewall_policy_application ? 1 : 0

  # Required
  icmp_type                  = var.network_firewall_network_firewall_policy_application_icmp_type
  name                       = var.network_firewall_network_firewall_policy_application_name != "" ? var.network_firewall_network_firewall_policy_application_name : "${lower(var.name)}-net-firewall-policy-app-${lower(var.environment)}"
  network_firewall_policy_id = var.network_firewall_network_firewall_policy_application_network_firewall_policy_id != "" && !var.enable_network_firewall_network_firewall_policy ? var.network_firewall_network_firewall_policy_application_network_firewall_policy_id : (var.enable_network_firewall_network_firewall_policy ? element(oci_network_firewall_network_firewall_policy.network_firewall_network_firewall_policy.*.id, 0) : null)
  type                       = var.network_firewall_network_firewall_policy_application_type

  # Optional
  icmp_code = var.network_firewall_network_firewall_policy_application_icmp_code

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.network_firewall_network_firewall_policy_application_timeouts)) > 0 ? [var.network_firewall_network_firewall_policy_application_timeouts] : []

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