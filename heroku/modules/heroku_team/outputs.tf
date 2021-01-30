#---------------------------------------------------
# Heroku team collaborator
#---------------------------------------------------
output "team_collaborator_id" {
  description = "The ID of the team collaborator"
  value       = heroku_team_collaborator.team_collaborator.*.id
}

#---------------------------------------------------
# Heroku team member
#---------------------------------------------------
output "team_member_id" {
  description = "The ID of the team member"
  value       = heroku_team_member.team_member.*.id
}
