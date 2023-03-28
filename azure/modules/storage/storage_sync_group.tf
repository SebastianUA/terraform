#-----------------------------------------------------------
# Azure storage sync group
#-----------------------------------------------------------
resource "azurerm_storage_sync_group" "storage_sync_group" {
  count = var.enable_storage_sync_group ? 1 : 0

  name            = var.storage_sync_group_name != "" ? var.storage_sync_group_name : "${lower(var.name)}-storage-sync-group-${lower(var.environment)}"
  storage_sync_id = var.storage_sync_group_storage_sync_id != "" ? var.storage_sync_group_storage_sync_id : (var.enable_storage_sync ? azurerm_storage_sync.storage_sync[count.index].id : null)

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.storage_sync_group_timeouts)) > 0 ? [var.storage_sync_group_timeouts] : []

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
    azurerm_storage_sync.storage_sync
  ]
}
