#-----------------------------------------------------------
# identity tag default
#-----------------------------------------------------------
resource "oci_identity_tag_default" "identity_tag_default" {
  count = var.enable_identity_tag_default ? 1 : 0

  # Required
  compartment_id    = var.identity_tag_default_compartment_id
  tag_definition_id = var.identity_tag_default_tag_definition_id
  value             = var.identity_tag_default_value

  # Optional
  is_required = var.identity_tag_default_is_required

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.identity_tag_default_timeouts)) > 0 ? [var.identity_tag_default_timeouts] : []

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