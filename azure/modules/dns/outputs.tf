#-----------------------------------------------------------
# Azure dns zone
#-----------------------------------------------------------
output "dns_zone_id" {
  description = "The DNS Zone ID."
  value       = element(concat(azurerm_dns_zone.dns_zone.*.id, [""]), 0)
}

output "dns_zone_max_number_of_record_sets" {
  description = "(Optional) Maximum number of Records in the zone. Defaults to 1000."
  value       = element(concat(azurerm_dns_zone.dns_zone.*.max_number_of_record_sets, [""]), 0)
}

output "dns_zone_number_of_record_sets" {
  description = "(Optional) The number of records already in the zone."
  value       = element(concat(azurerm_dns_zone.dns_zone.*.number_of_record_sets, [""]), 0)
}

output "dns_zone_name_servers" {
  description = "(Optional) A list of values that make up the NS record for the zone."
  value       = azurerm_dns_zone.dns_zone.*.name_servers
}

#-----------------------------------------------------------
# Azure dns txt record
#-----------------------------------------------------------
output "dns_txt_record_id" {
  description = "The DNS TXT Record ID."
  value       = element(concat(azurerm_dns_txt_record.dns_txt_record.*.id, [""]), 0)
}

output "dns_txt_record_fqdn" {
  description = "The FQDN of the DNS TXT Record."
  value       = element(concat(azurerm_dns_txt_record.dns_txt_record.*.fqdn, [""]), 0)
}

#-----------------------------------------------------------
# Azure dns srv record
#-----------------------------------------------------------
output "dns_srv_record_id" {
  description = "The DNS SRV Record ID."
  value       = element(concat(azurerm_dns_srv_record.dns_srv_record.*.id, [""]), 0)
}

output "dns_srv_record_fqdn" {
  description = "The FQDN of the DNS SRV Record."
  value       = element(concat(azurerm_dns_srv_record.dns_srv_record.*.fqdn, [""]), 0)
}

#-----------------------------------------------------------
# Azure dns ptr record
#-----------------------------------------------------------
output "dns_ptr_record_id" {
  description = "The DNS PTR Record ID."
  value       = element(concat(azurerm_dns_ptr_record.dns_ptr_record.*.id, [""]), 0)
}

output "dns_ptr_record_fqdn" {
  description = "The FQDN of the DNS PTR Record."
  value       = element(concat(azurerm_dns_ptr_record.dns_ptr_record.*.fqdn, [""]), 0)
}

#-----------------------------------------------------------
# Azure dns ns record
#-----------------------------------------------------------
output "dns_ns_record_id" {
  description = "The DNS NS Record ID."
  value       = element(concat(azurerm_dns_ns_record.dns_ns_record.*.id, [""]), 0)
}

output "dns_ns_record_fqdn" {
  description = "The FQDN of the DNS NS Record."
  value       = element(concat(azurerm_dns_ns_record.dns_ns_record.*.fqdn, [""]), 0)
}

#-----------------------------------------------------------
# Azure dns mx record
#-----------------------------------------------------------
output "dns_mx_record_id" {
  description = "The DNS MX Record ID."
  value       = element(concat(azurerm_dns_mx_record.dns_mx_record.*.id, [""]), 0)
}

output "dns_mx_record_fqdn" {
  description = "The FQDN of the DNS MX Record."
  value       = element(concat(azurerm_dns_mx_record.dns_mx_record.*.fqdn, [""]), 0)
}

#-----------------------------------------------------------
# Azure dns cname record
#-----------------------------------------------------------
output "dns_cname_record_id" {
  description = "The DNS CName Record ID."
  value       = element(concat(azurerm_dns_cname_record.dns_cname_record.*.id, [""]), 0)
}

output "dns_cname_record_fqdn" {
  description = "The FQDN of the DNS CName Record."
  value       = element(concat(azurerm_dns_cname_record.dns_cname_record.*.fqdn, [""]), 0)
}

#-----------------------------------------------------------
# Azure dns caa record
#-----------------------------------------------------------
output "dns_caa_record_id" {
  description = "The DNS CAA Record ID."
  value       = element(concat(azurerm_dns_caa_record.dns_caa_record.*.id, [""]), 0)
}

output "dns_caa_record_fqdn" {
  description = "The FQDN of the DNS CAA Record."
  value       = element(concat(azurerm_dns_caa_record.dns_caa_record.*.fqdn, [""]), 0)
}

#-----------------------------------------------------------
# Azure dns aaaa record
#-----------------------------------------------------------
output "dns_aaaa_record_id" {
  description = "The DNS AAAA Record ID."
  value       = element(concat(azurerm_dns_aaaa_record.dns_aaaa_record.*.id, [""]), 0)
}

output "dns_aaaa_record_fqdn" {
  description = "The FQDN of the DNS AAAA Record."
  value       = element(concat(azurerm_dns_aaaa_record.dns_aaaa_record.*.fqdn, [""]), 0)
}

#-----------------------------------------------------------
# Azure dns a record
#-----------------------------------------------------------
output "dns_a_record_id" {
  description = "The DNS A Record ID."
  value       = element(concat(azurerm_dns_a_record.dns_a_record.*.id, [""]), 0)
}

output "dns_a_record_fqdn" {
  description = "The FQDN of the DNS A Record."
  value       = element(concat(azurerm_dns_a_record.dns_a_record.*.fqdn, [""]), 0)
}