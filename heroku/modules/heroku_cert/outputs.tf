#---------------------------------------------------
# Heroku cert
#---------------------------------------------------
output "cert_id" {
  description = "The ID of the add-on"
  value       = heroku_cert.cert.*.id
}

output "cert_cname" {
  description = "The CNAME for the SSL endpoint"
  value       = heroku_cert.cert.*.cname
}

output "cert_name" {
  description = "The name of the SSL certificate"
  value       = heroku_cert.cert.*.name
}
