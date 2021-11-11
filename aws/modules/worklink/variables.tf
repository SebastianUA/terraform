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

#---------------------------------------------------
# AWS worklink fleet
#---------------------------------------------------
variable "enable_worklink_fleet" {
  description = "Enable worklink fleet usage"
  default     = false
}

variable "worklink_fleet_name" {
  description = "A region-unique name for the AMI."
  default     = ""
}

variable "worklink_fleet_audit_stream_arn" {
  description = "(Optional) The ARN of the Amazon Kinesis data stream that receives the audit events."
  default     = null
}

variable "worklink_fleet_device_ca_certificate" {
  description = "(Optional) The certificate chain, including intermediate certificates and the root certificate authority certificate used to issue device certificates."
  default     = null
}

variable "worklink_fleet_display_name" {
  description = "(Optional) The name of the fleet."
  default     = null
}

variable "worklink_fleet_optimize_for_end_user_location" {
  description = "(Optional) The option to optimize for better performance by routing traffic through the closest AWS Region to users, which may be outside of your home Region. Defaults to true."
  default     = null
}

variable "worklink_fleet_network" {
  description = "(Optional) Provide this to allow manage the company network configuration for the fleet."
  default     = []
}

variable "worklink_fleet_identity_provider" {
  description = "(Optional) Provide this to allow manage the identity provider configuration for the fleet."
  default     = []
}

#---------------------------------------------------
# AWS worklink website certificate authority association
#---------------------------------------------------
variable "enable_worklink_website_certificate_authority_association" {
  description = "Enable worklink website certificate authority association usage"
  default     = false
}

variable "worklink_website_certificate_authority_association_fleet_arn" {
  description = "The ARN of the fleet."
  default     = ""
}

variable "worklink_website_certificate_authority_association_certificate" {
  description = "(Required, ForceNew) The root certificate of the Certificate Authority."
  default     = null
}

variable "worklink_website_certificate_authority_association_display_name" {
  description = "(Optional, ForceNew) The certificate name to display."
  default     = null
}
