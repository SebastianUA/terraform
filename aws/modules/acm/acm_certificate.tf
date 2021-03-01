#---------------------------------------------------
# Create AWS ACM (Amazon Certificate Manager) certificate
#---------------------------------------------------
resource "aws_acm_certificate" "acm_certificate" {
  count = var.enable_acm_certificate && !var.enable_acm_certificate_private_ca && !var.enable_import_existing_certificate ? 1 : 0

  domain_name       = var.acm_certificate_domain_name != "" ? var.acm_certificate_domain_name : "${lower(var.name)}-acm-cert-${lower(var.environment)}"
  validation_method = upper(var.acm_certificate_validation_method)

  subject_alternative_names = var.acm_certificate_subject_alternative_names

  dynamic "options" {
    iterator = options
    for_each = var.acm_certificate_options
    content {
      certificate_transparency_logging_preference = lookup(options.value, "certificate_transparency_logging_preference", null)
    }
  }

  tags = merge(
    {
      Name = var.acm_certificate_domain_name != "" ? var.acm_certificate_domain_name : "${lower(var.name)}-acm-cert-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}

resource "aws_acm_certificate" "acm_certificate_private_ca" {
  count = var.enable_acm_certificate_private_ca && !var.enable_acm_certificate && !var.enable_import_existing_certificate ? 1 : 0

  domain_name               = var.acm_certificate_domain_name != "" ? var.acm_certificate_domain_name : "${lower(var.name)}-acm-cert-${lower(var.environment)}"
  certificate_authority_arn = var.acm_certificate_certificate_authority_arn

  subject_alternative_names = var.acm_certificate_subject_alternative_names

  tags = merge(
    {
      Name = var.acm_certificate_domain_name != "" ? var.acm_certificate_domain_name : "${lower(var.name)}-acm-cert-${lower(var.environment)}"
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
  count = var.enable_import_existing_certificate && !var.enable_acm_certificate && !var.enable_acm_certificate_private_ca ? 1 : 0

  private_key       = var.acm_certificate_private_key
  certificate_body  = var.acm_certificate_certificate_body
  certificate_chain = var.acm_certificate_certificate_chain

  tags = merge(
    {
      Name = var.acm_certificate_domain_name != "" ? var.acm_certificate_domain_name : "${lower(var.name)}-acm-cert-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
