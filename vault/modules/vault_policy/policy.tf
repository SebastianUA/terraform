#---------------------------------------------------
# Vault policy
#---------------------------------------------------
resource "vault_policy" "policy" {
  count = var.enable_policy ? 1 : 0

  name   = var.policy_name != "" ? var.policy_name : "${var.name}-${var.environment}-policy"
  policy = var.policy

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
