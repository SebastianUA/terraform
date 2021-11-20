#---------------------------------------------------
# AWS Certificate Manager Private Certificate Authorities (ACM PCA Certificate Authorities)
#---------------------------------------------------
resource "aws_acmpca_certificate_authority" "acmpca_certificate_authority" {
  count = var.enable_acmpca_certificate_authority ? 1 : 0

  enabled = var.acmpca_certificate_authority_enabled

  permanent_deletion_time_in_days = var.acmpca_certificate_authority_permanent_deletion_time_in_days

  dynamic "certificate_authority_configuration" {
    iterator = certificate_authority_configuration
    for_each = length(keys(var.acmpca_certificate_authority_certificate_authority_configuration)) > 0 ? [var.acmpca_certificate_authority_certificate_authority_configuration] : []

    content {
      key_algorithm     = lookup(certificate_authority_configuration.value, "key_algorithm", null)
      signing_algorithm = lookup(certificate_authority_configuration.value, "signing_algorithm", null)

      dynamic "subject" {
        iterator = subject
        for_each = length(keys(lookup(certificate_authority_configuration.value, "subject", {}))) > 0 ? [lookup(certificate_authority_configuration.value, "subject", {})] : []

        content {
          common_name                  = lookup(subject.value, "common_name", null)
          country                      = lookup(subject.value, "country", null)
          distinguished_name_qualifier = lookup(subject.value, "distinguished_name_qualifier", null)
          generation_qualifier         = lookup(subject.value, "generation_qualifier", null)
          given_name                   = lookup(subject.value, "given_name", null)
          initials                     = lookup(subject.value, "initials", null)
          locality                     = lookup(subject.value, "locality", null)
          organization                 = lookup(subject.value, "organization", null)
          organizational_unit          = lookup(subject.value, "organizational_unit", null)
          pseudonym                    = lookup(subject.value, "pseudonym", null)
          state                        = lookup(subject.value, "state", null)
          surname                      = lookup(subject.value, "surname", null)
          title                        = lookup(subject.value, "title", null)
        }
      }
    }
  }

  dynamic "revocation_configuration" {
    iterator = revocation_configuration
    for_each = length(keys(var.acmpca_certificate_authority_revocation_configuration)) > 0 ? [var.acmpca_certificate_authority_revocation_configuration] : []

    content {
      dynamic "crl_configuration" {
        iterator = crl_configuration
        for_each = length(keys(lookup(revocation_configuration.value, "crl_configuration", {}))) > 0 ? [lookup(revocation_configuration.value, "crl_configuration", {})] : []

        content {
          expiration_in_days = lookup(crl_configuration.value, "expiration_in_days", null)

          custom_cname   = lookup(crl_configuration.value, "custom_cname", null)
          enabled        = lookup(crl_configuration.value, "enabled", null)
          s3_bucket_name = lookup(crl_configuration.value, "s3_bucket_name", null)
        }
      }
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.acmpca_certificate_authority_timeouts)) > 0 ? [var.acmpca_certificate_authority_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
    }
  }

  tags = merge(
    {
      Name = var.acmpca_certificate_authority_name != "" ? var.acmpca_certificate_authority_name : "${lower(var.name)}-acmpca-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
