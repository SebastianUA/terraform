#---------------------------------------------------
# Heroku config
#---------------------------------------------------
resource "heroku_config" "config" {
  count = var.enable_config ? 1 : 0

  vars           = var.config_vars
  sensitive_vars = var.config_sensitive_vars

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}