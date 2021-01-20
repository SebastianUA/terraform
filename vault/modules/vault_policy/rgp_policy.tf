#---------------------------------------------------
# Vault rgp policy
#---------------------------------------------------
resource "vault_rgp_policy" "rgp_policy" {
  count = var.enable_rgp_policy ? 1 : 0

  name              = var.rgp_policy_name != "" ? var.rgp_policy_name : "${var.name}-${var.environment}-rgp-policy"
  enforcement_level = var.rgp_policy_enforcement_level
  policy            = var.rgp_policy

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}