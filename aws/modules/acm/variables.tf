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
variable "enable_acm_certificate" {
  description = "Enable acm certificate usage"
  default     = false
}

variable "acm_certificate_domain_name" {
  description = "(Required) A domain name for which the certificate should be issued"
  default     = ""
}

variable "acm_certificate_validation_method" {
  description = "(Required) Which method to use for validation. DNS or EMAIL are valid, NONE can be used for certificates that were imported into ACM and then into Terraform."
  default     = "DNS"
}

variable "acm_certificate_subject_alternative_names" {
  description = "(Optional) A list of domains that should be SANs in the issued certificate"
  default     = []
}

variable "acm_certificate_options" {
  description = "(Optional) Configuration block used to set certificate options."
  default     = []
}

variable "enable_import_existing_certificate" {
  description = "Enable import existing certificate usage"
  default     = false
}

variable "acm_certificate_private_key" {
  description = "(Required) The certificate's PEM-formatted private key"
  default     = ""
}

variable "acm_certificate_certificate_body" {
  description = "(Required) The certificate's PEM-formatted public key"
  default     = ""
}

variable "acm_certificate_certificate_chain" {
  description = "(Optional) The certificate's PEM-formatted chain"
  default     = null
}

variable "enable_acm_certificate_private_ca" {
  description = "Enable acm certificate private CA usage"
  default     = false
}

variable "acm_certificate_certificate_authority_arn" {
  description = "ARN of an ACMPCA"
  default     = null
}

#-----------------------------------------------------------
# acm_certificate_validation
#-----------------------------------------------------------
variable "enable_acm_certificate_validation" {
  description = "Enable to use acm certificate validation"
  default     = false
}

variable "acm_certificate_validation_certificate_arn" {
  description = "(Required) The ARN of the certificate that is being validated."
  default     = ""
}

variable "acm_certificate_validation_record_fqdns" {
  description = "(Optional) List of FQDNs that implement the validation. Only valid for DNS validation method ACM certificates. If this is set, the resource can implement additional sanity checks and has an explicit dependency on the resource that is implementing the validation"
  default     = null
}

variable "acm_certificate_validation_timeouts" {
  description = "Set timeouts for acm certificate validation"
  default     = []
}

#-----------------------------------------------------------
# acmpca_certificate_authority
#-----------------------------------------------------------
variable "enable_acmpca_certificate_authority" {
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

variable "acmpca_certificate_authority_certificate_authority_configuration_subject" {
  description = "Set subject settings"
  default     = []
}

variable "acmpca_certificate_authority_permanent_deletion_time_in_days" {
  description = "(Optional) The number of days to make a CA restorable after it has been deleted, must be between 7 to 30 days, with default to 30 days."
  default     = null
}

variable "acmpca_certificate_authority_crl_configuration" {
  description = "(Optional) Nested argument containing configuration of the certificate revocation list (CRL), if any, maintained by the certificate authority."
  default     = []
}

variable "acmpca_certificate_authority_timeouts" {
  description = "Set timeouts for acmpca"
  default     = []
}
