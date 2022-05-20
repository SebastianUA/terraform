#-----------------------------------------------------------
# Azure container group
#-----------------------------------------------------------
output "container_group_id" {
  description = "The ID of the Container Group."
  value       = element(concat(azurerm_container_group.container_group.*.id, [""]), 0)
}

output "container_group_identity" {
  description = "An identity block"
  value       = concat(azurerm_container_group.container_group.*.identity, [""])
}

output "container_group_ip_address" {
  description = "The IP address allocated to the container group."
  value       = element(concat(azurerm_container_group.container_group.*.ip_address, [""]), 0)
}

output "container_group_fqdn" {
  description = "The FQDN of the container group derived from dns_name_label."
  value       = element(concat(azurerm_container_group.container_group.*.fqdn, [""]), 0)
}

#-----------------------------------------------------------
# Azure container registry
#-----------------------------------------------------------
output "container_registry_id" {
  description = "The ID of the Container Registry."
  value       = element(concat(azurerm_container_registry.container_registry.*.id, [""]), 0)
}

output "container_registry_name" {
  description = "The name of the Container Registry."
  value       = element(concat(azurerm_container_registry.container_registry.*.name, [""]), 0)
}

output "container_registry_login_server" {
  description = "The URL that can be used to log into the container registry."
  value       = element(concat(azurerm_container_registry.container_registry.*.login_server, [""]), 0)
}

output "container_registry_admin_username" {
  description = "The Username associated with the Container Registry Admin account - if the admin account is enabled."
  value       = element(concat(azurerm_container_registry.container_registry.*.admin_username, [""]), 0)
}

output "container_registry_admin_password" {
  description = "The Password associated with the Container Registry Admin account - if the admin account is enabled."
  value       = element(concat(azurerm_container_registry.container_registry.*.admin_password, [""]), 0)
}

output "container_registry_identity" {
  description = "An identity block as defined"
  value       = concat(azurerm_container_registry.container_registry.*.identity, [""])
}

#-----------------------------------------------------------
# Azure container registry webhook
#-----------------------------------------------------------
output "container_registry_webhook_id" {
  description = "The ID of the Container Registry Webhook."
  value       = element(concat(azurerm_container_registry_webhook.container_registry_webhook.*.id, [""]), 0)
}

#-----------------------------------------------------------
# Azure container registry scope map
#-----------------------------------------------------------
output "container_registry_scope_map_id" {
  description = "The ID of the Container Registry scope map."
  value       = element(concat(azurerm_container_registry_scope_map.container_registry_scope_map.*.id, [""]), 0)
}

#-----------------------------------------------------------
# Azure container registry agent pool
#-----------------------------------------------------------
output "container_registry_agent_pool_id" {
  description = "The ID of the Container Registry scope map."
  value       = element(concat(azurerm_container_registry_agent_pool.container_registry_agent_pool.*.id, [""]), 0)
}

#-----------------------------------------------------------
# Azure container registry task
#-----------------------------------------------------------
output "container_registry_task_id" {
  description = "The ID of the Container Registry Task."
  value       = element(concat(azurerm_container_registry_task.container_registry_task.*.id, [""]), 0)
}

output "container_registry_task_identity" {
  description = "An identity block"
  value       = concat(azurerm_container_registry_task.container_registry_task.*.identity, [""])
}

#-----------------------------------------------------------
# Azure container registry token
#-----------------------------------------------------------
output "container_registry_token_id" {
  description = "The ID of the Container Registry token."
  value       = element(concat(azurerm_container_registry_token.container_registry_token.*.id, [""]), 0)
}