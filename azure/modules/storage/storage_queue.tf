#-----------------------------------------------------------
# Azure storage queue
#-----------------------------------------------------------
resource "azurerm_storage_queue" "storage_queue" {
  count = var.enable_storage_queue ? 1 : 0

  name                 = var.storage_queue_name != "" ? var.storage_queue_name : "${lower(var.name)}-storage-queue-${lower(var.environment)}"
  storage_account_name = var.storage_queue_storage_account_name != "" ? var.storage_queue_storage_account_name : (var.enable_storage_account ? azurerm_storage_account.storage_account[count.index].name : null)

  metadata = var.storage_queue_metadata

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.storage_queue_timeouts)) > 0 ? [var.storage_queue_timeouts] : []

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

  depends_on = [
    azurerm_storage_account.storage_account
  ]
}