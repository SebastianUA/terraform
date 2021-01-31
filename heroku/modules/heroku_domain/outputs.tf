#---------------------------------------------------
# Heroku domain
#---------------------------------------------------
output "domain_id" {
  description = "The ID of the of the domain record."
  value       = heroku_domain.domain.*.id
}

output "domain_hostname" {
  description = "The hostname traffic will be served as."
  value       = heroku_domain.domain.*.hostname
}

output "domain_cname" {
  description = "The CNAME traffic should route to."
  value       = heroku_domain.domain.*.cname
}
