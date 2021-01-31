#---------------------------------------------------
# Heroku app release
#---------------------------------------------------
resource "heroku_app_release" "app_release" {
  count = var.enable_app_release ? 1 : 0

  app         = var.app_release_app != "" ? var.app_release_app : (var.enable_app ? element(heroku_app.app.*.id, 0) : null)
  slug_id     = var.app_release_slug_id
  description = var.app_release_description

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    heroku_app.app
  ]
}
