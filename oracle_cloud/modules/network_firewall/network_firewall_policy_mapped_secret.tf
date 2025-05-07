#-----------------------------------------------------------
# network firewall policy mapped secret
#-----------------------------------------------------------
resource "oci_network_firewall_network_firewall_policy_mapped_secret" "network_firewall_network_firewall_policy_mapped_secret" {
  count = var.enable_network_firewall_network_firewall_policy_mapped_secret ? 1 : 0

  # Required
  name                       = var.network_firewall_network_firewall_policy_mapped_secret_name != "" ? var.network_firewall_network_firewall_policy_mapped_secret_name : "${lower(var.name)}-net-firewall-mapped-secret-${lower(var.environment)}"
  network_firewall_policy_id = var.network_firewall_network_firewall_policy_mapped_secret_network_firewall_policy_id != "" && !var.enable_network_firewall_network_firewall_policy ? var.network_firewall_network_firewall_policy_mapped_secret_network_firewall_policy_id : (var.enable_network_firewall_network_firewall_policy ? element(oci_network_firewall_network_firewall_policy.network_firewall_network_firewall_policy.*.id, 0) : null)
  source                     = var.network_firewall_network_firewall_policy_mapped_secret_source
  type                       = var.network_firewall_network_firewall_policy_mapped_secret_type
  vault_secret_id            = var.network_firewall_network_firewall_policy_mapped_secret_vault_secret_id
  version_number             = var.network_firewall_network_firewall_policy_mapped_secret_version_number

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.network_firewall_network_firewall_policy_mapped_secret_timeouts)) > 0 ? [var.network_firewall_network_firewall_policy_mapped_secret_timeouts] : []

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