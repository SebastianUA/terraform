#-----------------------------------------------------------
# core image
#-----------------------------------------------------------
resource "oci_core_image" "core_image" {
  count = var.enable_core_image ? 1 : 0

  # Required
  compartment_id = var.core_image_compartment_id

  # Optional
  display_name = var.core_image_display_name != "" ? var.core_image_display_name : "${lower(var.name)}-image-${lower(var.environment)}"
  launch_mode  = var.core_image_launch_mode
  instance_id  = var.core_image_instance_id

  dynamic "image_source_details" {
    iterator = image_source_details
    for_each = var.core_image_image_source_details

    content {
      bucket_name    = lookup(image_source_details.value, "bucket_name", null)
      namespace_name = lookup(image_source_details.value, "namespace_name", null)
      object_name    = lookup(image_source_details.value, "object_name", null)
      source_type    = lookup(image_source_details.value, "source_type", null)

      # Optional
      operating_system         = lookup(image_source_details.value, "operating_system", null)
      operating_system_version = lookup(image_source_details.value, "operating_system_version", null)
      source_image_type        = lookup(image_source_details.value, "source_image_type", null)
    }
  }

  defined_tags = var.core_image_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.core_image_display_name != "" ? var.core_image_display_name : "${lower(var.name)}-image-${lower(var.environment)}"
    },
    var.tags
  )

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_image_timeouts)) > 0 ? [var.core_image_timeouts] : []

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