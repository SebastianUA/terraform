#-----------------------------------------------------------
# identity ui password
#-----------------------------------------------------------
resource "oci_identity_ui_password" "identity_ui_password" {
  count = var.enable_identity_ui_password ? 1 : 0

  # Required
  user_id = var.identity_ui_password_user_id != "" && !var.enable_identity_user ? var.identity_ui_password_user_id : (var.enable_identity_user ? element(oci_identity_user.identity_user.*.id, 0) : null)

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.identity_ui_password_timeouts)) > 0 ? [var.identity_ui_password_timeouts] : []

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
