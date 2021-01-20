#---------------------------------------------------
# Vault token auth backend role
#---------------------------------------------------
resource "vault_token_auth_backend_role" "token_auth_backend_role" {
  count = var.enable_token_auth_backend_role ? 1 : 0

  role_name = var.token_auth_backend_role_name != "" ? var.token_auth_backend_role_name : "${var.name}-${var.environment}-auth-back-role"

  allowed_policies    = var.token_auth_backend_role_allowed_policies
  disallowed_policies = var.token_auth_backend_role_disallowed_policies
  orphan              = var.token_auth_backend_role_orphan
  renewable           = var.token_auth_backend_role_renewable

  token_period           = var.token_auth_backend_role_token_period
  token_explicit_max_ttl = var.token_auth_backend_role_token_explicit_max_ttl
  path_suffix            = var.token_auth_backend_role_path_suffix

  token_ttl     = var.token_auth_backend_role_token_ttl
  token_max_ttl = var.token_auth_backend_role_token_max_ttl

  token_bound_cidrs       = var.token_auth_backend_role_token_bound_cidrs
  token_no_default_policy = var.token_auth_backend_role_token_no_default_policy
  token_num_uses          = var.token_auth_backend_role_token_num_uses
  token_type              = var.token_auth_backend_role_token_type

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
