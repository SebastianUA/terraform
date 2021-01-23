#---------------------------------------------------
# Consul acl token
#---------------------------------------------------
resource "consul_acl_token" "acl_token" {
  count = var.enable_acl_token ? 1 : 0

  accessor_id = var.acl_token_accessor_id
  description = var.acl_token_description
  policies    = var.acl_token_policies != "" ? var.acl_token_policies : (var.enable_acl_policy ? [consul_acl_policy.acl_policy[0].name] : null)
  roles       = var.acl_token_roles != "" ? var.acl_token_roles : (var.enable_acl_role ? [consul_acl_role.acl_role[0].name] : null)
  local       = var.acl_token_local
  namespace   = var.acl_token_namespace

  depends_on = [
    consul_acl_policy.acl_policy,
    consul_acl_role.acl_role
  ]
}
