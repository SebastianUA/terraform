#---------------------------------------------------
# Heroku formation
#---------------------------------------------------
resource "heroku_formation" "formation" {
  count = var.enable_formation ? 1 : 0

  app      = var.formation_app
  type     = var.formation_type
  quantity = var.formation_quantity
  size     = var.formation_size


  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
