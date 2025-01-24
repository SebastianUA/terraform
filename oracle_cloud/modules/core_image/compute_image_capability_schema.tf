#-----------------------------------------------------------
# core compute image capability schema
#-----------------------------------------------------------
resource "oci_core_compute_image_capability_schema" "core_compute_image_capability_schema" {
  count = var.enable_core_compute_image_capability_schema ? 1 : 0

  # Required
  compartment_id                                      = var.core_compute_image_capability_schema_compartment_id
  compute_global_image_capability_schema_version_name = var.core_compute_image_capability_schema_compute_global_image_capability_schema_version_name
  image_id                                            = var.core_compute_image_capability_schema_image_id != "" && !var.enable_core_image ? var.core_compute_image_capability_schema_image_id : (var.enable_core_image ? element(oci_core_image.core_image.*.id, 0) : null)
  dynamic "schema_data" {
    iterator = schema_data
    for_each = length(keys(var.core_compute_image_capability_schema_schema_data)) > 0 ? [var.core_compute_image_capability_schema_schema_data] : []

    content {
      # Required
      descriptor_type = lookup(schema_data.value, "descriptor_type", null)
      source          = lookup(schema_data.value, "source", null)

      # Optional
      default_value = lookup(schema_data.value, "default_value", null)
      values        = lookup(schema_data.value, "values", null)
    }
  }

  # Optional
  display_name = var.core_compute_image_capability_schema_display_name != "" ? var.core_compute_image_capability_schema_display_name : "${lower(var.name)}-image-capability-schema-${lower(var.environment)}"

  defined_tags = merge(
    {
      "company.Name" = var.core_compute_image_capability_schema_display_name != "" ? var.core_compute_image_capability_schema_display_name : "${lower(var.name)}-image-capability-schema-${lower(var.environment)}"
    },
    var.tags
  )
  freeform_tags = var.core_compute_image_capability_schema_freeform_tags

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_compute_image_capability_schema_timeouts)) > 0 ? [var.core_compute_image_capability_schema_timeouts] : []

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