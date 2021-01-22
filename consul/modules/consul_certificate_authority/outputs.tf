#---------------------------------------------------
# Consul certificate authority
#---------------------------------------------------
output "consul_certificate_authority_id" {
  description = "ID of Counsul certificate authority"
  value       = element(concat(consul_certificate_authority.certificate_authority.*.id, [""]), 0)
}

output "consul_certificate_authority_connect_provider" {
  description = "Specifies the CA provider type to use."
  value       = element(concat(consul_certificate_authority.certificate_authority.*.connect_provider, [""]), 0)
}

output "consul_certificate_authority_config" {
  description = "The raw configuration to use for the chosen provider."
  value       = element(concat(consul_certificate_authority.certificate_authority.*.config, [""]), 0)
}
