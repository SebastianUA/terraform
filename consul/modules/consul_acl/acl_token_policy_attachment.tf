#---------------------------------------------------
# Consul acl token policy attachment
#---------------------------------------------------
resource "consul_acl_token_policy_attachment" "acl_token_policy_attachment" {
  count = var.enable_acl_token_policy_attachment ? 1 : 0

  token_id = var.acl_token_policy_attachment_token_id != "" ? var.acl_token_policy_attachment_token_id : (var.enable_acl_token ? consul_acl_token.acl_token[0].id : null)
  policy   = var.acl_token_policy_attachment_policy != "" ? var.acl_token_policy_attachment_policy : (var.enable_acl_policy ? consul_acl_policy.acl_policy[0].name : null)

  lifecycle {
    ignore_changes = []
  }

  depends_on = [
    consul_acl_token.acl_token,
    consul_acl_policy.acl_policy
  ]
}
