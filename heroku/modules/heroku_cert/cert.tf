#---------------------------------------------------
# Heroku cert
#---------------------------------------------------
resource "heroku_cert" "cert" {
  count = var.enable_cert ? 1 : 0

  app               = var.cert_app
  certificate_chain = var.cert_certificate_chain
  private_key       = var.cert_private_key

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
