#-----------------------------------------------------------
# identity api key
#-----------------------------------------------------------
resource "oci_identity_api_key" "identity_api_key" {
  count = var.enable_identity_api_key ? 1 : 0

  # Required
  key_value = var.identity_api_key_key_value
  user_id   = var.identity_api_key_user_id != "" && !var.enable_identity_user ? var.identity_api_key_user_id : (var.enable_identity_user ? element(oci_identity_user.identity_user.*.id, 0) : null)

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.identity_api_key_timeouts)) > 0 ? [var.identity_api_key_timeouts] : []

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