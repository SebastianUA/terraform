#---------------------------------------------------
# Heroku space app access
#---------------------------------------------------
resource "heroku_space_app_access" "space_app_access" {
  count = var.enable_space_app_access ? 1 : 0

  space       = var.space_app_access_space != "" ? var.space_app_access_space : (var.enable_space ? element(heroku_space.space.*.name, 0) : null)
  email       = var.space_app_access_email
  permissions = var.space_app_access_permissions

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    heroku_space.space
  ]
}