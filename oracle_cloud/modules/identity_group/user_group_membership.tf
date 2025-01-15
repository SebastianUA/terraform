#-----------------------------------------------------------
# identity user group membership
#-----------------------------------------------------------
resource "oci_identity_user_group_membership" "identity_user_group_membership" {
  count = var.enable_identity_user_group_membership ? 1 : 0

  # Required
  group_id = var.identity_user_group_membership_group_id != "" && !var.enable_identity_group ? var.identity_user_group_membership_group_id : (var.enable_identity_group ? element(oci_identity_group.identity_group.*.id, 0) : null)
  user_id  = var.identity_user_group_membership_user_id

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.identity_user_group_membership_timeouts)) > 0 ? [var.identity_user_group_membership_timeouts] : []

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