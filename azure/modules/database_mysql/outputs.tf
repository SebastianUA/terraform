#-----------------------------------------------------------
# Azure mysql active directory administrator
#-----------------------------------------------------------
output "mysql_active_directory_administrator_id" {
  description = "The ID of the MySQL Active Directory Administrator."
  value       = element(concat(azurerm_mysql_active_directory_administrator.mysql_active_directory_administrator.*.id, [""]), 0)
}

#-----------------------------------------------------------
# Azure mysql configuration
#-----------------------------------------------------------
output "mysql_configuration_id" {
  description = "The ID of the MySQL Configuration."
  value       = element(concat(azurerm_mysql_configuration.mysql_configuration.*.id, [""]), 0)
}