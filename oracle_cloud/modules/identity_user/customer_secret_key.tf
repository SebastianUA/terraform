#-----------------------------------------------------------
# identity customer secret key
#-----------------------------------------------------------
resource "oci_identity_customer_secret_key" "identity_customer_secret_key" {
  count = var.enable_identity_customer_secret_key ? 1 : 0

  # Required
  display_name = var.identity_customer_secret_key_display_name != "" ? var.identity_customer_secret_key_display_name : "${lower(var.name)}-identity-customer-secret-key-${lower(var.environment)}"
  user_id      = var.identity_customer_secret_key_user_id != "" && !var.enable_identity_user ? var.identity_customer_secret_key_user_id : (var.enable_identity_user ? element(oci_identity_user.identity_user.*.id, 0) : null)

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.identity_customer_secret_key_timeouts)) > 0 ? [var.identity_customer_secret_key_timeouts] : []

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