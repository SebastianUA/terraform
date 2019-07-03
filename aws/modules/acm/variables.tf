#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST-ACM"
}

variable "region" {
  description = "The region where to deploy this code (e.g. us-east-1)."
  default     = "us-east-1"
}

variable "environment" {
    description = "Environment for service"
    default     = "STAGE"
}

variable "orchestration" {
    description = "Type of orchestration"
    default     = "Terraform"
}

variable "createdby" {
    description = "Created by"
    default     = "Vitaliy Natarov"
}

#-----------------------------------------------------------
# ACM
#-----------------------------------------------------------
variable "acm_certificate" {
    description = "Enable acm certificate usage"
    default     = "false"
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
    type        = "list"
    default     = []
}

variable "import_existing_certificate" {
    description = "Enable to import existing certificate"
    default     = "false"
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
    default     = ""
}

#-----------------------------------------------------------
# acm_certificate_validation
#-----------------------------------------------------------
variable "acm_certificate_validation" {
    description = "Enable to use acm certificate validation"
    default     = "false"
}

variable "certificate_arn" {
    description = "(Required) The ARN of the certificate that is being validated."
    default     = ""
}

variable "validation_record_fqdns" {
    description = "(Optional) List of FQDNs that implement the validation. Only valid for DNS validation method ACM certificates. If this is set, the resource can implement additional sanity checks and has an explicit dependency on the resource that is implementing the validation"
    #type        = "list"
    default     = []
}

variable "timeouts_create" {
    description = "(Default 45m) How long to wait for a certificate to be issued."
    default     = "45m"
}
