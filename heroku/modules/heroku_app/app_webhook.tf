#---------------------------------------------------
# Heroku app webhook
#---------------------------------------------------
resource "heroku_app_webhook" "app_webhook" {
  count = var.enable_app_webhook ? 1 : 0

  app_id  = var.app_webhook_app_id != "" ? var.app_webhook_app_id : (var.enable_app ? element(heroku_app.app.*.id, 0) : null)
  level   = var.app_webhook_level
  url     = var.app_webhook_url
  include = var.app_webhook_include

  secret        = var.app_webhook_secret
  authorization = var.app_webhook_authorization

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    heroku_app.app
  ]
}
