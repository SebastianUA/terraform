#-----------------------------------------------------------
# identity network source
#-----------------------------------------------------------
resource "oci_identity_network_source" "identity_network_source" {
  count = var.enable_identity_network_source ? 1 : 0

  # Required
  compartment_id = var.identity_network_source_compartment_id
  description    = var.identity_network_source_description
  name           = var.identity_network_source_name != "" ? var.identity_network_source_name : "${lower(var.name)}-identity-net-source-${lower(var.environment)}"

  # Optional
  public_source_list = var.identity_network_source_public_source_list
  services           = var.identity_network_source_services
  //virtual_source_list = var.identity_network_source_virtual_source_list

  defined_tags = merge(
    {
      Name = var.identity_network_source_name != "" ? var.identity_network_source_name : "${lower(var.name)}-identity-net-source-${lower(var.environment)}"
    },
    var.tags
  )
  freeform_tags = var.identity_network_source_freeform_tags

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.identity_network_source_timeouts)) > 0 ? [var.identity_network_source_timeouts] : []

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