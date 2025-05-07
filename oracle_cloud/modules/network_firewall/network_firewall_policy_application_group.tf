#-----------------------------------------------------------
# network firewall policy application group
#-----------------------------------------------------------
resource "oci_network_firewall_network_firewall_policy_application_group" "network_firewall_network_firewall_policy_application_group" {
  count = var.enable_network_firewall_network_firewall_policy_application_group ? 1 : 0

  # Required
  apps                       = var.network_firewall_network_firewall_policy_application_group_apps
  name                       = var.network_firewall_network_firewall_policy_application_group_name != "" ? var.network_firewall_network_firewall_policy_application_group_name : "${lower(var.name)}-net-firewall-policy-app-group-${lower(var.environment)}"
  network_firewall_policy_id = var.network_firewall_network_firewall_policy_application_group_network_firewall_policy_id != "" && !var.enable_network_firewall_network_firewall_policy ? var.network_firewall_network_firewall_policy_application_group_network_firewall_policy_id : (var.enable_network_firewall_network_firewall_policy ? element(oci_network_firewall_network_firewall_policy.network_firewall_network_firewall_policy.*.id, 0) : null)

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.network_firewall_network_firewall_policy_application_group_timeouts)) > 0 ? [var.network_firewall_network_firewall_policy_application_group_timeouts] : []

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