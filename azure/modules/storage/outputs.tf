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

#-----------------------------------------------------------
# Azure storage data lake gen2 filesystem
#-----------------------------------------------------------
output "storage_data_lake_gen2_filesystem_id" {
  description = "The ID of the Data Lake Gen2 File System."
  value       = element(concat(azurerm_storage_data_lake_gen2_filesystem.storage_data_lake_gen2_filesystem.*.id, [""]), 0)
}

output "storage_data_lake_gen2_filesystem_name" {
  description = "The name of the Data Lake Gen2 File System."
  value       = element(concat(azurerm_storage_data_lake_gen2_filesystem.storage_data_lake_gen2_filesystem.*.name, [""]), 0)
}

#-----------------------------------------------------------
# Azure storage data lake gen2 path
#-----------------------------------------------------------
output "storage_data_lake_gen2_path_id" {
  description = "The ID of the Data Lake Gen2 File System."
  value       = element(concat(azurerm_storage_data_lake_gen2_path.storage_data_lake_gen2_path.*.id, [""]), 0)
}

#-----------------------------------------------------------
# Azure storage encryption scope
#-----------------------------------------------------------
output "storage_encryption_scope_id" {
  description = "The ID of the Storage Encryption Scope."
  value       = element(concat(azurerm_storage_encryption_scope.storage_encryption_scope.*.id, [""]), 0)
}

#-----------------------------------------------------------
# Azure storage queue
#-----------------------------------------------------------
output "storage_queue_id" {
  description = "The ID of the Storage Queue."
  value       = element(concat(azurerm_storage_queue.storage_queue.*.id, [""]), 0)
}

#-----------------------------------------------------------
# Azure storage object replication
#-----------------------------------------------------------
output "storage_object_replication_id" {
  description = "The ID of the Storage Object Replication in the destination storage account. It's composed as format source_object_replication_id;destination_object_replication_id."
  value       = element(concat(azurerm_storage_object_replication.storage_object_replication.*.id, [""]), 0)
}

output "storage_object_replication_source_object_replication_id" {
  description = "The ID of the Object Replication in the source storage account."
  value       = element(concat(azurerm_storage_object_replication.storage_object_replication.*.source_object_replication_id, [""]), 0)
}

output "storage_object_replication_destination_object_replication_id" {
  description = "The ID of the Object Replication in the destination storage account."
  value       = element(concat(azurerm_storage_object_replication.storage_object_replication.*.destination_object_replication_id, [""]), 0)
}

#-----------------------------------------------------------
# Azure storage management policy
#-----------------------------------------------------------
output "storage_management_policy_id" {
  description = "The ID of the Storage Account Management Policy."
  value       = element(concat(azurerm_storage_management_policy.storage_management_policy.*.id, [""]), 0)
}

#-----------------------------------------------------------
# Azure storage table
#-----------------------------------------------------------
output "storage_table_id" {
  description = "The ID of the Table within the Storage Account."
  value       = element(concat(azurerm_storage_table.storage_table.*.id, [""]), 0)
}

output "storage_table_name" {
  description = "The name of the Table within the Storage Account."
  value       = element(concat(azurerm_storage_table.storage_table.*.name, [""]), 0)
}

#-----------------------------------------------------------
# Azure storage table entity
#-----------------------------------------------------------
output "storage_table_entity_id" {
  description = "The ID of the Entity within the Table in the Storage Account."
  value       = element(concat(azurerm_storage_table_entity.storage_table_entity.*.id, [""]), 0)
}

#-----------------------------------------------------------
# Azure storage share
#-----------------------------------------------------------
output "storage_share_id" {
  description = "The ID of the File Share."
  value       = element(concat(azurerm_storage_share.storage_share.*.id, [""]), 0)
}

output "storage_share_resource_manager_id" {
  description = "The Resource Manager ID of this File Share."
  value       = element(concat(azurerm_storage_share.storage_share.*.resource_manager_id, [""]), 0)
}

output "storage_share_url" {
  description = "The URL of the File Share"
  value       = element(concat(azurerm_storage_share.storage_share.*.url, [""]), 0)
}

#-----------------------------------------------------------
# Azure storage share file
#-----------------------------------------------------------
output "storage_share_file_id" {
  description = "The ID of the File Share."
  value       = element(concat(azurerm_storage_share_file.storage_share_file.*.id, [""]), 0)
}

output "storage_share_file_resource_manager_id" {
  description = "The Resource Manager ID of this File Share."
  value       = element(concat(azurerm_storage_share_file.storage_share_file.*.resource_manager_id, [""]), 0)
}

output "storage_share_file_url" {
  description = "The URL of the File Share"
  value       = element(concat(azurerm_storage_share_file.storage_share_file.*.iurld, [""]), 0)
}

#-----------------------------------------------------------
# Azure storage share directory
#-----------------------------------------------------------
output "storage_share_directory_id" {
  description = "The ID of the Directory within the File Share."
  value       = element(concat(azurerm_storage_share_directory.storage_share_directory.*.id, [""]), 0)
}

#-----------------------------------------------------------
# Azure storage sync
#-----------------------------------------------------------
output "storage_sync_id" {
  description = "The ID of the Storage Sync."
  value       = element(concat(azurerm_storage_sync.storage_sync.*.id, [""]), 0)
}

#-----------------------------------------------------------
# Azure storage sync group
#-----------------------------------------------------------
output "storage_sync_group_id" {
  description = "The ID of the Storage Sync Group."
  value       = element(concat(azurerm_storage_sync_group.storage_sync_group.*.id, [""]), 0)
}

#-----------------------------------------------------------
# Azure storage sync cloud endpoint
#-----------------------------------------------------------
output "storage_sync_cloud_endpoint_id" {
  description = "The ID of the Storage Sync Cloud Endpoint."
  value       = element(concat(azurerm_storage_sync_cloud_endpoint.storage_sync_cloud_endpoint.*.id, [""]), 0)
}
