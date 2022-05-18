#---------------------------------------------------
# TLS cert request
#---------------------------------------------------
resource "tls_cert_request" "cert_request" {
  count = var.enable_tls_cert_request ? 1 : 0

  private_key_pem = var.tls_cert_request_private_key_pem

  dns_names    = var.tls_cert_request_dns_names
  ip_addresses = var.tls_cert_request_ip_addresses
  uris         = var.tls_cert_request_uris

  dynamic "subject" {
    iterator = subject
    for_each = [var.tls_cert_request_subject]

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
