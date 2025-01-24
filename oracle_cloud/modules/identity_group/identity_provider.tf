#-----------------------------------------------------------
# identity identity provider
#-----------------------------------------------------------
resource "oci_identity_identity_provider" "identity_identity_provider" {
  count = var.enable_identity_identity_provider ? 1 : 0

  # Required
  compartment_id = var.identity_identity_provider_compartment_id
  description    = var.identity_identity_provider_description
  metadata       = var.identity_identity_provider_metadata
  metadata_url   = var.identity_identity_provider_metadata_url
  name           = var.identity_identity_provider_name != "" ? var.identity_identity_provider_name : "${lower(var.name)}-identity-provider-${lower(var.environment)}"
  product_type   = var.identity_identity_provider_product_type
  protocol       = var.identity_identity_provider_protocol

  # Optional
  freeform_attributes = var.identity_identity_provider_freeform_attributes

  defined_tags = merge(
    {
      "company.Name" = var.identity_identity_provider_name != "" ? var.identity_identity_provider_name : "${lower(var.name)}-identity-provider-${lower(var.environment)}"
    },
    var.tags
  )
  freeform_tags = var.identity_identity_provider_freeform_tags

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.identity_identity_provider_timeouts)) > 0 ? [var.identity_identity_provider_timeouts] : []

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