#-----------------------------------------------------------
# network firewall policy decryption profile
#-----------------------------------------------------------
resource "oci_network_firewall_network_firewall_policy_decryption_profile" "network_firewall_network_firewall_policy_decryption_profile" {
  count = var.enable_network_firewall_network_firewall_policy_decryption_profile ? 1 : 0

  # Required
  name                       = var.network_firewall_network_firewall_policy_decryption_profile_name != "" ? var.network_firewall_network_firewall_policy_decryption_profile_name : "${lower(var.name)}-net-firewall-policy-decr-profile-${lower(var.environment)}"
  network_firewall_policy_id = var.network_firewall_network_firewall_policy_decryption_profile_network_firewall_policy_id != "" && !var.enable_network_firewall_network_firewall_policy ? var.network_firewall_network_firewall_policy_decryption_profile_network_firewall_policy_id : (var.enable_network_firewall_network_firewall_policy ? element(oci_network_firewall_network_firewall_policy.network_firewall_network_firewall_policy.*.id, 0) : null)
  type                       = var.network_firewall_network_firewall_policy_decryption_profile_type

  # Optional
  are_certificate_extensions_restricted = var.network_firewall_network_firewall_policy_decryption_profile_are_certificate_extensions_restricted
  is_auto_include_alt_name              = var.network_firewall_network_firewall_policy_decryption_profile_is_auto_include_alt_name
  is_expired_certificate_blocked        = var.network_firewall_network_firewall_policy_decryption_profile_is_expired_certificate_blocked
  is_out_of_capacity_blocked            = var.network_firewall_network_firewall_policy_decryption_profile_is_out_of_capacity_blocked
  is_revocation_status_timeout_blocked  = var.network_firewall_network_firewall_policy_decryption_profile_is_revocation_status_timeout_blocked
  is_unknown_revocation_status_blocked  = var.network_firewall_network_firewall_policy_decryption_profile_is_unknown_revocation_status_blocked
  is_unsupported_cipher_blocked         = var.network_firewall_network_firewall_policy_decryption_profile_is_unsupported_cipher_blocked
  is_unsupported_version_blocked        = var.network_firewall_network_firewall_policy_decryption_profile_is_unsupported_version_blocked
  is_untrusted_issuer_blocked           = var.network_firewall_network_firewall_policy_decryption_profile_is_untrusted_issuer_blocked

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.network_firewall_network_firewall_policy_decryption_profile_timeouts)) > 0 ? [var.network_firewall_network_firewall_policy_decryption_profile_timeouts] : []

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