#---------------------------------------------------
# Create AWS Certificate Manager Private Certificate Authorities (ACM PCA Certificate Authorities)
#---------------------------------------------------
resource "aws_acmpca_certificate_authority" "acmpca_certificate_authority_default" {
    count                           = var.enable_acmpca_certificate_authority_default && !var.enable_acmpca_certificate_authority_revocation_configuration ? 1 : 0

    enabled                         = var.acmpca_certificate_authority_enabled

    certificate_authority_configuration {
        key_algorithm       = "var.certificate_authority_configuration_key_algorithm"
        signing_algorithm   = "var.certificate_authority_configuration_signing_algorithm"

        subject {
            common_name                     = "var.certificate_authority_configuration_subject_common_name"
            country                         = "var.certificate_authority_configuration_subject_country"
            distinguished_name_qualifier    = "var.certificate_authority_configuration_subject_distinguished_name_qualifier"
            generation_qualifier            = "var.certificate_authority_configuration_subject_generation_qualifier"
            given_name                      = "var.certificate_authority_configuration_subject_given_name"
            initials                        = "var.certificate_authority_configuration_subject_initials"
            locality                        = "var.certificate_authority_configuration_subject_locality"
            organization                    = "var.certificate_authority_configuration_subject_organization"
            organizational_unit             = var.certificate_authority_configuration_subject_organizational_unit
            pseudonym                       = "var.certificate_authority_configuration_subject_pseudonym"
            state                           = "var.certificate_authority_configuration_subject_state"
            surname                         = "var.certificate_authority_configuration_subject_surname"
            title                           = "var.certificate_authority_configuration_subject_title"
        }
    }

    permanent_deletion_time_in_days = var.acmpca_certificate_authority_permanent_deletion_time_in_days

    tags = {
        Name            = "lower(var.name)-acmpca-lower(var.environment)"
        Environment     = "var.environment"
        Orchestration   = "var.orchestration"
        Createdby       = "var.createdby"
    }

    timeouts {
        create  = "var.acmpca_certificate_authority_timeouts_create"
    }

    lifecycle {
        create_before_destroy = true
    }

    depends_on = []

}

resource "aws_acmpca_certificate_authority" "acmpca_cert_authority_revocation_configuration" {
    count                           = !var.enable_acmpca_certificate_authority_default && var.enable_acmpca_certificate_authority_revocation_configuration ? 1 : 0

    enabled                         = var.acmpca_certificate_authority_enabled

    certificate_authority_configuration {
        key_algorithm       = "var.certificate_authority_configuration_key_algorithm"
        signing_algorithm   = "var.certificate_authority_configuration_signing_algorithm"

        subject {
            common_name                     = "var.certificate_authority_configuration_subject_common_name"
            country                         = "var.certificate_authority_configuration_subject_country"
            distinguished_name_qualifier    = "var.certificate_authority_configuration_subject_distinguished_name_qualifier"
            generation_qualifier            = "var.certificate_authority_configuration_subject_generation_qualifier"
            given_name                      = "var.certificate_authority_configuration_subject_given_name"
            initials                        = "var.certificate_authority_configuration_subject_initials"
            locality                        = "var.certificate_authority_configuration_subject_locality"
            organization                    = "var.certificate_authority_configuration_subject_organization"
            organizational_unit             = var.certificate_authority_configuration_subject_organizational_unit
            pseudonym                       = "var.certificate_authority_configuration_subject_pseudonym"
            state                           = "var.certificate_authority_configuration_subject_state"
            surname                         = "var.certificate_authority_configuration_subject_surname"
            title                           = "var.certificate_authority_configuration_subject_title"
        }
    }

    revocation_configuration    {
        crl_configuration {
            custom_cname        = "var.revocation_configuration_crl_configuration_custom_cname"
            enabled             = var.revocation_configuration_crl_configuration_enabled
            expiration_in_days  = var.revocation_configuration_crl_configuration_expiration_in_days
            s3_bucket_name      = "var.revocation_configuration_crl_configuration_s3_bucket_name"
        }
    }

    permanent_deletion_time_in_days = var.acmpca_certificate_authority_permanent_deletion_time_in_days

    tags = {
        Name            = var.certificate_authority_configuration_subject_common_name !="" ? var.certificate_authority_configuration_subject_common_name : lower(var.name)-acmpca-lower(var.environment)
        Environment     = "var.environment"
        Orchestration   = "var.orchestration"
        Createdby       = "var.createdby"
    }

    timeouts {
        create  = "var.acmpca_certificate_authority_timeouts_create"
    }

    lifecycle {
        create_before_destroy = true
    }

    depends_on = []

}
