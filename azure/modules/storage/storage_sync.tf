#-----------------------------------------------------------
# Azure storage sync
#-----------------------------------------------------------
resource "azurerm_storage_sync" "storage_sync" {
  count = var.enable_storage_sync ? 1 : 0

  name                = var.storage_sync_name != "" ? var.storage_sync_name : "${lower(var.name)}-storage-sync-${lower(var.environment)}"
  resource_group_name = var.storage_sync_resource_group_name
  location            = var.storage_sync_location

  incoming_traffic_policy = var.storage_sync_incoming_traffic_policy

  tags = merge(
    {
      Name = var.storage_sync_name != "" ? var.storage_sync_name : "${lower(var.name)}-storage-sync-${lower(var.environment)}"
    },
    var.tags
  )

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.storage_sync_timeouts)) > 0 ? [var.storage_sync_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}