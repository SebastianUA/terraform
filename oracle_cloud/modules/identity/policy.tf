#-----------------------------------------------------------
# identity policy
#-----------------------------------------------------------
resource "oci_identity_policy" "identity_policy" {
  count = var.enable_identity_policy ? 1 : 0

  # Required
  compartment_id = var.compartment_id
  description    = var.identity_policy_description
  name           = var.identity_policy_name != "" ? var.identity_policy_name : "${lower(var.name)}-identity-policy-${lower(var.environment)}"
  statements     = var.identity_policy_statements

  # Optional
  version_date = var.identity_policy_version_date

  defined_tags = var.identity_policy_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.identity_policy_name != "" ? var.identity_policy_name : "${lower(var.name)}-identity-policy-${lower(var.environment)}"
    },
    var.tags
  )

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.identity_policy_timeouts)) > 0 ? [var.identity_policy_timeouts] : []

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