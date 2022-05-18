#-----------------------------------------------------------
# Global
#-----------------------------------------------------------
variable "name" {
  description = "The name for newrelic_alert resources"
  default     = "test"
}

#-----------------------------------------------------------
# TLS private key
#-----------------------------------------------------------
variable "enable_tls_private_key" {
  description = "Enable tls_private_key usage"
  default     = false
}

variable "tls_private_key_algorithm" {
  description = "(Required) The name of the algorithm to use for the key. Currently-supported values are 'RSA' and 'ECDSA'."
  default     = "RSA"
}

variable "tls_private_key_ecdsa_curve" {
  description = "(Optional) When algorithm is 'ECDSA', the name of the elliptic curve to use. May be any one of 'P224', 'P256', 'P384' or 'P521', with 'P224' as the default."
  default     = "P224"
}

variable "tls_private_key_rsa_bits" {
  description = "(Optional) When algorithm is 'RSA', the size of the generated RSA key in bits. Defaults to 2048."
  default     = 2048
}

#-----------------------------------------------------------
# TLS self signed cert
#-----------------------------------------------------------
variable "enable_self_signed_cert" {
  description = "Enable self_signed_cert usage"
  default     = false
}

variable "tls_self_signed_cert_private_key_pem" {
  description = "(Required) PEM-encoded private key data. This can be read from a separate file using the file interpolation function. If the certificate is being generated to be used for a throwaway development environment or other non-critical application, the tls_private_key resource can be used to generate a TLS private key from within Terraform. Only an irreversable secure hash of the private key will be stored in the Terraform state."
  default     = ""
}

variable "tls_self_signed_cert_set_authority_key_id" {
  description = "(Boolean) Should the generated certificate include an authority key identifier: for self-signed certificates this is the same value as the subject key identifier (default: false)."
  default     = null
}

variable "tls_self_signed_cert_set_subject_key_id" {
  description = "(Boolean) Should the generated certificate include a subject key identifier (default: false)."
  default     = null
}

variable "tls_self_signed_cert_uris" {
  description = "(List of String) List of URIs for which a certificate is being requested (i.e. certificate subjects)."
  default     = null
}

variable "tls_self_signed_cert_subject" {
  description = "(Block List, Max: 1) The subject for which a certificate is being requested. The acceptable arguments are all optional and their naming is based upon Issuer Distinguished Names (RFC5280) section. (see below for nested schema)"
  default     = {}
}

variable "tls_self_signed_cert_validity_period_hours" {
  description = "(Required) The number of hours after initial issuing that the certificate will become invalid."
  default     = 12
}

variable "tls_self_signed_cert_allowed_uses" {
  description = "(Required) List of keywords each describing a use that is permitted for the issued certificate. The valid keywords are listed below."
  default = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

variable "tls_self_signed_cert_dns_names" {
  description = "(Optional) List of DNS names for which a certificate is being requested."
  default     = []
}

variable "tls_self_signed_cert_ip_addresses" {
  description = "(Optional) List of IP addresses for which a certificate is being requested"
  default     = []
}

variable "tls_self_signed_cert_early_renewal_hours" {
  description = "(Optional) If set, the resource will consider the certificate to have expired the given number of hours before its actual expiry time. This can be useful to deploy an updated certificate in advance of the expiration of the current certificate. Note however that the old certificate remains valid until its true expiration time, since this resource does not (and cannot) support certificate revocation. Note also that this advance update can only be performed should the Terraform configuration be applied during the early renewal period."
  default     = 12
}

variable "tls_self_signed_cert_is_ca_certificate" {
  description = "(Optional) Boolean controlling whether the CA flag will be set in the generated certificate. Defaults to false, meaning that the certificate does not represent a certificate authority."
  default     = false
}

#-----------------------------------------------------------
# TLS locally signed cert
#-----------------------------------------------------------
variable "enable_locally_signed_cert" {
  description = "Enable tls_locally_signed_cert usage"
  default     = false
}

variable "locally_signed_cert_cert_request_pem" {
  description = "(Required) PEM-encoded request certificate data."
  default     = ""
}

variable "locally_signed_cert_ca_private_key_pem" {
  description = "(Required) PEM-encoded private key data for the CA. This can be read from a separate file using the file interpolation function."
  default     = ""
}

variable "locally_signed_cert_ca_cert_pem" {
  description = "(Required) PEM-encoded certificate data for the CA."
  default     = ""
}

variable "locally_signed_cert_locally_validity_period_hours" {
  description = "(Required) The number of hours after initial issuing that the certificate will become invalid."
  default     = 12
}

variable "locally_signed_cert_locally_allowed_uses" {
  description = "(Required) List of keywords each describing a use that is permitted for the issued certificate. The valid keywords are listed below."
  default = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

variable "locally_signed_cert_early_renewal_hours" {
  description = "(Optional) If set, the resource will consider the certificate to have expired the given number of hours before its actual expiry time. This can be useful to deploy an updated certificate in advance of the expiration of the current certificate. Note however that the old certificate remains valid until its true expiration time, since this resource does not (and cannot) support certificate revocation. Note also that this advance update can only be performed should the Terraform configuration be applied during the early renewal period."
  default     = null
}

variable "locally_signed_cert_is_ca_certificate" {
  description = "(Optional) Boolean controlling whether the CA flag will be set in the generated certificate. Defaults to false, meaning that the certificate does not represent a certificate authority."
  default     = null
}

variable "locally_signed_cert_set_subject_key_id" {
  description = "(Boolean) Should the generated certificate include a subject key identifier (default: false)."
  default     = null
}

#-----------------------------------------------------------
# TLS cert request
#-----------------------------------------------------------
variable "enable_tls_cert_request" {
  description = "Enable cert_request usage"
  default     = false
}

variable "tls_cert_request_private_key_pem" {
  description = "(Required) PEM-encoded private key data. This can be read from a separate file using the file interpolation function. Only an irreversable secure hash of the private key will be stored in the Terraform state."
  default     = ""
}

variable "tls_cert_request_dns_names" {
  description = "(Optional) List of DNS names for which a certificate is being requested."
  default     = []
}

variable "tls_cert_request_ip_addresses" {
  description = "(Optional) List of IP addresses for which a certificate is being requested."
  default     = []
}

variable "tls_cert_request_uris" {
  description = "(List of String) List of URIs for which a certificate is being requested (i.e. certificate subjects)."
  default     = null
}

variable "tls_cert_request_subject" {
  description = "(Block List, Max: 1) The subject for which a certificate is being requested. The acceptable arguments are all optional and their naming is based upon Issuer Distinguished Names (RFC5280) section. (see below for nested schema)"
  default     = {}
}
