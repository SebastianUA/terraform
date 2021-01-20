#---------------------------------------------------
# Vault egp policy
#---------------------------------------------------
resource "vault_egp_policy" "egp_policy" {
  count = var.enable_egp_policy ? 1 : 0

  name              = var.egp_policy_name != "" ? var.egp_policy_name : "${var.name}-${var.environment}-egp-policy"
  paths             = var.egp_policy_paths
  enforcement_level = var.egp_policy_enforcement_level

  policy = var.egp_policy

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}