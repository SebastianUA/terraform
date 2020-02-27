#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
    required_version = "~>0.12.12"
}

provider "aws" {
    region                  = "us-east-1"
    profile                 = "default"
    shared_credentials_file = pathexpand("/Users/captain/.aws/credentials")
}

module "acm_certificate" {
    source                      = "../../modules/acm"

    enable_acm_certificate      = true

    domain_name                 = "linux-notes.org"
    subject_alternative_names   = ["www.linux-notes.org", "linux-notes.org"]
    validation_method           = "EMAIL"

    import_existing_certificate = false
    #private_key                 = ""
    #certificate_body            = ""
    #certificate_chain           = ""
}

module "acm_certificate_validation" {
    source                              = "../../modules/acm"

    enable_acm_certificate              = true
    certificate_arn                     = "${module.acm_certificate.aws_acm_certificate_arn}"
    validation_record_fqdns             = "linux-notes.org"
}
