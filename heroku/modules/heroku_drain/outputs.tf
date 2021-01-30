#---------------------------------------------------
# Heroku drain
#---------------------------------------------------
output "drain_id" {
  description = "The ID of token"
  value       = heroku_drain.drain.*.id
}

output "drain_token" {
  description = "The unique token for your created drain."
  value       = heroku_drain.drain.*.token
}
