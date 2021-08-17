#---------------------------------------------------
# AWS ACM (Amazon Certificate Manager) certificate validation
#---------------------------------------------------
resource "aws_acm_certificate_validation" "acm_certificate_validation" {
  count = var.enable_acm_certificate_validation ? 1 : 0

  certificate_arn = var.acm_certificate_validation_certificate_arn

  validation_record_fqdns = var.acm_certificate_validation_record_fqdns

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.acm_certificate_validation_timeouts)) > 0 ? [var.acm_certificate_validation_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
