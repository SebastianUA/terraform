#-----------------------------------------------------------
# Azure storage container
#-----------------------------------------------------------
resource "azurerm_storage_container" "storage_container" {
  count = var.enable_storage_container ? 1 : 0

  name                 = var.storage_container_name != "" ? var.storage_container_name : "${lower(var.name)}-storage-container-${lower(var.environment)}"
  storage_account_name = var.storage_container_storage_account_name != "" ? var.storage_container_storage_account_name : (var.enable_storage_account ? azurerm_storage_account.storage_account[count.index].name : null)

  container_access_type = var.storage_container_container_access_type
  metadata              = var.storage_container_metadata

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.storage_container_timeouts)) > 0 ? [var.storage_container_timeouts] : []

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