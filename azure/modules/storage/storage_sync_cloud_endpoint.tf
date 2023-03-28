#-----------------------------------------------------------
# Azure storage sync cloud endpoint
#-----------------------------------------------------------
resource "azurerm_storage_sync_cloud_endpoint" "storage_sync_cloud_endpoint" {
  count = var.enable_storage_sync_cloud_endpoint ? 1 : 0

  name                  = var.storage_sync_cloud_endpoint_name != "" ? var.storage_sync_cloud_endpoint_name : "${lower(var.name)}-storage-sync-cloud-endpoint-${lower(var.environment)}"
  storage_sync_group_id = var.storage_sync_cloud_endpoint_storage_sync_group_id != "" ? var.storage_sync_cloud_endpoint_storage_sync_group_id : (var.enable_storage_sync_group ? azurerm_storage_sync_group.storage_sync_group[count.index].id : null)
  file_share_name       = var.storage_sync_cloud_endpoint_file_share_name != "" ? var.storage_sync_cloud_endpoint_file_share_name : (var.enable_storage_share ? azurerm_storage_share.storage_share[count.index].name : null)
  storage_account_id    = var.storage_sync_cloud_endpoint_storage_account_id != "" ? var.storage_sync_cloud_endpoint_storage_account_id : (var.enable_storage_account ? azurerm_storage_account.storage_account[count.index].id : null)

  storage_account_tenant_id = var.storage_sync_cloud_endpoint_storage_account_tenant_id

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.storage_sync_cloud_endpoint_timeouts)) > 0 ? [var.storage_sync_cloud_endpoint_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    azurerm_storage_sync_group.storage_sync_group,
    azurerm_storage_share.storage_share,
    azurerm_storage_account.storage_account
  ]
}
