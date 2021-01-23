#-----------------------------------------------------------
# Global
#-----------------------------------------------------------
variable "name" {
  description = "Set name for Consul namespace if doesnt set acl's name properly"
  default     = false
}

variable "environment" {
  description = "Set env for Consul acl if does not set name"
  default     = "dev"
}

#---------------------------------------------------
# Consul acl policy
#---------------------------------------------------
variable "enable_acl_policy" {
  description = "Enable Consul ACL policy usage"
  default     = false
}

variable "acl_policy_name" {
  description = "The name of the policy."
  default     = null
}

variable "acl_policy_rules" {
  description = "(Required) The rules of the policy."
  default     = null
}

variable "acl_policy_description" {
  description = "(Optional) The description of the policy."
  default     = null
}

variable "acl_policy_datacenters" {
  description = "(Optional) The datacenters of the policy."
  default     = null
}

variable "acl_policy_namespace" {
  description = "(Optional, Enterprise Only) The namespace to create the policy within."
  default     = null
}

#---------------------------------------------------
# Consul acl role
#---------------------------------------------------
variable "enable_acl_role" {
  description = "Enable acl role usage"
  default     = false
}

variable "acl_role_name" {
  description = "The name of the ACL role."
  default     = ""
}

variable "acl_role_description" {
  description = "(Optional) A free form human readable description of the role."
  default     = null
}

variable "acl_role_policies" {
  description = "(Optional) The list of policies that should be applied to the role."
  default     = null
}

variable "acl_role_namespace" {
  description = "(Optional, Enterprise Only) The namespace to create the role within."
  default     = null
}

variable "acl_role_service_identities" {
  description = "(Optional) The list of service identities that should be applied to the role."
  default     = []
}

#---------------------------------------------------
# Consul acl auth method
#---------------------------------------------------
variable "enable_acl_auth_method" {
  description = "Enable Consul acl auth method usage"
  default     = false
}

variable "acl_auth_method_name" {
  description = "The name of the ACL auth method."
  default     = ""
}

variable "acl_auth_method_type" {
  description = "(Required) The type of the ACL auth method (Ex: kubernetes, jwt)."
  default     = null
}

variable "acl_auth_method_config_json" {
  description = "(Required) The raw configuration for this ACL auth method."
  default     = null
}

variable "acl_auth_method_display_name" {
  description = "(Optional) An optional name to use instead of the name attribute when displaying information about this auth method."
  default     = null
}

variable "acl_auth_method_description" {
  description = "(Optional) A free form human readable description of the auth method."
  default     = null
}

variable "acl_auth_method_max_token_ttl" {
  description = "(Optional) The maximum life of any token created by this auth method."
  default     = null
}

variable "acl_auth_method_token_locality" {
  description = "Optional) The kind of token that this auth method produces. This can be either 'local' or 'global'."
  default     = null
}

variable "acl_auth_method_namespace" {
  description = "(Optional, Enterprise Only) The namespace to create the policy within."
  default     = null
}

variable "acl_auth_method_namespace_rule" {
  description = "(Optional, Enterprise Only) A set of rules that control which namespace tokens created via this auth method will be created within."
  default     = []
}

#---------------------------------------------------
# Consul acl binding rule
#---------------------------------------------------
variable "enable_acl_binding_rule" {
  description = "Enable Consul acl binding rule usage"
  default     = false
}

variable "acl_binding_rule_auth_method" {
  description = "The name of the ACL auth method this rule apply."
  default     = ""
}

variable "acl_binding_rule_bind_type" {
  description = "(Required) Specifies the way the binding rule affects a token created at login."
  default     = null
}

variable "acl_binding_rule_bind_name" {
  description = "(Required) The name to bind to a token at login-time."
  default     = null
}

variable "acl_binding_rule_description" {
  description = "(Optional) A free form human readable description of the binding rule."
  default     = null
}

variable "acl_binding_rule_selector" {
  description = "(Optional) The expression used to math this rule against valid identities returned from an auth method validation."
  default     = null
}

variable "acl_binding_rule_namespace" {
  description = "(Optional, Enterprise Only) The namespace to create the binding rule within."
  default     = null
}

#---------------------------------------------------
# Consul acl token
#---------------------------------------------------
variable "enable_acl_token" {
  description = "Enable Consul acltoken usage"
  default     = false
}

variable "acl_token_accessor_id" {
  description = "(Optional) The uuid of the token. If omitted, Consul will generate a random uuid."
  default     = null
}

variable "acl_token_description" {
  description = "(Optional) The description of the token."
  default     = null
}

variable "acl_token_policies" {
  description = "(Optional) The list of policies attached to the token."
  default     = null
}

variable "acl_token_roles" {
  description = "(Optional) The list of roles attached to the token."
  default     = null
}

variable "acl_token_local" {
  description = "(Optional) The flag to set the token local to the current datacenter."
  default     = null
}

variable "acl_token_namespace" {
  description = "(Optional, Enterprise Only) The namespace to create the token within."
  default     = null
}

#---------------------------------------------------
# Consul acl token policy attachment
#---------------------------------------------------
variable "enable_acl_token_policy_attachment" {
  description = "Enable Consul acl token policy attachment usage"
  default     = false
}

variable "acl_token_policy_attachment_token_id" {
  description = "The id of the token."
  default     = ""
}

variable "acl_token_policy_attachment_policy" {
  description = "The name of the policy attached to the token."
  default     = ""
}
