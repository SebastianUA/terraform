#---------------------------------------------------
# Heroku collaborator
#---------------------------------------------------
output "collaborator_id" {
  description = "The ID of the collaborator."
  value       = heroku_collaborator.collaborator.*.id
}