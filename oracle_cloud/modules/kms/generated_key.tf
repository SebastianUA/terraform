#-----------------------------------------------------------
# kms generated key
#-----------------------------------------------------------
resource "oci_kms_generated_key" "kms_generated_key" {
  count = var.enable_kms_generated_key ? 1 : 0

  # Required
  crypto_endpoint       = var.kms_generated_key_crypto_endpoint
  include_plaintext_key = var.kms_generated_key_include_plaintext_key
  key_id                = var.kms_generated_key_key_id != "" && !var.enable_kms_key ? var.kms_generated_key_key_id : element(oci_kms_key.kms_key.*.id, 0)

  dynamic "key_shape" {
    iterator = key_shape
    for_each = length(keys(var.kms_generated_key_key_shape)) > 0 ? [var.kms_generated_key_key_shape] : []

    content {
      # Required
      algorithm = lookup(key_shape.value, "algorithm", null)
      length    = lookup(key_shape.value, "length", null)

      # Optional
      curve_id = lookup(key_shape.value, "curve_id", null)
    }
  }

  # Optional
  associated_data = var.kms_generated_key_associated_data
  logging_context = var.kms_generated_key_logging_context

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.kms_generated_key_timeouts)) > 0 ? [var.kms_generated_key_timeouts] : []

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