#---------------------------------------------------
# Create tls_locally_signed_cert
#---------------------------------------------------
resource "tls_locally_signed_cert" "locally_signed_cert" {
    count                   = var.enable_locally_signed_cert ? 1 : 0
    
    cert_request_pem        = var.cert_request_pem
    ca_key_algorithm        = upper(var.ca_key_algorithm)
    ca_private_key_pem      = var.ca_private_key_pem
    ca_cert_pem             = var.ca_cert_pem

    validity_period_hours   = var.locally_validity_period_hours
    
    allowed_uses            = [var.locally_allowed_uses]
    early_renewal_hours     = var.locally_early_renewal_hours
    is_ca_certificate       = var.locally_is_ca_certificate

    depends_on              = []
}
