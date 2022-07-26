#-----------------------------------------------------------
# Azure storage account
#-----------------------------------------------------------
output "storage_account_id" {
  description = "The ID of the Storage Account."
  value       = element(concat(azurerm_storage_account.storage_account.*.id, [""]), 0)
}

output "storage_account_name" {
  description = "The name of the Storage Account."
  value       = element(concat(azurerm_storage_account.storage_account.*.name, [""]), 0)
}

output "storage_account_primary_location" {
  description = "The primary location of the storage account."
  value       = element(concat(azurerm_storage_account.storage_account.*.primary_location, [""]), 0)
}

output "storage_account_secondary_location" {
  description = "The secondary location of the storage account."
  value       = element(concat(azurerm_storage_account.storage_account.*.secondary_location, [""]), 0)
}

output "storage_account_primary_blob_endpoint" {
  description = "The endpoint URL for blob storage in the primary location."
  value       = element(concat(azurerm_storage_account.storage_account.*.primary_blob_endpoint, [""]), 0)
}

output "storage_account_primary_blob_host" {
  description = "The hostname with port if applicable for blob storage in the primary location."
  value       = element(concat(azurerm_storage_account.storage_account.*.primary_blob_host, [""]), 0)
}

output "storage_account_secondary_blob_endpoint" {
  description = "The endpoint URL for blob storage in the secondary location."
  value       = element(concat(azurerm_storage_account.storage_account.*.secondary_blob_endpoint, [""]), 0)
}

output "storage_account_secondary_blob_host" {
  description = "The hostname with port if applicable for blob storage in the secondary location."
  value       = element(concat(azurerm_storage_account.storage_account.*.secondary_blob_host, [""]), 0)
}

output "storage_account_primary_queue_endpoint" {
  description = "The endpoint URL for queue storage in the primary location."
  value       = element(concat(azurerm_storage_account.storage_account.*.primary_queue_endpoint, [""]), 0)
}

output "storage_account_primary_queue_host" {
  description = "The hostname with port if applicable for queue storage in the primary location."
  value       = element(concat(azurerm_storage_account.storage_account.*.primary_queue_host, [""]), 0)
}

output "storage_account_secondary_queue_endpoint" {
  description = "The endpoint URL for queue storage in the secondary location."
  value       = element(concat(azurerm_storage_account.storage_account.*.secondary_queue_endpoint, [""]), 0)
}

output "storage_account_secondary_queue_host" {
  description = "The hostname with port if applicable for queue storage in the secondary location."
  value       = element(concat(azurerm_storage_account.storage_account.*.secondary_queue_host, [""]), 0)
}

output "storage_account_primary_table_endpoint" {
  description = "The endpoint URL for table storage in the primary location."
  value       = element(concat(azurerm_storage_account.storage_account.*.primary_table_endpoint, [""]), 0)
}

output "storage_account_primary_table_host" {
  description = "The hostname with port if applicable for table storage in the primary location."
  value       = element(concat(azurerm_storage_account.storage_account.*.primary_table_host, [""]), 0)
}

output "storage_account_secondary_table_endpoint" {
  description = "The endpoint URL for table storage in the secondary location."
  value       = element(concat(azurerm_storage_account.storage_account.*.secondary_table_endpoint, [""]), 0)
}

output "storage_account_secondary_table_host" {
  description = "The hostname with port if applicable for table storage in the secondary location."
  value       = element(concat(azurerm_storage_account.storage_account.*.secondary_table_host, [""]), 0)
}

output "storage_account_primary_file_endpoint" {
  description = "The endpoint URL for file storage in the primary location."
  value       = element(concat(azurerm_storage_account.storage_account.*.primary_file_endpoint, [""]), 0)
}

output "storage_account_primary_file_host" {
  description = "The hostname with port if applicable for file storage in the primary location."
  value       = element(concat(azurerm_storage_account.storage_account.*.primary_file_host, [""]), 0)
}

output "storage_account_secondary_file_endpoint" {
  description = "The endpoint URL for file storage in the secondary location."
  value       = element(concat(azurerm_storage_account.storage_account.*.secondary_file_endpoint, [""]), 0)
}

output "storage_account_secondary_file_host" {
  description = "The hostname with port if applicable for file storage in the secondary location."
  value       = element(concat(azurerm_storage_account.storage_account.*.secondary_file_host, [""]), 0)
}

output "storage_account_primary_dfs_endpoint" {
  description = "The endpoint URL for DFS storage in the primary location."
  value       = element(concat(azurerm_storage_account.storage_account.*.primary_dfs_endpoint, [""]), 0)
}

output "storage_account_primary_dfs_host" {
  description = "The hostname with port if applicable for DFS storage in the primary location."
  value       = element(concat(azurerm_storage_account.storage_account.*.primary_dfs_host, [""]), 0)
}

