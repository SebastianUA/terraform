#-----------------------------------------------------------
# ProofPoint Meta certificate
#-----------------------------------------------------------
resource "pfptmeta_certificate" "certificate" {
  count = var.enable_certificate ? 1 : 0

  name = var.certificate_name != "" ? var.certificate_name : "${lower(var.name)}-certificate-${lower(var.environment)}"
  sans = var.certificate_sans

  description = var.certificate_description
}