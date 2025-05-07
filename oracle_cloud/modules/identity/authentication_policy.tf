#-----------------------------------------------------------
# identity authentication policy
#-----------------------------------------------------------
resource "oci_identity_authentication_policy" "identity_authentication_policy" {
  count = var.enable_identity_authentication_policy ? 1 : 0

  # Required
  compartment_id = var.compartment_id

  # Optional
  dynamic "network_policy" {
    iterator = network_policy
    for_each = length(keys(var.identity_authentication_policy_network_policy)) > 0 ? [var.identity_authentication_policy_network_policy] : []

    content {
      # Optional
      network_source_ids = lookup(network_policy.value, "network_source_ids", null)
    }
  }
  dynamic "password_policy" {
    iterator = password_policy
    for_each = length(keys(var.identity_authentication_policy_password_policy)) > 0 ? [var.identity_authentication_policy_password_policy] : []

    content {
      # Optional
      is_lowercase_characters_required = lookup(password_policy.value, "is_lowercase_characters_required", null)
      is_numeric_characters_required   = lookup(password_policy.value, "is_numeric_characters_required", null)
      is_special_characters_required   = lookup(password_policy.value, "is_special_characters_required", null)
      is_uppercase_characters_required = lookup(password_policy.value, "is_uppercase_characters_required", null)
      is_username_containment_allowed  = lookup(password_policy.value, "is_username_containment_allowed", null)
      minimum_password_length          = lookup(password_policy.value, "minimum_password_length", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.identity_authentication_policy_timeouts)) > 0 ? [var.identity_authentication_policy_timeouts] : []

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