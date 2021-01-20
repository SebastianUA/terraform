#---------------------------------------------------
# Vault token
#---------------------------------------------------
resource "vault_token" "token" {
  count = var.enable_token ? 1 : 0

  display_name = var.token_display_name
  role_name    = var.token_role_name
  policies     = var.token_policies

  renewable        = var.token_renewable
  ttl              = var.token_ttl
  explicit_max_ttl = var.token_explicit_max_ttl

  renew_min_lease = var.token_renew_min_lease
  renew_increment = var.token_renew_increment

  pgp_key = var.token_pgp_key

  no_parent         = var.token_no_parent
  no_default_policy = var.token_no_default_policy
  period            = var.token_period
  num_uses          = var.token_num_uses

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
