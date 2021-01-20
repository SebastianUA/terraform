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
# Vault token
#---------------------------------------------------
variable "enable_token" {
  description = "Enable token for vault usage"
  default     = false
}

variable "token_display_name" {
  description = "(Optional) String containing the token display name"
  default     = null
}

variable "token_role_name" {
  description = "(Optional) The token role name"
  default     = null
}

variable "token_policies" {
  description = "(Optional) List of policies to attach to this token"
  default     = null
}

variable "token_renewable" {
  description = "(Optional) Flag to allow to renew this token"
  default     = null
}

variable "token_ttl" {
  description = "(Optional) The TTL period of this token"
  default     = null
}

variable "token_explicit_max_ttl" {
  description = "(Optional) The explicit max TTL of this token"
  default     = null
}

variable "token_renew_min_lease" {
  description = "(Optional) The minimal lease to renew this token"
  default     = null
}

variable "token_renew_increment" {
  description = "(Optional) The renew increment"
  default     = null
}

variable "token_pgp_key" {
  description = "(Optional) The PGP key with which the client_token will be encrypted. The key must be provided using either a base64 encoded non-armored PGP key, or a keybase username in the form keybase:somebody. The token won't be renewed automatically by the provider and client_token will be empty. If you do not set this argument, the client_token will be written as plain text in the Terraform state."
  default     = null
}

variable "token_no_parent" {
  description = "(Optional) Flag to create a token without parent"
  default     = null
}

variable "token_no_default_policy" {
  description = "(Optional) Flag to not attach the default policy to this token"
  default     = null
}

variable "token_period" {
  description = "(Optional) The period of this token"
  default     = null
}

variable "token_num_uses" {
  description = "(Optional) The number of allowed uses of this token"
  default     = null
}

#---------------------------------------------------
# Vault token auth backend role
#---------------------------------------------------
variable "enable_token_auth_backend_role" {
  description = "Enable token auth backend role for Vault usage"
  default     = false
}

variable "token_auth_backend_role_name" {
  description = "(Required) The name of the role."
  default     = ""
}

variable "token_auth_backend_role_allowed_policies" {
  description = "(Optional) List of allowed policies for given role."
  default     = null
}

variable "token_auth_backend_role_disallowed_policies" {
  description = "(Optional) List of disallowed policies for given role."
  default     = null
}

variable "token_auth_backend_role_orphan" {
  description = "(Optional) If true, tokens created against this policy will be orphan tokens."
  default     = null
}

variable "token_auth_backend_role_renewable" {
  description = "(Optional) Wether to disable the ability of the token to be renewed past its initial TTL."
  default     = null
}

variable "token_auth_backend_role_token_period" {
  description = "If set, indicates that the token generated using this role should never expire. The token should be renewed within the duration specified by this value. At each renewal, the token's TTL will be set to the value of this field. Specified in seconds."
  default     = null
}

variable "token_auth_backend_role_token_explicit_max_ttl" {
  description = "If set, the token will have an explicit max TTL set upon it."
  default     = null
}

variable "token_auth_backend_role_path_suffix" {
  description = "(Optional) Tokens created against this role will have the given suffix as part of their path in addition to the role name."
  default     = null
}

variable "token_auth_backend_role_token_ttl" {
  description = "(Optional) The incremental lifetime for generated tokens in number of seconds. Its current value will be referenced at renewal time."
  default     = null
}

variable "token_auth_backend_role_token_max_ttl" {
  description = "(Optional) The maximum lifetime for generated tokens in number of seconds. Its current value will be referenced at renewal time."
  default     = null
}

variable "token_auth_backend_role_token_bound_cidrs" {
  description = "(Optional) List of CIDR blocks; if set, specifies blocks of IP addresses which can authenticate successfully, and ties the resulting token to these blocks as well."
  default     = null
}

variable "token_auth_backend_role_token_no_default_policy" {
  description = "(Optional) If set, the default policy will not be set on generated tokens; otherwise it will be added to the policies set in token_policies."
  default     = null
}

variable "token_auth_backend_role_token_num_uses" {
  description = "(Optional) The period, if any, in number of seconds to set on the token."
  default     = null
}

variable "token_auth_backend_role_token_type" {
  description = "(Optional) The type of token that should be generated. Can be service, batch, or default to use the mount's tuned default (which unless changed will be service tokens). For token store roles, there are two additional possibilities: default-service and default-batch which specify the type to return unless the client requests a different type at generation time."
  default     = null
}
