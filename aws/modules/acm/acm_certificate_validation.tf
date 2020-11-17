#---------------------------------------------------
# AWS ACM (Amazon Certificate Manager) certificate validation
#---------------------------------------------------
resource "aws_acm_certificate_validation" "acm_certificate_validation" {
  count = var.enable_acm_certificate ? 1 : 0

  certificate_arn = var.certificate_arn

  timeouts {
    create = var.timeouts_create
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}

resource "aws_acm_certificate_validation" "acm_certificate_validation_with_validation_record_fqdns" {
  count = var.enable_acm_certificate ? 1 : 0

  certificate_arn         = var.certificate_arn
  validation_record_fqdns = var.validation_record_fqdns

  timeouts {
    create = var.timeouts_create
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
