#-----------------------------------------------------------
# identity dynamic group
#-----------------------------------------------------------
resource "oci_identity_dynamic_group" "identity_dynamic_group" {
  count = var.enable_identity_dynamic_group ? 1 : 0

  # Required
  compartment_id = var.identity_dynamic_group_compartment_id
  description    = var.identity_dynamic_group_description
  matching_rule  = var.identity_dynamic_group_matching_rule
  name           = var.identity_dynamic_group_name != "" ? var.identity_dynamic_group_name : "${lower(var.name)}-identity-dynamic-group-${lower(var.environment)}"

  # Optional
  defined_tags = var.identity_dynamic_group_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.identity_dynamic_group_name != "" ? var.identity_dynamic_group_name : "${lower(var.name)}-identity-dynamic-group-${lower(var.environment)}"
    },
    var.tags
  )

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.identity_dynamic_group_timeouts)) > 0 ? [var.identity_dynamic_group_timeouts] : []

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