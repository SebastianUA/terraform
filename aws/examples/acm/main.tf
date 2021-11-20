#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region                  = "us-east-1"
  profile                 = "default"
  shared_credentials_file = pathexpand("/Users/captain/.aws/credentials")
}

module "acm_certificate" {
  source = "../../modules/acm"

  enable_acm_certificate = true

  acm_certificate_domain_name               = "linux-notes.org"
  acm_certificate_subject_alternative_names = ["www.linux-notes.org", "linux-notes.org"]
  acm_certificate_validation_method         = "EMAIL"

  tags = tomap({
    "Environment" = "dev",
    "Createdby"   = "Vitaliy Natarov"
  })

}

module "acm_certificate_validation" {
  source = "../../modules/acm"

  enable_acm_certificate                     = true
  acm_certificate_validation_certificate_arn = module.acm_certificate.aws_acm_certificate_arn
  acm_certificate_validation_record_fqdns    = ["linux-notes.org"]

  tags = tomap({
    "Environment" = "dev",
    "Createdby"   = "Vitaliy Natarov"
  })

  depends_on = [
    module.acm_certificate
  ]
}

module "acm_import_existing_certificate" {
  source = "../../modules/acm"

  enable_import_existing_certificate = false
  acm_certificate_private_key        = ""
  acm_certificate_certificate_body   = ""
  acm_certificate_certificate_chain  = ""

  tags = tomap({
    "Environment" = "dev",
    "Createdby"   = "Vitaliy Natarov"
  })
}

module "acmpca_certificate_authority" {
  source = "../../modules/acm"

  enable_acmpca_certificate_authority                          = true
  acmpca_certificate_authority_permanent_deletion_time_in_days = 30

  acmpca_certificate_authority_certificate_authority_configuration = {
    key_algorithm     = "RSA_4096"
    signing_algorithm = "SHA512WITHRSA"

    subject = {
      common_name         = "test"
      country             = "UA"
      organization        = "test"
      organizational_unit = "tmp"
    }
  }

  acmpca_certificate_authority_revocation_configuration = {
    crl_configuration = {
      custom_cname       = "custom_cname"
      expiration_in_days = 666
    }
  }

  tags = tomap({
    "Environment" = "dev",
    "Createdby"   = "Vitaliy Natarov"
  })
}

module "acm_certificate_private_ca" {
  source = "../../modules/acm"

  enable_acm_certificate_private_ca         = true
  acm_certificate_domain_name               = "linux-notes.org"
  acm_certificate_certificate_authority_arn = module.acmpca_certificate_authority.acmpca_certificate_authority_arn
  acm_certificate_subject_alternative_names = ["www.linux-notes.org", "linux-notes.org"]

  tags = tomap({
    "Environment" = "dev",
    "Createdby"   = "Vitaliy Natarov"
  })

  depends_on = [
    module.acmpca_certificate_authority
  ]
}