#-----------------------------------------------------------
# Azure active directory domain service
#-----------------------------------------------------------
output "active_directory_domain_service_id" {
  description = "The ID of the Domain Service."
  value       = element(concat(azurerm_active_directory_domain_service.active_directory_domain_service.*.id, [""]), 0)
}

output "active_directory_domain_service_deployment_id" {
  description = "A unique ID for the managed domain deployment."
  value       = element(concat(azurerm_active_directory_domain_service.active_directory_domain_service.*.deployment_id, [""]), 0)
}

output "active_directory_domain_service_resource_id" {
  description = "The Azure resource ID for the domain service."
  value       = element(concat(azurerm_active_directory_domain_service.active_directory_domain_service.*.resource_id, [""]), 0)
}

#-----------------------------------------------------------
# Azure active directory domain service replica set
#-----------------------------------------------------------
output "active_directory_domain_service_replica_set_id" {
  description = "The ID of the Domain Service Replica Set."
  value       = element(concat(azurerm_active_directory_domain_service_replica_set.active_directory_domain_service_replica_set.*.id, [""]), 0)
}

output "active_directory_domain_service_replica_set_domain_controller_ip_addresses" {
  description = "A list of subnet IP addresses for the domain controllers in this Replica Set, typically two."
  value       = azurerm_active_directory_domain_service_replica_set.active_directory_domain_service_replica_set.*.domain_controller_ip_addresses
}

output "active_directory_domain_service_replica_set_external_access_ip_address" {
  description = "The publicly routable IP address for the domain controllers in this Replica Set."
  value       = element(concat(azurerm_active_directory_domain_service_replica_set.active_directory_domain_service_replica_set.*.external_access_ip_address, [""]), 0)
}

output "active_directory_domain_service_replica_set_service_status" {
  description = "The current service status for the replica set."
  value       = element(concat(azurerm_active_directory_domain_service_replica_set.active_directory_domain_service_replica_set.*.service_status, [""]), 0)
}
