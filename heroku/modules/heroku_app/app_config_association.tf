#---------------------------------------------------
# Heroku app config association
#---------------------------------------------------
resource "heroku_app_config_association" "app_config_association" {
  count = var.enable_app_config_association ? 1 : 0

  app_id = var.app_config_association_app_id != "" ? var.app_config_association_app_id : (var.enable_app ? element(heroku_app.app.*.id, 0) : null)

  vars           = var.app_config_association_vars
  sensitive_vars = var.app_config_association_sensitive_vars

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    heroku_app.app
  ]
}