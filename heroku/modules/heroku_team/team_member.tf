#---------------------------------------------------
# Heroku team member
#---------------------------------------------------
resource "heroku_team_member" "team_member" {
  count = var.enable_team_member ? 1 : 0

  team  = var.team_member_team != "" ? var.team_member_team : "${var.name}-${var.environment}-team-member"
  email = var.team_member_email
  role  = var.team_member_role

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
