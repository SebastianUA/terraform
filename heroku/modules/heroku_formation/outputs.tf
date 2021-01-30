#---------------------------------------------------
# Heroku formation
#---------------------------------------------------
output "formation_id" {
  description = "Heroku formation ID"
  value       = heroku_formation.formation.*.id
}
