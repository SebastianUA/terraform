#---------------------------------------------------
# Consul acl binding rule
#---------------------------------------------------
resource "consul_acl_binding_rule" "acl_binding_rule" {
  count = var.enable_acl_binding_rule ? 1 : 0

  auth_method = var.acl_binding_rule_auth_method != "" ? var.acl_binding_rule_auth_method : (var.enable_acl_auth_method ? consul_acl_auth_method.acl_auth_method[0].name : null)
  bind_type   = var.acl_binding_rule_bind_type
  bind_name   = var.acl_binding_rule_bind_name

  description = var.acl_binding_rule_description
  selector    = var.acl_binding_rule_selector
  namespace   = var.acl_binding_rule_namespace

  depends_on = [
    consul_acl_auth_method.acl_auth_method
  ]
}
