#---------------------------------------------------
# Consul acl policy
#---------------------------------------------------
output "consul_acl_policy_id" {
  description = "The ID of the policy."
  value       = element(concat(consul_acl_policy.acl_policy.*.id, [""]), 0)
}

output "consul_acl_policy_name" {
  description = "The name of the policy."
  value       = element(concat(consul_acl_policy.acl_policy.*.name, [""]), 0)
}

output "consul_acl_policy_description" {
  description = "The description of the policy."
  value       = element(concat(consul_acl_policy.acl_policy.*.description, [""]), 0)
}

output "consul_acl_policy_rules" {
  description = "The rules of the policy."
  value       = element(concat(consul_acl_policy.acl_policy.*.rules, [""]), 0)
}

output "consul_acl_policy_datacenters" {
  description = "The datacenters of the policy."
  value       = element(concat(consul_acl_policy.acl_policy.*.datacenters, [""]), 0)
}

#---------------------------------------------------
# Consul acl role
#---------------------------------------------------
output "consul_acl_role_id" {
  description = "The ID of the role."
  value       = element(concat(consul_acl_role.acl_role.*.id, [""]), 0)
}

output "consul_acl_role_name" {
  description = "The name of the ACL role."
  value       = element(concat(consul_acl_role.acl_role.*.name, [""]), 0)
}

output "consul_acl_role_description" {
  description = "A free form human readable description of the role."
  value       = element(concat(consul_acl_role.acl_role.*.description, [""]), 0)
}

output "consul_acl_role_policies" {
  description = "The list of policies that should be applied to the role."
  value       = element(concat(consul_acl_role.acl_role.*.policies, [""]), 0)
}

output "consul_acl_role_service_identities" {
  description = "The list of service identities that should be applied to the role."
  value       = element(concat(consul_acl_role.acl_role.*.service_identities, [""]), 0)
}

#---------------------------------------------------
# Consul acl auth method
#---------------------------------------------------
output "consul_acl_auth_method_id" {
  description = "The ID of the the auth method."
  value       = element(concat(consul_acl_auth_method.acl_auth_method.*.id, [""]), 0)
}

output "consul_acl_auth_method_name" {
  description = "The name of the ACL auth method."
  value       = element(concat(consul_acl_auth_method.acl_auth_method.*.name, [""]), 0)
}

output "consul_acl_auth_method_type" {
  description = "The type of the ACL auth method."
  value       = element(concat(consul_acl_auth_method.acl_auth_method.*.type, [""]), 0)
}

output "consul_acl_auth_method_display_name" {
  description = "An optional name to use instead of the name attribute when displaying information about this auth method."
  value       = element(concat(consul_acl_auth_method.acl_auth_method.*.display_name, [""]), 0)
}

output "consul_acl_auth_method_max_token_ttl" {
  description = "The maximum life of any token created by this auth method."
  value       = element(concat(consul_acl_auth_method.acl_auth_method.*.max_token_ttl, [""]), 0)
}

output "consul_acl_auth_method_token_locality" {
  description = "The kind of token that this auth method produces. This can be either 'local' or 'global'."
  value       = element(concat(consul_acl_auth_method.acl_auth_method.*.token_locality, [""]), 0)
}

output "consul_acl_auth_method_description" {
  description = "A free form human readable description of the auth method."
  value       = element(concat(consul_acl_auth_method.acl_auth_method.*.description, [""]), 0)
}

output "consul_acl_auth_method_config_json" {
  description = "The raw configuration for this ACL auth method."
  value       = element(concat(consul_acl_auth_method.acl_auth_method.*.config_json, [""]), 0)
}

output "consul_acl_auth_method_namespace" {
  description = "(Enterprise Only) The namespace to create the policy within."
  value       = element(concat(consul_acl_auth_method.acl_auth_method.*.namespace, [""]), 0)
}

output "consul_acl_auth_method_namespace_rule" {
  description = "(Enterprise Only) A set of rules that control which namespace tokens created via this auth method will be created within."
  value       = element(concat(consul_acl_auth_method.acl_auth_method.*.namespace_rule, [""]), 0)
}

#---------------------------------------------------
# Consul acl binding rule
#---------------------------------------------------
output "consul_acl_binding_rule_id" {
  description = "The ID of the the binding rule."
  value       = element(concat(consul_acl_binding_rule.acl_binding_rule.*.id, [""]), 0)
}

output "consul_acl_binding_rule_auth_method" {
  description = "The name of the ACL auth method this rule apply."
  value       = element(concat(consul_acl_binding_rule.acl_binding_rule.*.auth_method, [""]), 0)
}

output "consul_acl_binding_rule_description" {
  description = "A free form human readable description of the binding rule."
  value       = element(concat(consul_acl_binding_rule.acl_binding_rule.*.description, [""]), 0)
}

output "consul_acl_binding_rule_selector" {
  description = "The expression used to math this rule against valid identities returned from an auth method validation."
  value       = element(concat(consul_acl_binding_rule.acl_binding_rule.*.selector, [""]), 0)
}

output "consul_acl_binding_rule_bind_type" {
  description = "Specifies the way the binding rule affects a token created at login."
  value       = element(concat(consul_acl_binding_rule.acl_binding_rule.*.bind_type, [""]), 0)
}

output "consul_acl_binding_rule_bind_name" {
  description = "The name to bind to a token at login-time."
  value       = element(concat(consul_acl_binding_rule.acl_binding_rule.*.bind_name, [""]), 0)
}

#---------------------------------------------------
# Consul acl token
#---------------------------------------------------
output "consul_acl_token_id" {
  description = "The token ID."
  value       = element(concat(consul_acl_token.acl_token.*.id, [""]), 0)
}

output "consul_acl_token_accessor_id" {
  description = "The token accessor ID."
  value       = element(concat(consul_acl_token.acl_token.*.accessor_id, [""]), 0)
}

output "consul_acl_token_description" {
  description = "The description of the token."
  value       = element(concat(consul_acl_token.acl_token.*.description, [""]), 0)
}

output "consul_acl_token_policies" {
  description = "The list of policies attached to the token."
  value       = element(concat(consul_acl_token.acl_token.*.policies, [""]), 0)
}

output "consul_acl_token_roles" {
  description = "The list of roles attached to the token."
  value       = element(concat(consul_acl_token.acl_token.*.id, [""]), 0)
}

output "consul_acl_token_local" {
  description = "The flag to set the token local to the current datacenter."
  value       = element(concat(consul_acl_token.acl_token.*.local, [""]), 0)
}

#---------------------------------------------------
# Consul acl token policy attachment
#---------------------------------------------------
output "consul_acl_token_policy_attachment_id" {
  description = "The attachment ID."
  value       = element(concat(consul_acl_token_policy_attachment.acl_token_policy_attachment.*.id, [""]), 0)
}

output "consul_acl_token_policy_attachment_token_id" {
  description = "The id of the token."
  value       = element(concat(consul_acl_token_policy_attachment.acl_token_policy_attachment.*.token_id, [""]), 0)
}

output "consul_acl_token_policy_attachment_policy" {
  description = "The name of the policy attached to the token."
  value       = element(concat(consul_acl_token_policy_attachment.acl_token_policy_attachment.*.policy, [""]), 0)
}
