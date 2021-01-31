#---------------------------------------------------
# Heroku collaborator
#---------------------------------------------------
resource "heroku_collaborator" "collaborator" {
  count = var.enable_collaborator ? 1 : 0

  app   = var.collaborator_app
  email = var.collaborator_email

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}