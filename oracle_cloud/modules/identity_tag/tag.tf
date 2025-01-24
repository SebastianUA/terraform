#-----------------------------------------------------------
# identity tag
#-----------------------------------------------------------
resource "oci_identity_tag" "identity_tag" {
  count = var.enable_identity_tag ? 1 : 0

  # Required
  name             = var.identity_tag_name != "" ? var.identity_tag_name : "${lower(var.name)}-identity-tag-${lower(var.environment)}"
  description      = var.identity_tag_description
  tag_namespace_id = var.identity_tag_tag_namespace_id != "" && !var.enable_identity_tag_namespace ? var.identity_tag_tag_namespace_id : (var.enable_identity_tag_namespace ? element(oci_identity_tag_namespace.identity_tag_namespace.*.id, 0) : null)

  # Optional
  is_cost_tracking = var.identity_tag_is_cost_tracking
  is_retired       = var.identity_tag_is_retired

  dynamic "validator" {
    iterator = validator
    for_each = var.identity_tag_validator

    content {
      # Required
      validator_type = lookup(validator.value, "validator_type", null)
      values         = lookup(validator.value, "values", null)
    }
  }

  defined_tags = var.identity_tag_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.identity_tag_name != "" ? var.identity_tag_name : "${lower(var.name)}-identity-tag-${lower(var.environment)}"
    },
    var.tags
  )

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.identity_tag_timeouts)) > 0 ? [var.identity_tag_timeouts] : []

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