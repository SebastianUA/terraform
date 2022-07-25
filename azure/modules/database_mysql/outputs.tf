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

#-----------------------------------------------------------
# Azure mysql server
#-----------------------------------------------------------
output "mysql_server_id" {
  description = "The ID of the MySQL Server."
  value       = element(concat(azurerm_mysql_server.mysql_server.*.id, [""]), 0)
}

output "mysql_server_name" {
  description = "The name of the MySQL Server."
  value       = element(concat(azurerm_mysql_server.mysql_server.*.name, [""]), 0)
}

output "mysql_server_fqdn" {
  description = "The FQDN of the MySQL Server."
  value       = element(concat(azurerm_mysql_server.mysql_server.*.fqdn, [""]), 0)
}

output "mysql_server_identity" {
  description = "The identity (principal_id, tenant_id) of the MySQL Server."
  value       = concat(azurerm_mysql_server.mysql_server.*.identity, [""])
}

#-----------------------------------------------------------
# Azure mysql server key
#-----------------------------------------------------------
output "mysql_server_key_id" {
  description = "The ID of the MySQL Server Key."
  value       = element(concat(azurerm_mysql_server_key.mysql_server_key.*.id, [""]), 0)
}

#-----------------------------------------------------------
# Azure mysql database
#-----------------------------------------------------------
output "mysql_database_id" {
  description = "The ID of the MySQL Database."
  value       = element(concat(azurerm_mysql_database.mysql_database.*.id, [""]), 0)
}

#-----------------------------------------------------------
# Azure mysql virtual network rule
#-----------------------------------------------------------
output "mysql_virtual_network_rule_id" {
  description = "The ID of the MySQL Virtual Network Rule."
  value       = element(concat(azurerm_mysql_virtual_network_rule.mysql_virtual_network_rule.*.id, [""]), 0)
}

#-----------------------------------------------------------
# Azure mysql firewall rule
#-----------------------------------------------------------
output "mysql_firewall_rule_id" {
  description = "The ID of the MySQL Firewall Rule."
  value       = element(concat(azurerm_mysql_firewall_rule.mysql_firewall_rule.*.id, [""]), 0)
}

#-----------------------------------------------------------
# Azure mysql flexible server
#-----------------------------------------------------------

output "mysql_flexible_server_id" {
  description = "The ID of the MySQL Flexible Server."
  value       = element(concat(azurerm_mysql_flexible_server.mysql_flexible_server.*.id, [""]), 0)
}

output "mysql_flexible_server_name" {
  description = "The name of the flexible MySQL Server."
  value       = element(concat(azurerm_mysql_flexible_server.mysql_flexible_server.*.name, [""]), 0)
}

output "mysql_flexible_server_fqdn" {
  description = "The fully qualified domain name of the MySQL Flexible Server."
  value       = element(concat(azurerm_mysql_flexible_server.mysql_flexible_server.*.fqdn, [""]), 0)
}

output "mysql_flexible_server_public_network_access_enabled" {
  description = "Is the public network access enabled?"
  value       = concat(azurerm_mysql_flexible_server.mysql_flexible_server.*.public_network_access_enabled, [""])
}

output "mysql_flexible_server_replica_capacity" {
  description = "The maximum number of replicas that a primary MySQL Flexible Server can have."
  value       = concat(azurerm_mysql_flexible_server.mysql_flexible_server.*.replica_capacity, [""])
}

#-----------------------------------------------------------
# Azure mysql flexible server firewall rule
#-----------------------------------------------------------
output "mysql_flexible_server_firewall_rule_id" {
  description = "The ID of the MySQL Firewall Rule."
  value       = element(concat(azurerm_mysql_flexible_server_firewall_rule.mysql_flexible_server_firewall_rule.*.id, [""]), 0)
}

#-----------------------------------------------------------
# Azure mysql flexible server configuration
#-----------------------------------------------------------
output "mysql_flexible_server_configuration_id" {
  description = "The ID of the MySQL Flexible Server Configuration."
  value       = element(concat(azurerm_mysql_flexible_server_configuration.mysql_flexible_server_configuration.*.id, [""]), 0)
}

#-----------------------------------------------------------
# Azure mysql flexible database
#-----------------------------------------------------------
output "mysql_flexible_database_id" {
  description = "The ID of the MySQL Database."
  value       = element(concat(azurerm_mysql_flexible_database.mysql_flexible_database.*.id, [""]), 0)
}