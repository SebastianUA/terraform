#-----------------------------------------------------------
# kms sign
#-----------------------------------------------------------
resource "oci_kms_sign" "kms_sign" {
  count = var.enable_kms_sign ? 1 : 0

  # Required
  crypto_endpoint   = var.kms_sign_crypto_endpoint
  key_id            = var.kms_sign_key_id != "" && !var.enable_kms_key ? var.kms_sign_key_id : element(oci_kms_key.kms_key.*.id, 0)
  message           = var.kms_sign_message
  signing_algorithm = var.kms_sign_signing_algorithm

  # Optional
  key_version_id = var.kms_sign_key_version_id != "" && !var.enable_kms_key_version ? var.kms_sign_key_version_id : element(oci_kms_key_version.kms_key_version.*.id, 0)
  //logging_context = var.kms_sign_logging_context
  message_type = var.kms_sign_message_type

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.kms_sign_timeouts)) > 0 ? [var.kms_sign_timeouts] : []

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