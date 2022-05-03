#-----------------------------------------------------------
# Azure cdn profile
#-----------------------------------------------------------
output "cdn_profile_id" {
  description = "The ID of the CDN Profile."
  value       = element(concat(azurerm_cdn_profile.cdn_profile.*.id, [""]), 0)
}

output "cdn_profile_name" {
  description = "The name of the CDN Profile."
  value       = element(concat(azurerm_cdn_profile.cdn_profile.*.name, [""]), 0)
}

#-----------------------------------------------------------
# Azure cdn endpoint
#-----------------------------------------------------------
output "cdn_endpoint_id" {
  description = "The ID of the CDN Endpoint."
  value       = element(concat(azurerm_cdn_endpoint.cdn_endpoint.*.id, [""]), 0)
}

output "cdn_endpoint_name" {
  description = "The name of the CDN Endpoint."
  value       = element(concat(azurerm_cdn_endpoint.cdn_endpoint.*.name, [""]), 0)
}

output "cdn_endpoint_fqdn" {
  description = "The Fully Qualified Domain Name of the CDN Endpoint."
  value       = element(concat(azurerm_cdn_endpoint.cdn_endpoint.*.fqdn, [""]), 0)
}

#-----------------------------------------------------------
# Azure cdn endpoint custom domain
#-----------------------------------------------------------
output "cdn_endpoint_custom_domain_id" {
  description = "The ID of the CDN Endpoint Custom Domain."
  value       = element(concat(azurerm_cdn_endpoint_custom_domain.cdn_endpoint_custom_domain.*.id, [""]), 0)
}
