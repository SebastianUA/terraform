#-----------------------------------------------------------
# identity import standard tags management
#-----------------------------------------------------------
resource "oci_identity_import_standard_tags_management" "identity_import_standard_tags_management" {
  count = var.enable_identity_import_standard_tags_management ? 1 : 0

  # Required
  compartment_id              = var.compartment_id
  standard_tag_namespace_name = var.identity_import_standard_tags_management_standard_tag_namespace_name != "" && !var.enable_identity_tag_namespace ? var.identity_import_standard_tags_management_standard_tag_namespace_name : (var.enable_identity_tag_namespace ? element(oci_identity_tag_namespace.identity_tag_namespace.*.name, 0) : null)

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.identity_import_standard_tags_management_timeouts)) > 0 ? [var.identity_import_standard_tags_management_timeouts] : []

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