#---------------------------------------------------
# Vault token auth backend role
#---------------------------------------------------
variable "name" {
  description = "Set default suffix name"
  default     = "vault"
}

variable "environment" {
  description = "Set ENV"
  default     = "dev"
}

#---------------------------------------------------
# Vault policy
#---------------------------------------------------
variable "enable_policy" {
  description = "Enable policy for vault usage"
  default     = false
}

variable "policy_name" {
  description = "The name of the policy"
  default     = ""
}

variable "policy" {
  description = "(Required) String containing a Vault policy"
  default     = null
}

#---------------------------------------------------
# Vault rgp policy
#---------------------------------------------------
variable "enable_rgp_policy" {
  description = "Enable rgp policy for vault usage"
  default     = false
}

variable "rgp_policy_name" {
  description = "The name of the policy"
  default     = ""
}

variable "rgp_policy" {
  description = "(Required) String containing a Vault policy"
  default     = null
}

variable "rgp_policy_enforcement_level" {
  description = "(Required) Enforcement level of Sentinel policy. Can be either advisory or soft-mandatory or hard-mandatory"
  default     = null
}

#---------------------------------------------------
# Vault egp policy
#---------------------------------------------------
variable "enable_egp_policy" {
  description = "Enable egp policy for vault usage"
  default     = false
}

variable "egp_policy_name" {
  description = "The name of the policy"
  default     = ""
}

variable "egp_policy" {
  description = "(Required) String containing a Sentinel policy"
  default     = null
}

variable "egp_policy_enforcement_level" {
  description = "(Required) Enforcement level of Sentinel policy. Can be either advisory or soft-mandatory or hard-mandatory"
  default     = null
}

variable "egp_policy_paths" {
  description = "(Required) List of paths to which the policy will be applied to"
  default     = null
}
