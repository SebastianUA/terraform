#---------------------------------------------------
# AWS dms certificate
#---------------------------------------------------
resource "aws_dms_certificate" "dms_certificate" {
  count = var.enable_dms_certificate ? 1 : 0

  certificate_id = var.dms_certificate_certificate_id

  certificate_pem    = var.dms_certificate_certificate_pem
  certificate_wallet = var.dms_certificate_certificate_wallet

  tags = merge(
    {
      Name = var.dms_certificate_name != "" ? lower(var.dms_certificate_name) : "${lower(var.name)}-dms-certificate-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}