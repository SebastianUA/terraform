#-----------------------------------------------------------
# Azure database migration service
#-----------------------------------------------------------
output "database_migration_service_id" {
  description = "The ID of Database Migration Service."
  value       = element(concat(azurerm_database_migration_service.database_migration_service.*.id, [""]), 0)
}

output "database_migration_service_name" {
  description = "The name of Database Migration Service."
  value       = element(concat(azurerm_database_migration_service.database_migration_service.*.name, [""]), 0)
}

#-----------------------------------------------------------
# Azure database migration project
#-----------------------------------------------------------
output "database_migration_project_id" {
  description = "The ID of Database Migration Project."
  value       = element(concat(azurerm_database_migration_project.database_migration_project.*.id, [""]), 0)
}