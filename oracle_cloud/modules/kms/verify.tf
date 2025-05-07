#-----------------------------------------------------------
# kms verify
#-----------------------------------------------------------
resource "oci_kms_verify" "kms_verify" {
  count = var.enable_kms_verify ? 1 : 0

  # Required
  crypto_endpoint   = var.kms_verify_crypto_endpoint
  key_id            = var.kms_verify_key_id != "" && !var.enable_kms_key ? var.kms_verify_key_id : element(oci_kms_key.kms_key.*.id, 0)
  key_version_id    = var.kms_verify_key_version_id != "" && !var.enable_kms_key_version ? var.kms_verify_key_version_id : element(oci_kms_key_version.kms_key_version.*.id, 0)
  message           = var.kms_verify_message
  signature         = var.kms_verify_signature
  signing_algorithm = var.kms_verify_signing_algorithm

  # Optional
  message_type = var.kms_verify_message_type

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.kms_verify_timeouts)) > 0 ? [var.kms_verify_timeouts] : []

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