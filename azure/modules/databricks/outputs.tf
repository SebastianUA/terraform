#-----------------------------------------------------------
# Azure databricks workspace
#-----------------------------------------------------------
output "databricks_workspace_id" {
  description = "The ID of the Databricks Workspace in the Azure management plane."
  value       = element(concat(azurerm_databricks_workspace.databricks_workspace.*.id, [""]), 0)
}

output "databricks_workspace_managed_resource_group_id" {
  description = "The ID of the Managed Resource Group created by the Databricks Workspace."
  value       = element(concat(azurerm_databricks_workspace.databricks_workspace.*.managed_resource_group_id, [""]), 0)
}

output "databricks_workspace_workspace_url" {
  description = "The workspace URL which is of the format 'adb-{workspaceId}.{random}.azuredatabricks.net'"
  value       = element(concat(azurerm_databricks_workspace.databricks_workspace.*.workspace_url, [""]), 0)
}

output "databricks_workspace_workspace_id" {
  description = "The unique identifier of the databricks workspace in Databricks control plane."
  value       = element(concat(azurerm_databricks_workspace.databricks_workspace.*.workspace_id, [""]), 0)
}

output "databricks_workspace_storage_account_identity" {
  description = "A storage_account_identity block"
  value       = concat(azurerm_databricks_workspace.databricks_workspace.*.storage_account_identity, [""])
}

#-----------------------------------------------------------
# Azure databricks workspace customer managed key
#-----------------------------------------------------------
output "databricks_workspace_customer_managed_key_id" {
  description = "The ID of the Databricks Customer Managed Key."
  value       = element(concat(azurerm_databricks_workspace_customer_managed_key.databricks_workspace_customer_managed_key.*.id, [""]), 0)
}