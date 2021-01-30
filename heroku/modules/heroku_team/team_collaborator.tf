#---------------------------------------------------
# Heroku team collaborator
#---------------------------------------------------
resource "heroku_team_collaborator" "team_collaborator" {
  count = var.enable_team_collaborator ? 1 : 0

  app         = var.team_collaborator_app
  email       = var.team_collaborator_email
  permissions = var.team_collaborator_permissions

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}