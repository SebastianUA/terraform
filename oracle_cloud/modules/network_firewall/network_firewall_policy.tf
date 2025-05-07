#-----------------------------------------------------------
# network firewall policy
#-----------------------------------------------------------
resource "oci_network_firewall_network_firewall_policy" "network_firewall_network_firewall_policy" {
  count = var.enable_network_firewall_network_firewall_policy ? 1 : 0

  # Required
  compartment_id = var.compartment_id

  # Optional
  display_name = var.network_firewall_network_firewall_policy_display_name != "" ? var.network_firewall_network_firewall_policy_display_name : "${lower(var.name)}-net-firewall-policy-${lower(var.environment)}"

  defined_tags = var.network_firewall_network_firewall_policy_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.network_firewall_network_firewall_policy_display_name != "" ? var.network_firewall_network_firewall_policy_display_name : "${lower(var.name)}-net-firewall-policy-${lower(var.environment)}"
    },
    var.tags
  )
  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.network_firewall_network_firewall_policy_timeouts)) > 0 ? [var.network_firewall_network_firewall_policy_timeouts] : []

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