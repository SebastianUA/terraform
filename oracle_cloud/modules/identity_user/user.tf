#-----------------------------------------------------------
# identity user
#-----------------------------------------------------------
resource "oci_identity_user" "identity_user" {
  count = var.enable_identity_user ? 1 : 0

  # Required
  compartment_id = var.compartment_id
  description    = var.identity_user_description
  name           = var.identity_user_name != "" ? var.identity_user_name : "${lower(var.name)}-identity-user-${lower(var.environment)}"

  # Optional
  email = var.identity_user_email

  defined_tags = var.identity_user_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.identity_user_name != "" ? var.identity_user_name : "${lower(var.name)}-identity-user-${lower(var.environment)}"
    },
    var.tags
  )

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.identity_user_timeouts)) > 0 ? [var.identity_user_timeouts] : []

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