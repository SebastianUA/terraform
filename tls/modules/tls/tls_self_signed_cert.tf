#---------------------------------------------------
# Create tls self signed cert 
#---------------------------------------------------
resource "tls_self_signed_cert" "self_signed_cert" {
    count                   = "${var.enable_self_signed_cert ? 1 : 0}"
                        
    key_algorithm           = "${var.key_algorithm}"
    #private_key_pem         = "${file("${var.private_key_pem}")}"
    private_key_pem         = "${var.private_key_pem}"
    
    subject {
        common_name  = "${var.subject_common_name}"
        organization = "${var.subject_organization}"
    }

    validity_period_hours   = "${var.validity_period_hours}"
    
    allowed_uses            = "${var.allowed_uses}"
    dns_names               = "${var.dns_names}"
    ip_addresses            = "${var.ip_addresses}"
    
    early_renewal_hours     = "${var.early_renewal_hours}"
    is_ca_certificate       = "${var.is_ca_certificate}"

    depends_on  = []
}
