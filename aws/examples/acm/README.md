# Work with ACM via terraform

A terraform module for making ACM.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
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
```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - Add additional tags (`default = {}`)
- `enable_acm_certificate` - Enable acm certificate usage (`default = False`)
- `acm_certificate_domain_name` - (Required) A domain name for which the certificate should be issued (`default = ""`)
- `acm_certificate_validation_method` - (Required) Which method to use for validation. DNS or EMAIL are valid, NONE can be used for certificates that were imported into ACM and then into Terraform. (`default = DNS`)
- `acm_certificate_subject_alternative_names` - (Optional) A list of domains that should be SANs in the issued certificate (`default = []`)
- `acm_certificate_options` - (Optional) Configuration block used to set certificate options. (`default = []`)
- `enable_import_existing_certificate` - Enable import existing certificate usage (`default = False`)
- `acm_certificate_private_key` - (Required) The certificate's PEM-formatted private key (`default = ""`)
- `acm_certificate_certificate_body` - (Required) The certificate's PEM-formatted public key (`default = ""`)
- `acm_certificate_certificate_chain` - (Optional) The certificate's PEM-formatted chain (`default = null`)
- `enable_acm_certificate_private_ca` - Enable acm certificate private CA usage (`default = False`)
- `acm_certificate_certificate_authority_arn` - ARN of an ACMPCA (`default = null`)
- `enable_acm_certificate_validation` - Enable to use acm certificate validation (`default = False`)
- `acm_certificate_validation_certificate_arn` - (Required) The ARN of the certificate that is being validated. (`default = ""`)
- `acm_certificate_validation_record_fqdns` - (Optional) List of FQDNs that implement the validation. Only valid for DNS validation method ACM certificates. If this is set, the resource can implement additional sanity checks and has an explicit dependency on the resource that is implementing the validation (`default = null`)
- `acm_certificate_validation_timeouts` - Set timeouts for acm certificate validation (`default = {}`)
- `enable_acmpca_certificate_authority` - Enable to use acmpca certificate authority (`default = False`)
- `acmpca_certificate_authority_name` - Set cert name for acmpca (`default = ""`)
- `acmpca_certificate_authority_enabled` - (Optional) Whether the certificate authority is enabled or disabled. Defaults to true. (`default = True`)
- `acmpca_certificate_authority_certificate_authority_configuration` - (Required) Nested argument containing algorithms and certificate subject information. (`default = {}`)
- `acmpca_certificate_authority_permanent_deletion_time_in_days` - (Optional) The number of days to make a CA restorable after it has been deleted, must be between 7 to 30 days, with default to 30 days. (`default = null`)
- `acmpca_certificate_authority_revocation_configuration` - (Optional) Nested argument containing revocation configuration. (`default = {}`)
- `acmpca_certificate_authority_timeouts` - Set timeouts for acmpca (`default = {}`)

## Module Output Variables
----------------------
- `aws_acm_certificate_id` - The ARN of the certificate
- `aws_acm_certificate_arn` - The ARN of the certificate
- `aws_acm_certificate_domain_name` - The domain name for which the certificate is issued
- `aws_acm_certificate_domain_validation_options` - A list of attributes to feed into other resources to complete certificate validation. Can have more than one element, e.g. if SANs are defined. Only set if DNS-validation was used
- `acm_certificate_validation_id` - The time at which the certificate was issued
- `acmpca_certificate_authority_id` - Amazon Resource Name (ARN) of the certificate authority.
- `acmpca_certificate_authority_arn` - Amazon Resource Name (ARN) of the certificate authority.
- `acmpca_certificate_authority_certificate` - Base64-encoded certificate authority (CA) certificate. Only available after the certificate authority certificate has been imported.
- `acmpca_certificate_authority_certificate_chain` - Base64-encoded certificate chain that includes any intermediate certificates and chains up to root on-premises certificate that you used to sign your private CA certificate. The chain does not include your private CA certificate. Only available after the certificate authority certificate has been imported.
- `acmpca_certificate_authority_certificate_signing_request` - The base64 PEM-encoded certificate signing request (CSR) for your private CA certificate.
- `acmpca_certificate_authority_not_after` - Date and time after which the certificate authority is not valid. Only available after the certificate authority certificate has been imported.
- `acmpca_certificate_authority_not_before` - Date and time before which the certificate authority is not valid. Only available after the certificate authority certificate has been imported.
- `acmpca_certificate_authority_serial` - Serial number of the certificate authority. Only available after the certificate authority certificate has been imported.
- `acmpca_certificate_authority_status` - Status of the certificate authority.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
