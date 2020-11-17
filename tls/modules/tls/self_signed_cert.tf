#---------------------------------------------------
# Create tls self signed cert
#---------------------------------------------------
resource "tls_self_signed_cert" "self_signed_cert" {
  count = var.enable_self_signed_cert ? 1 : 0

  key_algorithm         = upper(var.tls_self_signed_cert_key_algorithm)
  private_key_pem       = var.tls_self_signed_cert_private_key_pem
  validity_period_hours = var.tls_self_signed_cert_validity_period_hours
  allowed_uses          = var.tls_self_signed_cert_allowed_uses

  subject {
    common_name         = var.tls_self_signed_cert_subject_common_name
    organization        = var.tls_self_signed_cert_subject_organization
    organizational_unit = var.tls_self_signed_cert_subject_organizational_unit
    street_address      = var.tls_self_signed_cert_subject_street_address
    locality            = var.tls_self_signed_cert_subject_locality
    province            = var.tls_self_signed_cert_subject_province
    country             = var.tls_self_signed_cert_subject_country
    postal_code         = var.tls_self_signed_cert_subject_postal_code
  }

  early_renewal_hours = var.tls_self_signed_cert_early_renewal_hours
  is_ca_certificate   = var.tls_self_signed_cert_is_ca_certificate
  dns_names           = var.tls_self_signed_cert_dns_names
  ip_addresses        = var.tls_self_signed_cert_ip_addresses

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
