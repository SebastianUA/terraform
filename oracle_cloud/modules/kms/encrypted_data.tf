#-----------------------------------------------------------
# kms encrypted data
#-----------------------------------------------------------
resource "oci_kms_encrypted_data" "kms_encrypted_data" {
  count = var.enable_kms_encrypted_data ? 1 : 0

  # Required
  crypto_endpoint = var.kms_encrypted_data_crypto_endpoint
  key_id          = var.kms_encrypted_data_key_id != "" && !var.enable_kms_key ? var.kms_encrypted_data_key_id : element(oci_kms_key.kms_key.*.id, 0)
  plaintext       = var.kms_encrypted_data_plaintext

  # Optional
  associated_data      = var.kms_encrypted_data_associated_data
  encryption_algorithm = var.kms_encrypted_data_encryption_algorithm
  key_version_id       = var.kms_encrypted_data_key_version_id != "" && !var.enable_kms_key_version ? var.kms_encrypted_data_key_version_id : element(oci_kms_key_version.kms_key_version.*.id, 0)
  logging_context      = var.kms_encrypted_data_logging_context

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.kms_encrypted_data_timeouts)) > 0 ? [var.kms_encrypted_data_timeouts] : []

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