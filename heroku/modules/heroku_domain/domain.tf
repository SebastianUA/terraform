#---------------------------------------------------
# Heroku domain
#---------------------------------------------------
resource "heroku_domain" "domain" {
  count = var.enable_domain ? 1 : 0

  app      = var.domain_app
  hostname = var.domain_hostname

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}