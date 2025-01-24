#-----------------------------------------------------------
# kms key
#-----------------------------------------------------------
resource "oci_kms_key" "kms_key" {
  count = var.enable_kms_key ? 1 : 0

  # Required
  display_name   = var.kms_key_display_name != "" ? var.kms_key_display_name : "${lower(var.name)}-kms-key-${lower(var.environment)}"
  compartment_id = var.kms_key_compartment_id

  dynamic "key_shape" {
    iterator = "key_shape"
    for_each = length(keys(var.kms_key_key_shape)) > 0 ? [var.kms_key_key_shape] : []

    content {
      # Required
      algorithm = lookup(key_shape.value, "algorithm", null)
      length    = lookup(key_shape.value, "length", null)

      # Optional
      curve_id = lookup(key_shape.value, "curve_id", null)
    }
  }

  management_endpoint      = var.kms_key_management_endpoint
  is_auto_rotation_enabled = var.kms_key_is_auto_rotation_enabled
  protection_mode          = var.kms_key_protection_mode


  # Optional
  dynamic "auto_key_rotation_details" {
    iterator = "auto_key_rotation_details"
    for_each = length(keys(var.kms_key_auto_key_rotation_details)) > 0 ? [var.kms_key_auto_key_rotation_details] : []

    content {
      # Optional
      last_rotation_message     = lookup(auto_key_rotation_details.value, "last_rotation_message", null)
      last_rotation_status      = lookup(auto_key_rotation_details.value, "last_rotation_status", null)
      rotation_interval_in_days = lookup(auto_key_rotation_details.value, "rotation_interval_in_days", null)
      time_of_last_rotation     = lookup(auto_key_rotation_details.value, "time_of_last_rotation", null)
      time_of_next_rotation     = lookup(auto_key_rotation_details.value, "time_of_next_rotation", null)
      time_of_schedule_start    = lookup(auto_key_rotation_details.value, "time_of_schedule_start", null)
    }
  }
  dynamic "external_key_reference" {
    iterator = "external_key_reference"
    for_each = length(keys(var.kms_key_external_key_reference)) > 0 ? [var.kms_key_external_key_reference] : []

    content {
      # Required
      external_key_id = lookup(external_key_reference.value, "external_key_id", null)
    }
  }

  defined_tags = var.kms_key_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.kms_key_display_name != "" ? var.kms_key_display_name : "${lower(var.name)}-kms-key-${lower(var.environment)}"
    },
    var.tags
  )

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.kms_key_timeouts)) > 0 ? [var.kms_key_timeouts] : []

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