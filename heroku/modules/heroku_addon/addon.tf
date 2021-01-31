#---------------------------------------------------
# Heroku addon
#---------------------------------------------------
resource "heroku_addon" "addon" {
  count = var.enable_addon ? 1 : 0

  name = var.addon_name
  app  = var.addon_app
  plan = var.addon_plan

  config = var.addon_config

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}