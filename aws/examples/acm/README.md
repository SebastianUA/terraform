# Work with AWS ACM via terraform

A terraform module for making Amazon Certificate Manager.

## Usage
----------------------

Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
    required_version = "~>0.12.2"
}

provider "aws" {
    region                  = "us-east-1"
    profile                 = "default"
    shared_credentials_file = "${pathexpand("~/.aws/credentials")}"
}

module "acm_certificate" {
    source                      = "../../modules/acm"
                        
    acm_certificate             = "true"

    domain_name                 = "linux-notes.org"
    subject_alternative_names   = ["www.linux-notes.org", "linux-notes.org"]
    validation_method           = "EMAIL"

    import_existing_certificate = "false"
    #private_key                 = ""
    #certificate_body            = ""
    #certificate_chain           = ""
}

module "acm_certificate_validation" {
    source                      = "../../modules/acm"
    
    acm_certificate_validation  = "true"
    certificate_arn             = "${module.acm_certificate.aws_acm_certificate_arn}"
    validation_record_fqdns     = []
}

```

Module Input Variables
----------------------

- `name` - Name to be used on all resources as prefix(`default     = "TEST"`).
- `region` - The region where to deploy this code (e.g. us-east-1).(`default     = "us-east-1"`).
- `environment` - Environment for service(`default     = "STAGE"`).
- `orchestration` - Type of orchestration(`default     = "Terraform"`).
- `createdby` - Created by(`default     = "Vitaliy Natarov"`).
- `acm_certificate` - Enable acm certificate usage(`default     = false`).
- `domain_name` - (Required) A domain name for which the certificate should be issued(`default     = ""`).
- `validation_method` - (Required) Which method to use for validation. DNS or EMAIL are valid, NONE can be used for certificates that were imported into ACM and then into Terraform.(`default     = "DNS"`).
- `subject_alternative_names` - (Optional) A list of domains that should be SANs in the issued certificate(`default     = []`).
- `import_existing_certificate` - Enable to import existing certificate(`default     = false`).
- `private_key` - (Required) The certificate's PEM-formatted private key(`default     = ""`).
- `certificate_body` - (Required) The certificate's PEM-formatted public key(`default     = ""`).
- `certificate_chain` - (Optional) The certificate's PEM-formatted chain(`default     = ""`).
- `enable_acm_certificate` - Enable to use acm certificate validation(`default     = false`).
- `certificate_arn` - (Required) The ARN of the certificate that is being validated.(`default     = ""`).
- `validation_record_fqdns` - (Optional) List of FQDNs that implement the validation. Only valid for DNS validation method ACM certificates. If this is set, the resource can implement additional sanity checks and has an explicit dependency on the resource that is implementing the validation(`default     = ["linux-notes.org"]`).
- `timeouts_create` - (Default 45m) How long to wait for a certificate to be issued.(`default     = "45m"`).
- `enable_acmpca_certificate_authority_default` - Enable to use acmpca certificate authority(`default     = false`).
- `acmpca_certificate_authority_enabled` - (Optional) Whether the certificate authority is enabled or disabled. Defaults to true.(`default     = true`).
- `certificate_authority_configuration_key_algorithm` - (Required) Type of the public key algorithm and size, in bits, of the key pair that your key pair creates when it issues a certificate. Valid values can be found in the ACM PCA Documentation. Can be used [EC_prime256v1 EC_secp384r1 RSA_2048 RSA_4096](`default   = "RSA_4096"`).
- `certificate_authority_configuration_signing_algorithm` - (Required) Name of the algorithm your private CA uses to sign certificate requests. Valid values can be found in the ACM PCA Documentation. Can be used [SHA256WITHECDSA SHA256WITHRSA SHA384WITHECDSA SHA384WITHRSA SHA512WITHECDSA SHA512WITHRSA](`default     = "SHA512WITHRSA"`).
- `certificate_authority_configuration_subject_common_name` - (Optional) Fully qualified domain name (FQDN) associated with the certificate subject.(`default     = ""`).
- `certificate_authority_configuration_subject_country` - (Optional) Two digit code that specifies the country in which the certificate subject located.(`default     = 66666`).
- `certificate_authority_configuration_subject_distinguished_name_qualifier` - (Optional) Disambiguating information for the certificate subject.(`default     = "qualifier"`).
- `certificate_authority_configuration_subject_generation_qualifier` - (Optional) Typically a qualifier appended to the name of an individual. Examples include Jr. for junior, Sr. for senior, and III for third.(`default     = "Sr"`).
- `certificate_authority_configuration_subject_given_name` - (Optional) First name.(`default     = "First name"`).
- `certificate_authority_configuration_subject_initials` - (Optional) Concatenation that typically contains the first letter of the given_name, the first letter of the middle name if one exists, and the first letter of the surname.(`default     = "initials"`).
- `certificate_authority_configuration_subject_locality` - (Optional) The locality (such as a city or town) in which the certificate subject is located.(`default     = "Kiev"`).
- `certificate_authority_configuration_subject_organization` - (Optional) Legal name of the organization with which the certificate subject is affiliated.(`default     = "Org"`).
- `certificate_authority_configuration_subject_organizational_unit` - (Optional) A subdivision or unit of the organization (such as sales or finance) with which the certificate subject is affiliated.(`default     = "My org unit"`).
- `certificate_authority_configuration_subject_pseudonym` - (Optional) Typically a shortened version of a longer given_name. For example, Jonathan is often shortened to John. Elizabeth is often shortened to Beth, Liz, or Eliza.(`default     = "Vitalii Natarov"`).
- `certificate_authority_configuration_subject_state` - (Optional) State in which the subject of the certificate is located.(`default     = "Kiev"`).
- `certificate_authority_configuration_subject_surname` - (Optional) Family name. In the US and the UK for example, the surname of an individual is ordered last. In Asian cultures the surname is typically ordered first.(`default     = "UA"`).
- `certificate_authority_configuration_subject_title` - (Optional) A title such as Mr. or Ms. which is pre-pended to the name to refer formally to the certificate subject.(`default     = "Mr"`).
- `acmpca_certificate_authority_permanent_deletion_time_in_days` - (Optional) The number of days to make a CA restorable after it has been deleted, must be between 7 to 30 days, with default to 30 days.(`default     = 7`).
- `enable_acmpca_certificate_authority_revocation_configuration` - Enable acmpca certificate authority wirth revocation configuration usage(`default     = false`).
- `revocation_configuration_crl_configuration_custom_cname` - (Optional) Name inserted into the certificate CRL Distribution Points extension that enables the use of an alias for the CRL distribution point. Use this value if you don't want the name of your S3 bucket to be public.(`default     = ""`).
- `revocation_configuration_crl_configuration_enabled` - (Optional) Boolean value that specifies whether certificate revocation lists (CRLs) are enabled. Defaults to false.(`default     = false`).
- `revocation_configuration_crl_configuration_expiration_in_days` - (Required) Number of days until a certificate expires. Must be between 1 and 5000.(`default     = 10`).
- `revocation_configuration_crl_configuration_s3_bucket_name` - (Optional) Name of the S3 bucket that contains the CRL. If you do not provide a value for the custom_cname argument, the name of your S3 bucket is placed into the CRL Distribution Points extension of the issued certificate. You must specify a bucket policy that allows ACM PCA to write the CRL to your bucket.(`default     = ""`).
- `acmpca_certificate_authority_timeouts_create` - (Default 1m) How long to wait for a certificate authority to be created.(`default     = "1m"`).

Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.
