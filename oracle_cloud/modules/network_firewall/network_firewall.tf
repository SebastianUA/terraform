#-----------------------------------------------------------
# network firewall
#-----------------------------------------------------------
resource "oci_network_firewall_network_firewall" "network_firewall_network_firewall" {
  count = var.enable_network_firewall_network_firewall ? 1 : 0

  # Required
  compartment_id             = var.compartment_id
  network_firewall_policy_id = var.network_firewall_network_firewall_network_firewall_policy_id != "" && !var.enable_network_firewall_network_firewall_policy ? var.network_firewall_network_firewall_network_firewall_policy_id : (var.enable_network_firewall_network_firewall_policy ? element(oci_network_firewall_network_firewall_policy.network_firewall_network_firewall_policy.*.id, 0) : null)
  subnet_id                  = var.network_firewall_network_firewall_subnet_id

  # Optional
  availability_domain        = var.network_firewall_network_firewall_availability_domain
  display_name               = var.network_firewall_network_firewall_display_name != "" ? var.network_firewall_network_firewall_display_name : "${lower(var.name)}-net-firewall-${lower(var.environment)}"
  ipv4address                = var.network_firewall_network_firewall_ipv4address
  ipv6address                = var.network_firewall_network_firewall_ipv6address
  network_security_group_ids = var.network_firewall_network_firewall_network_security_group_ids

  defined_tags = var.network_firewall_network_firewall_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.network_firewall_network_firewall_display_name != "" ? var.network_firewall_network_firewall_display_name : "${lower(var.name)}-net-firewall-${lower(var.environment)}"
    },
    var.tags
  )
  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.network_firewall_network_firewall_timeouts)) > 0 ? [var.network_firewall_network_firewall_timeouts] : []

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