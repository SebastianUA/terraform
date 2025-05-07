#-----------------------------------------------------------
# identity compartment
#-----------------------------------------------------------
resource "oci_identity_compartment" "identity_compartment" {
  count = var.enable_identity_compartment ? 1 : 0

  # Required
  compartment_id = var.compartment_id
  description    = var.identity_compartment_description
  name           = var.identity_compartment_name != "" ? var.identity_compartment_name : "${lower(var.name)}-identity-compartment-${lower(var.environment)}"

  # Optional
  enable_delete = var.identity_compartment_enable_delete

  defined_tags = var.identity_compartment_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.identity_compartment_name != "" ? var.identity_compartment_name : "${lower(var.name)}-identity-compartment-${lower(var.environment)}"
    },
    var.tags
  )

  #   dynamic "timeouts" {
  #     iterator = timeouts
  #     for_each = length(keys(var.identity_compartment_timeouts)) > 0 ? [var.identity_compartment_timeouts] : []

  #     content {
  #       create = lookup(timeouts.value, "create", null)
  #       update = lookup(timeouts.value, "update", null)
  #       delete = lookup(timeouts.value, "delete", null)
  #     }
  #   }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}