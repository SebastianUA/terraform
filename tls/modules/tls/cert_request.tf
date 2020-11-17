#---------------------------------------------------
# Create tls cert request
#---------------------------------------------------
resource "tls_cert_request" "cert_request" {
  count = var.enable_tls_cert_request ? 1 : 0

  key_algorithm   = upper(var.tls_cert_request_key_algorithm)
  private_key_pem = var.tls_cert_request_private_key_pem

  subject {
    common_name         = var.tls_cert_request_subject_common_name
    organization        = var.tls_cert_request_subject_organization
    organizational_unit = var.tls_cert_request_subject_organizational_unit
    street_address      = var.tls_cert_request_subject_street_address
    locality            = var.tls_cert_request_subject_locality
    province            = var.tls_cert_request_subject_province
    country             = var.tls_cert_request_subject_country
    postal_code         = var.tls_cert_request_subject_postal_code
    serial_number       = var.tls_cert_request_subject_postal_serial_number
  }

  dns_names    = var.tls_cert_request_dns_names
  ip_addresses = var.tls_cert_request_ip_addresses

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
