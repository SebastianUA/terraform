#-----------------------------------------------------------
# network firewall policy address list
#-----------------------------------------------------------
resource "oci_network_firewall_network_firewall_policy_address_list" "network_firewall_network_firewall_policy_address_list" {
  count = var.enable_network_firewall_network_firewall_policy_address_list ? 1 : 0

  # Required
  name                       = var.network_firewall_network_firewall_policy_address_list_name != "" ? var.network_firewall_network_firewall_policy_address_list_name : "${lower(var.name)}-net-firewall-address-list-${lower(var.environment)}"
  network_firewall_policy_id = var.network_firewall_network_firewall_policy_address_list_network_firewall_policy_id != "" && !var.enable_network_firewall_network_firewall_policy ? var.network_firewall_network_firewall_policy_address_list_network_firewall_policy_id : (var.enable_network_firewall_network_firewall_policy ? element(oci_network_firewall_network_firewall_policy.network_firewall_network_firewall_policy.*.id, 0) : null)
  type                       = var.network_firewall_network_firewall_policy_address_list_type

  # Optional
  addresses = var.network_firewall_network_firewall_policy_address_list_addresses

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.network_firewall_network_firewall_policy_address_list_timeouts)) > 0 ? [var.network_firewall_network_firewall_policy_address_list_timeouts] : []

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