#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST"
}

variable "environment" {
  description = "Environment for service"
  default     = "STAGE"
}

variable "tags" {
  description = "Add additional tags"
  default     = {}
}

#-----------------------------------------------------------
# ACM
#-----------------------------------------------------------
variable "acm_certificate" {
  description = "Enable acm certificate usage"
  default     = false
}

variable "domain_name" {
  description = "(Required) A domain name for which the certificate should be issued"
  default     = ""
}

variable "validation_method" {
  description = "(Required) Which method to use for validation. DNS or EMAIL are valid, NONE can be used for certificates that were imported into ACM and then into Terraform."
  default     = "DNS"
}

variable "subject_alternative_names" {
  description = "(Optional) A list of domains that should be SANs in the issued certificate"
  default     = []
}

variable "import_existing_certificate" {
  description = "Enable to import existing certificate"
  default     = false
}

variable "private_key" {
  description = "(Required) The certificate's PEM-formatted private key"
  default     = ""
}

variable "certificate_body" {
  description = "(Required) The certificate's PEM-formatted public key"
  default     = ""
}

variable "certificate_chain" {
  description = "(Optional) The certificate's PEM-formatted chain"
  default     = null
}

#-----------------------------------------------------------
# acm_certificate_validation
#-----------------------------------------------------------
variable "enable_acm_certificate" {
  description = "Enable to use acm certificate validation"
  default     = false
}

variable "certificate_arn" {
  description = "(Required) The ARN of the certificate that is being validated."
  default     = ""
}

variable "validation_record_fqdns" {
  description = "(Optional) List of FQDNs that implement the validation. Only valid for DNS validation method ACM certificates. If this is set, the resource can implement additional sanity checks and has an explicit dependency on the resource that is implementing the validation"
  default     = ["linux-notes.org"]
}

variable "timeouts_create" {
  description = "(Default 45m) How long to wait for a certificate to be issued."
  default     = "45m"
}

#-----------------------------------------------------------
# acmpca_certificate_authority
#-----------------------------------------------------------
variable "enable_acmpca_certificate_authority_default" {
  description = "Enable to use acmpca certificate authority"
  default     = false
}

variable "acmpca_certificate_authority_name" {
  description = "Set cert name for acmpca"
  default     = ""
}

variable "acmpca_certificate_authority_enabled" {
  description = "(Optional) Whether the certificate authority is enabled or disabled. Defaults to true."
  default     = true
}

variable "certificate_authority_configuration_key_algorithm" {
  description = "(Required) Type of the public key algorithm and size, in bits, of the key pair that your key pair creates when it issues a certificate. Valid values can be found in the ACM PCA Documentation. Can be used [EC_prime256v1 EC_secp384r1 RSA_2048 RSA_4096]"
  default     = "RSA_4096"
}

variable "certificate_authority_configuration_signing_algorithm" {
  description = "(Required) Name of the algorithm your private CA uses to sign certificate requests. Valid values can be found in the ACM PCA Documentation. Can be used [SHA256WITHECDSA SHA256WITHRSA SHA384WITHECDSA SHA384WITHRSA SHA512WITHECDSA SHA512WITHRSA]"
  default     = "SHA512WITHRSA"
}

variable "certificate_authority_configuration_subject_common_name" {
  description = "(Optional) Fully qualified domain name (FQDN) associated with the certificate subject."
  default     = null
}

variable "certificate_authority_configuration_subject_country" {
  description = "(Optional) Two digit code that specifies the country in which the certificate subject located."
  default     = null
}

variable "certificate_authority_configuration_subject_distinguished_name_qualifier" {
  description = "(Optional) Disambiguating information for the certificate subject."
  default     = null
}

variable "certificate_authority_configuration_subject_generation_qualifier" {
  description = "(Optional) Typically a qualifier appended to the name of an individual. Examples include Jr. for junior, Sr. for senior, and III for third."
  default     = null
}

variable "certificate_authority_configuration_subject_given_name" {
  description = "(Optional) First name."
  default     = null
}

variable "certificate_authority_configuration_subject_initials" {
  description = "(Optional) Concatenation that typically contains the first letter of the given_name, the first letter of the middle name if one exists, and the first letter of the surname."
  default     = null
}

variable "certificate_authority_configuration_subject_locality" {
  description = "(Optional) The locality (such as a city or town) in which the certificate subject is located."
  default     = null
}

variable "certificate_authority_configuration_subject_organization" {
  description = "(Optional) Legal name of the organization with which the certificate subject is affiliated."
  default     = null
}

variable "certificate_authority_configuration_subject_organizational_unit" {
  description = "(Optional) A subdivision or unit of the organization (such as sales or finance) with which the certificate subject is affiliated."
  default     = null
}

variable "certificate_authority_configuration_subject_pseudonym" {
  description = "(Optional) Typically a shortened version of a longer given_name. For example, Jonathan is often shortened to John. Elizabeth is often shortened to Beth, Liz, or Eliza."
  default     = null
}

variable "certificate_authority_configuration_subject_state" {
  description = "(Optional) State in which the subject of the certificate is located."
  default     = null
}

variable "certificate_authority_configuration_subject_surname" {
  description = "(Optional) Family name. In the US and the UK for example, the surname of an individual is ordered last. In Asian cultures the surname is typically ordered first."
  default     = null
}

variable "certificate_authority_configuration_subject_title" {
  description = "(Optional) A title such as Mr. or Ms. which is pre-pended to the name to refer formally to the certificate subject."
  default     = null
}

variable "acmpca_certificate_authority_permanent_deletion_time_in_days" {
  description = "(Optional) The number of days to make a CA restorable after it has been deleted, must be between 7 to 30 days, with default to 30 days."
  default     = null
}

variable "enable_acmpca_certificate_authority_revocation_configuration" {
  description = "Enable acmpca certificate authority wirth revocation configuration usage"
  default     = false
}

variable "revocation_configuration_crl_configuration_custom_cname" {
  description = "(Optional) Name inserted into the certificate CRL Distribution Points extension that enables the use of an alias for the CRL distribution point. Use this value if you don't want the name of your S3 bucket to be public."
  default     = null
}

variable "revocation_configuration_crl_configuration_enabled" {
  description = "(Optional) Boolean value that specifies whether certificate revocation lists (CRLs) are enabled. Defaults to false."
  default     = false
}

variable "revocation_configuration_crl_configuration_expiration_in_days" {
  description = "(Required) Number of days until a certificate expires. Must be between 1 and 5000. "
  default     = 10
}

variable "revocation_configuration_crl_configuration_s3_bucket_name" {
  description = "(Optional) Name of the S3 bucket that contains the CRL. If you do not provide a value for the custom_cname argument, the name of your S3 bucket is placed into the CRL Distribution Points extension of the issued certificate. You must specify a bucket policy that allows ACM PCA to write the CRL to your bucket."
  default     = null
}

variable "acmpca_certificate_authority_timeouts_create" {
  description = "(Default 1m) How long to wait for a certificate authority to be created."
  default     = "1m"
}
