#-----------------------------------------------------------
# identity tag namespace
#-----------------------------------------------------------
resource "oci_identity_tag_namespace" "identity_tag_namespace" {
  count = var.enable_identity_tag_namespace ? 1 : 0

  # Required
  compartment_id = var.identity_tag_namespace_compartment_id
  name           = var.identity_tag_namespace_name != "" ? var.identity_tag_namespace_name : "${lower(var.name)}-identity-tag-ns-${lower(var.environment)}"
  description    = var.identity_tag_namespace_description

  # Optional
  is_retired = var.identity_tag_namespace_is_retired

  defined_tags = var.identity_tag_namespace_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.identity_tag_namespace_name != "" ? var.identity_tag_namespace_name : "${lower(var.name)}-identity-tag-ns-${lower(var.environment)}"
    },
    var.tags
  )

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.identity_tag_namespace_timeouts)) > 0 ? [var.identity_tag_namespace_timeouts] : []

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