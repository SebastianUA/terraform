#---------------------------------------------------
#  TLS locally signed cert
#---------------------------------------------------
resource "tls_locally_signed_cert" "locally_signed_cert" {
  count = var.enable_locally_signed_cert ? 1 : 0

  cert_request_pem      = var.locally_signed_cert_cert_request_pem
  ca_private_key_pem    = var.locally_signed_cert_ca_private_key_pem
  ca_cert_pem           = var.locally_signed_cert_ca_cert_pem
  allowed_uses          = var.locally_signed_cert_locally_allowed_uses
  validity_period_hours = var.locally_signed_cert_locally_validity_period_hours


  early_renewal_hours = var.locally_signed_cert_early_renewal_hours
  is_ca_certificate   = var.locally_signed_cert_is_ca_certificate
  set_subject_key_id  = var.locally_signed_cert_set_subject_key_id

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
