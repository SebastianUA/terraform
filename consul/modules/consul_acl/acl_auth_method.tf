#---------------------------------------------------
# Consul acl auth method
#---------------------------------------------------
resource "consul_acl_auth_method" "acl_auth_method" {
  count = var.enable_acl_auth_method ? 1 : 0

  name        = var.acl_auth_method_name != "" ? var.acl_auth_method_name : "${var.name}-${var.environment}-acl-auth-method"
  type        = var.acl_auth_method_type
  config_json = var.acl_auth_method_config_json

  display_name   = var.acl_auth_method_display_name
  description    = var.acl_auth_method_description
  max_token_ttl  = var.acl_auth_method_max_token_ttl
  token_locality = var.acl_auth_method_token_locality
  namespace      = var.acl_auth_method_namespace

  dynamic "namespace_rule" {
    iterator = namespace_rule
    for_each = var.acl_auth_method_namespace_rule

    content {
      selector       = lookup(namespace_rule.value, "selector", null)
      bind_namespace = lookup(namespace_rule.value, "bind_namespace", null)
    }
  }

  depends_on = []
}
