#---------------------------------------------------
# Heroku app feature
#---------------------------------------------------
resource "heroku_app_feature" "app_feature" {
  count = var.enable_app_feature ? 1 : 0

  name = var.app_feature_name != "" ? var.app_feature_name : "${var.name}-${var.environment}-app-feature"
  app  = var.app_feature_app != "" ? var.app_feature_app : (var.enable_app ? element(heroku_app.app.*.name, 0) : null)

  enabled = var.app_feature_enabled

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    heroku_app.app
  ]
}