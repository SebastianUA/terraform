#-----------------------------------------------------------
# Azure private dns zone
#-----------------------------------------------------------
output "private_dns_zone_id" {
  description = "The Private DNS Zone ID."
  value       = element(concat(azurerm_private_dns_zone.private_dns_zone.*.id, [""]), 0)
}

output "private_dns_zone_soa_record" {
  description = "A soa_record block."
  value       = azurerm_private_dns_zone.private_dns_zone.*.soa_record
}

output "private_dns_zone_number_of_record_sets" {
  description = "The current number of record sets in this Private DNS zone."
  value       = element(concat(azurerm_private_dns_zone.private_dns_zone.*.number_of_record_sets, [""]), 0)
}

output "private_dns_zone_max_number_of_record_sets" {
  description = "The maximum number of record sets that can be created in this Private DNS zone."
  value       = azurerm_private_dns_zone.private_dns_zone.*.max_number_of_record_sets
}

output "private_dns_zone_max_number_of_virtual_network_links" {
  description = "The maximum number of virtual networks that can be linked to this Private DNS zone."
  value       = element(concat(azurerm_private_dns_zone.private_dns_zone.*.max_number_of_virtual_network_links, [""]), 0)
}

output "private_dns_zone_max_number_of_virtual_network_links_with_registration" {
  description = "The maximum number of virtual networks that can be linked to this Private DNS zone with registration enabled."
  value       = element(concat(azurerm_private_dns_zone.private_dns_zone.*.max_number_of_virtual_network_links_with_registration, [""]), 0)
}

#-----------------------------------------------------------
# Azure private dns txt record
#-----------------------------------------------------------
output "private_dns_txt_record_id" {
  description = "The DNS TXT Record ID."
  value       = element(concat(azurerm_private_dns_txt_record.private_dns_txt_record.*.id, [""]), 0)
}

output "private_dns_txt_record_fqdn" {
  description = "The FQDN of the DNS TXT Record."
  value       = element(concat(azurerm_private_dns_txt_record.private_dns_txt_record.*.fqdn, [""]), 0)
}

#-----------------------------------------------------------
# Azure private dns srv record
#-----------------------------------------------------------
output "private_dns_srv_record_id" {
  description = "The DNS SRV Record ID."
  value       = element(concat(azurerm_private_dns_srv_record.private_dns_srv_record.*.id, [""]), 0)
}

output "private_dns_srv_record_fqdn" {
  description = "The FQDN of the DNS SRV Record."
  value       = element(concat(azurerm_private_dns_srv_record.private_dns_srv_record.*.fqdn, [""]), 0)
}

#-----------------------------------------------------------
# Azure private dns ptr record
#-----------------------------------------------------------
output "private_dns_ptr_record_id" {
  description = "The DNS PTR Record ID."
  value       = element(concat(azurerm_private_dns_ptr_record.private_dns_ptr_record.*.id, [""]), 0)
}

output "private_dns_ptr_record_fqdn" {
  description = "The FQDN of the DNS PTR Record."
  value       = element(concat(azurerm_private_dns_ptr_record.private_dns_ptr_record.*.fqdn, [""]), 0)
}

#-----------------------------------------------------------
# Azure private dns mx record
#-----------------------------------------------------------
output "private_dns_mx_record_id" {
  description = "The DNS MX Record ID."
  value       = element(concat(azurerm_private_dns_mx_record.private_dns_mx_record.*.id, [""]), 0)
}

output "private_dns_mx_record_fqdn" {
  description = "The FQDN of the DNS MX Record."
  value       = element(concat(azurerm_private_dns_mx_record.private_dns_mx_record.*.fqdn, [""]), 0)
}

#-----------------------------------------------------------
# Azure private dns cname record
#-----------------------------------------------------------
output "private_dns_cname_record_id" {
  description = "The DNS CName Record ID."
  value       = element(concat(azurerm_private_dns_cname_record.private_dns_cname_record.*.id, [""]), 0)
}

output "private_dns_cname_record_fqdn" {
  description = "The FQDN of the DNS CName Record."
  value       = element(concat(azurerm_private_dns_cname_record.private_dns_cname_record.*.fqdn, [""]), 0)
}

#-----------------------------------------------------------
# Azure private dns aaaa record
#-----------------------------------------------------------
output "private_dns_aaaa_record_id" {
  description = "The DNS AAAA Record ID."
  value       = element(concat(azurerm_private_dns_aaaa_record.private_dns_aaaa_record.*.id, [""]), 0)
}

output "private_dns_aaaa_record_fqdn" {
  description = "The FQDN of the DNS AAAA Record."
  value       = element(concat(azurerm_private_dns_aaaa_record.private_dns_aaaa_record.*.fqdn, [""]), 0)
}

#-----------------------------------------------------------
# Azure private dns a record
#-----------------------------------------------------------
output "private_dns_a_record_id" {
  description = "The DNS A Record ID."
  value       = element(concat(azurerm_private_dns_a_record.private_dns_a_record.*.id, [""]), 0)
}

output "private_dns_a_record_fqdn" {
  description = "The FQDN of the DNS A Record."
  value       = element(concat(azurerm_private_dns_a_record.private_dns_a_record.*.fqdn, [""]), 0)
}

#-----------------------------------------------------------
# Azure private dns zone virtual network link
#-----------------------------------------------------------
output "private_dns_zone_virtual_network_link_id" {
  description = "The ID of the Private DNS Zone Virtual Network Link."
  value       = element(concat(azurerm_private_dns_zone_virtual_network_link.private_dns_zone_virtual_network_link.*.id, [""]), 0)
}
