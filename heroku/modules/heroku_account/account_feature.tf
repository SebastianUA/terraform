#---------------------------------------------------
# Heroku account feature
#---------------------------------------------------
resource "heroku_account_feature" "account_feature" {
  count = var.enable_account_feature ? 1 : 0

  name    = var.account_feature_name
  enabled = var.account_feature_enabled

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}