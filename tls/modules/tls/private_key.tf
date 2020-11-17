#---------------------------------------------------
# Create tls private key
#---------------------------------------------------
resource "tls_private_key" "private_key" {
  count = var.enable_tls_private_key ? 1 : 0

  algorithm   = upper(var.tls_private_key_algorithm)
  ecdsa_curve = upper(var.tls_private_key_ecdsa_curve)
  rsa_bits    = var.tls_private_key_rsa_bits

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
