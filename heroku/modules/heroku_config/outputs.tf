#---------------------------------------------------
# Heroku config
#---------------------------------------------------
output "config_id" {
  description = "The ID of the config."
  value       = heroku_config.config.*.id
}
