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
  description = "A list of tag blocks."
  type        = map(string)
  default     = {}
}

#---------------------------------------------------
# AWS rolesanywhere profile
#---------------------------------------------------
variable "enable_rolesanywhere_profile" {
  description = "Enable rolesanywhere profile usage"
  default     = false
}

variable "rolesanywhere_profile_name" {
  description = "The name of the Profile."
  default     = ""
}

variable "rolesanywhere_profile_role_arns" {
  description = "(Required) A list of IAM roles that this profile can assume"
  default     = []
}

variable "rolesanywhere_profile_duration_seconds" {
  description = "(Optional) The number of seconds the vended session credentials are valid for. Defaults to 3600."
  default     = null
}

variable "rolesanywhere_profile_enabled" {
  description = "(Optional) Whether or not the Profile is enabled."
  default     = null
}

variable "rolesanywhere_profile_managed_policy_arns" {
  description = "(Optional) A list of managed policy ARNs that apply to the vended session credentials."
  default     = null
}

variable "rolesanywhere_profile_require_instance_properties" {
  description = "(Optional) Specifies whether instance properties are required in CreateSession requests with this profile."
  default     = null
}

variable "rolesanywhere_profile_session_policy" {
  description = "(Optional) A session policy that applies to the trust boundary of the vended session credentials."
  default     = null
}

#---------------------------------------------------
# AWS rolesanywhere trust anchor
#---------------------------------------------------
variable "enable_rolesanywhere_trust_anchor" {
  description = "Enable rolesanywhere trust anchor usage"
  default     = false
}

variable "rolesanywhere_trust_anchor_name" {
  description = "The name of the Trust Anchor."
  default     = ""
}

variable "rolesanywhere_trust_anchor_enabled" {
  description = "(Optional) Whether or not the Trust Anchor should be enabled."
  default     = null
}

variable "rolesanywhere_trust_anchor_source" {
  description = "(Required) The source of trust"
  default     = {}
}
