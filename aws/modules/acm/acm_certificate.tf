#---------------------------------------------------
# Create AWS ACM (Amazon Certificate Manager) certificate
#---------------------------------------------------
resource "aws_acm_certificate" "acm_certificate" {
  count = var.enable_acm_certificate && ! var.import_existing_certificate ? 1 : 0

  domain_name       = var.domain_name != "" ? var.domain_name : "${lower(var.name)}-acm-cert-${lower(var.environment)}"
  validation_method = upper(var.validation_method)

  subject_alternative_names = var.subject_alternative_names

  tags = merge(
    {
      "Name" = var.domain_name != "" ? var.domain_name : "${lower(var.name)}-acm-cert-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}

resource "aws_acm_certificate" "acm_certificate_exist" {
  count = var.enable_acm_certificate && var.import_existing_certificate ? 1 : 0

  private_key       = var.private_key
  certificate_body  = var.certificate_body
  certificate_chain = var.certificate_chain

  tags = merge(
    {
      "Name" = var.domain_name != "" ? var.domain_name : "${lower(var.name)}-acm-cert-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
