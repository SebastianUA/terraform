#-----------------------------------------------------------
# kms ekms private endpoint
#-----------------------------------------------------------
resource "oci_kms_ekms_private_endpoint" "kms_ekms_private_endpoint" {
  count = var.enable_kms_ekms_private_endpoint ? 1 : 0

  # Required
  ca_bundle               = var.kms_ekms_private_endpoint_ca_bundle
  compartment_id          = var.compartment_id
  display_name            = var.kms_ekms_private_endpoint_display_name != "" ? var.kms_ekms_private_endpoint_display_name : "${lower(var.name)}-kms-ekms-prvt-end-${lower(var.environment)}"
  external_key_manager_ip = var.kms_ekms_private_endpoint_external_key_manager_ip
  subnet_id               = var.kms_ekms_private_endpoint_subnet_id

  # Optional
  port = var.kms_ekms_private_endpoint_port

  defined_tags = var.kms_ekms_private_endpoint_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.kms_ekms_private_endpoint_display_name != "" ? var.kms_ekms_private_endpoint_display_name : "${lower(var.name)}-kms-ekms-prvt-end-${lower(var.environment)}"
    },
    var.tags
  )

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.kms_ekms_private_endpoint_timeouts)) > 0 ? [var.kms_ekms_private_endpoint_timeouts] : []

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