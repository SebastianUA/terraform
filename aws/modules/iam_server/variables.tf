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

#-----------------------------------------------------------
# IAM certificate
#-----------------------------------------------------------
variable "enable_iam_server_certificate" {
  description = "Allow upload server certificate"
  default     = false
}

variable "iam_server_certificate_name" {
  description = "Set custom iam server cert name"
  default     = ""
}

variable "iam_server_certificate_name_prefix" {
  description = "(Optional) Creates a unique name beginning with the specified prefix. Conflicts with iam_server_certificate_name."
  default     = ""
}

variable "iam_server_certificate_body" {
  description = "(Required) The contents of the public key certificate in PEM-encoded format."
  default     = ""
}

variable "iam_server_certificate_private_key" {
  description = "(Required) The contents of the private key in PEM-encoded format."
  default     = ""
}

variable "iam_server_certificate_chain" {
  description = "(Optional) The contents of the certificate chain. This is typically a concatenation of the PEM-encoded public key certificates of the chain."
  default     = null
}

variable "iam_server_certificate_path" {
  description = "(Optional) The IAM path for the server certificate. If it is not included, it defaults to a slash (/). If this certificate is for use with AWS CloudFront, the path must be in format /cloudfront/your_path_here. See IAM Identifiers for more details on IAM Paths."
  default     = null
}
