#-----------------------------------------------------------
# identity idp group mapping
#-----------------------------------------------------------
resource "oci_identity_idp_group_mapping" "identity_idp_group_mapping" {
  count = var.enable_identity_idp_group_mapping ? 1 : 0

  # Required
  group_id             = var.identity_idp_group_mapping_group_id != "" && !var.enable_identity_group ? var.identity_idp_group_mapping_group_id : (var.enable_identity_group ? element(oci_identity_group.identity_group.*.id, 0) : null)
  identity_provider_id = var.identity_idp_group_mapping_identity_provider_id
  idp_group_name       = var.identity_idp_group_mapping_idp_group_name

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.identity_idp_group_mapping_timeouts)) > 0 ? [var.identity_idp_group_mapping_timeouts] : []

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