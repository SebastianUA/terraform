#-----------------------------------------------------------
# Azure storage table entity
#-----------------------------------------------------------
resource "azurerm_storage_table_entity" "storage_table_entity" {
  count = var.enable_storage_table_entity ? 1 : 0

  storage_account_name = var.storage_table_entity_storage_account_name != "" ? var.storage_table_entity_storage_account_name : (var.enable_storage_account ? azurerm_storage_account.storage_account[count.index].name : null)
  table_name           = var.storage_table_entity_table_name != "" ? var.storage_table_entity_table_name : (var.enable_storage_table ? azurerm_storage_table.storage_table[count.index].name : null)
  partition_key        = var.storage_table_entity_partition_key
  row_key              = var.storage_table_entity_row_key
  entity               = var.storage_table_entity_entity

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.storage_table_entity_timeouts)) > 0 ? [var.storage_table_entity_timeouts] : []

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
    azurerm_storage_account.storage_account,
    azurerm_storage_table.storage_table
  ]
}