#---------------------------------------------------
# Heroku drain
#---------------------------------------------------
resource "heroku_drain" "drain" {
  count = var.enable_drain ? 1 : 0

  app = var.drain_app
  url = var.drain_url

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}