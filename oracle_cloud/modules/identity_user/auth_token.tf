#-----------------------------------------------------------
# identity auth token
#-----------------------------------------------------------
resource "oci_identity_auth_token" "identity_auth_token" {
  count = var.enable_identity_auth_token ? 1 : 0

  # Required
  description = var.identity_auth_token_description
  user_id     = var.identity_auth_token_user_id != "" && !var.enable_identity_user ? var.identity_auth_token_user_id : (var.enable_identity_user ? element(oci_identity_user.identity_user.*.id, 0) : null)

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.identity_auth_token_timeouts)) > 0 ? [var.identity_auth_token_timeouts] : []

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