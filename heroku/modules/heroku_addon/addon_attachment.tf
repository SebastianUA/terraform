#---------------------------------------------------
# Heroku addon attachment
#---------------------------------------------------
resource "heroku_addon_attachment" "addon_attachment" {
  count = var.enable_addon_attachment ? 1 : 0

  name     = var.addon_attachment_name
  app_id   = var.addon_attachment_app_id
  addon_id = var.addon_attachment_addon_id != "" ? var.addon_attachment_addon_id : (var.enable_addon ? element(heroku_addon.addon.*.id, 0) : null)

  namespace = var.addon_attachment_namespace

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    heroku_addon.addon
  ]
}