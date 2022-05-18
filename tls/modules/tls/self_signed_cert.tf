#---------------------------------------------------
# TLS self signed cert
#---------------------------------------------------
resource "tls_self_signed_cert" "self_signed_cert" {
  count = var.enable_self_signed_cert ? 1 : 0

  private_key_pem       = var.tls_self_signed_cert_private_key_pem
  validity_period_hours = var.tls_self_signed_cert_validity_period_hours
  allowed_uses          = var.tls_self_signed_cert_allowed_uses

  early_renewal_hours = var.tls_self_signed_cert_early_renewal_hours
  is_ca_certificate   = var.tls_self_signed_cert_is_ca_certificate
  dns_names           = var.tls_self_signed_cert_dns_names
  ip_addresses        = var.tls_self_signed_cert_ip_addresses

  set_authority_key_id = var.tls_self_signed_cert_set_authority_key_id
  set_subject_key_id   = var.tls_self_signed_cert_set_subject_key_id
  uris                 = var.tls_self_signed_cert_uris

  dynamic "subject" {
    iterator = subject
    for_each = [var.tls_self_signed_cert_subject]

    content {
      common_name         = lookup(subject.value, "common_name", null)
      organization        = lookup(subject.value, "organization", null)
      organizational_unit = lookup(subject.value, "organizational_unit", null)
      street_address      = lookup(subject.value, "street_address", null)
      locality            = lookup(subject.value, "locality", null)
      province            = lookup(subject.value, "province", null)
      country             = lookup(subject.value, "country", null)
      postal_code         = lookup(subject.value, "postal_code", null)
      serial_number       = lookup(subject.value, "serial_number", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