output "storage_account_secondary_dfs_endpoint" {
  description = "The endpoint URL for DFS storage in the secondary location."
  value       = element(concat(azurerm_storage_account.storage_account.*.secondary_dfs_endpoint, [""]), 0)
}

output "storage_account_secondary_dfs_host" {
  description = "The hostname with port if applicable for DFS storage in the secondary location."
  value       = element(concat(azurerm_storage_account.storage_account.*.secondary_dfs_host, [""]), 0)
}

output "storage_account_primary_web_endpoint" {
  description = "The endpoint URL for web storage in the primary location."
  value       = element(concat(azurerm_storage_account.storage_account.*.primary_web_endpoint, [""]), 0)
}

output "storage_account_primary_web_host" {
  description = "The hostname with port if applicable for web storage in the primary location."
  value       = element(concat(azurerm_storage_account.storage_account.*.primary_web_host, [""]), 0)
}

output "storage_account_secondary_web_endpoint" {
  description = "The endpoint URL for web storage in the secondary location."
  value       = element(concat(azurerm_storage_account.storage_account.*.secondary_web_endpoint, [""]), 0)
}

output "storage_account_secondary_web_host" {
  description = "The hostname with port if applicable for web storage in the secondary location."
  value       = element(concat(azurerm_storage_account.storage_account.*.secondary_web_host, [""]), 0)
}

output "storage_account_primary_access_key" {
  description = "The primary access key for the storage account."
  value       = element(concat(azurerm_storage_account.storage_account.*.primary_access_key, [""]), 0)
}

output "storage_account_secondary_access_key" {
  description = "The secondary access key for the storage account."
  value       = element(concat(azurerm_storage_account.storage_account.*.secondary_access_key, [""]), 0)
}

output "storage_account_primary_connection_string" {
  description = "The connection string associated with the primary location."
  value       = element(concat(azurerm_storage_account.storage_account.*.primary_connection_string, [""]), 0)
}

output "storage_account_secondary_connection_string" {
  description = "The connection string associated with the secondary location."
  value       = element(concat(azurerm_storage_account.storage_account.*.secondary_connection_string, [""]), 0)
}

output "storage_account_primary_blob_connection_string" {
  description = "The connection string associated with the primary blob location."
  value       = element(concat(azurerm_storage_account.storage_account.*.primary_blob_connection_string, [""]), 0)
}

output "storage_account_secondary_blob_connection_string" {
  description = "The connection string associated with the secondary blob location."
  value       = element(concat(azurerm_storage_account.storage_account.*.id, [""]), 0)
}

#-----------------------------------------------------------
# Azure storage account network rules
#-----------------------------------------------------------
output "storage_account_network_rules_id" {
  description = "The ID of the Storage Account."
  value       = element(concat(azurerm_storage_account_network_rules.storage_account_network_rules.*.id, [""]), 0)
}

#-----------------------------------------------------------
# Azure storage account customer managed key
#-----------------------------------------------------------
output "storage_account_customer_managed_key_id" {
  description = "The ID of the Storage Account."
  value       = element(concat(azurerm_storage_account_customer_managed_key.storage_account_customer_managed_key.*.id, [""]), 0)
}

#-----------------------------------------------------------
# Azure storage container
#-----------------------------------------------------------
output "storage_container_id" {
  description = "The ID of the Storage Container."
  value       = element(concat(azurerm_storage_container.storage_container.*.id, [""]), 0)
}

output "storage_container_has_immutability_policy" {
  description = "Is there an Immutability Policy configured on this Storage Container?"
  value       = element(concat(azurerm_storage_container.storage_container.*.has_immutability_policy, [""]), 0)
}

output "storage_container_has_legal_hold" {
  description = "Is there a Legal Hold configured on this Storage Container?"
  value       = element(concat(azurerm_storage_container.storage_container.*.has_legal_hold, [""]), 0)
}

output "storage_container_resource_manager_id" {
  description = "The Resource Manager ID of this Storage Container."
  value       = element(concat(azurerm_storage_container.storage_container.*.resource_manager_id, [""]), 0)
}

#-----------------------------------------------------------
# Azure storage blob
#-----------------------------------------------------------
output "storage_blob_id" {
  description = "The ID of the Storage Blob."
  value       = element(concat(azurerm_storage_blob.storage_blob.*.id, [""]), 0)
}

output "storage_blob_url" {
  description = "The URL of the blob"
  value       = element(concat(azurerm_storage_blob.storage_blob.*.url, [""]), 0)
}

#-----------------------------------------------------------
# Azure storage blob inventory policy
#-----------------------------------------------------------
output "storage_blob_inventory_policy_id" {
  description = "The ID of the Storage Blob Inventory Policy."
  value       = element(concat(azurerm_storage_blob_inventory_policy.storage_blob_inventory_policy.*.id, [""]), 0)
}