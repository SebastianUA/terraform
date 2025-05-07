#-----------------------------------------------------------
# network firewall policy service list
#-----------------------------------------------------------
resource "oci_network_firewall_network_firewall_policy_service_list" "network_firewall_network_firewall_policy_service_list" {
  count = var.enable_network_firewall_network_firewall_policy_service_list ? 1 : 0

  # Required
  name                       = var.network_firewall_network_firewall_policy_service_list_name != "" ? var.network_firewall_network_firewall_policy_service_list_name : "${lower(var.name)}-net-firewall-policy-svc-list-${lower(var.environment)}"
  network_firewall_policy_id = var.network_firewall_network_firewall_policy_service_list_network_firewall_policy_id != "" && !var.enable_network_firewall_network_firewall_policy ? var.network_firewall_network_firewall_policy_service_list_network_firewall_policy_id : (var.enable_network_firewall_network_firewall_policy ? element(oci_network_firewall_network_firewall_policy.network_firewall_network_firewall_policy.*.id, 0) : null)
  services                   = var.network_firewall_network_firewall_policy_service_list_services

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.network_firewall_network_firewall_policy_service_list_timeouts)) > 0 ? [var.network_firewall_network_firewall_policy_service_list_timeouts] : []

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