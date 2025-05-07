#-----------------------------------------------------------
# network firewall network firewall policy url list
#-----------------------------------------------------------
resource "oci_network_firewall_network_firewall_policy_url_list" "network_firewall_network_firewall_policy_url_list" {
  count = var.enable_network_firewall_network_firewall_policy_url_list ? 1 : 0

  # Required
  name                       = var.network_firewall_network_firewall_policy_url_list_name != "" ? var.network_firewall_network_firewall_policy_url_list_name : "${lower(var.name)}-net-firewall-policy-url-list-${lower(var.environment)}"
  network_firewall_policy_id = var.network_firewall_network_firewall_policy_url_list_network_firewall_policy_id != "" && !var.enable_network_firewall_network_firewall_policy ? var.network_firewall_network_firewall_policy_url_list_network_firewall_policy_id : (var.enable_network_firewall_network_firewall_policy ? element(oci_network_firewall_network_firewall_policy.network_firewall_network_firewall_policy.*.id, 0) : null)

  dynamic "urls" {
    iterator = urls
    for_each = var.network_firewall_network_firewall_policy_url_list_urls

    content {
      # Required
      pattern = lookup(urls.value, "pattern", null)
      type    = lookup(urls.value, "type", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.network_firewall_network_firewall_policy_url_list_timeouts)) > 0 ? [var.network_firewall_network_firewall_policy_url_list_timeouts] : []

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