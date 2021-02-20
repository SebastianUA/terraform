#---------------------------------------------------
# KSM ciphertext
#---------------------------------------------------
resource "aws_kms_ciphertext" "kms_ciphertext" {
  count = var.enable_kms_ciphertext ? 1 : 0

  key_id    = var.kms_ciphertext_key_id != "" ? var.kms_ciphertext_key_id : (var.enable_kms_key ? element(aws_kms_key.kms_key.*.key_id, 0) : null)
  plaintext = var.kms_ciphertext_plaintext

  context = var.kms_ciphertext_context

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
