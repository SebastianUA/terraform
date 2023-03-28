#-----------------------------------------------------------
# Azure storage object replication
#-----------------------------------------------------------
resource "azurerm_storage_object_replication" "storage_object_replication" {
  count = var.enable_storage_object_replication ? 1 : 0

  source_storage_account_id      = var.storage_object_replication_source_storage_account_id != "" ? var.storage_object_replication_source_storage_account_id : (var.enable_storage_container ? azurerm_storage_container.storage_container[count.index].name : null)
  destination_storage_account_id = var.storage_object_replication_destination_storage_account_id

  dynamic "rules" {
    iterator = rules
    for_each = var.storage_object_replication_rules

    content {
      source_container_name      = lookup(rules.value, "destination_container_name", (var.ebable_storage_container ? azurerm_storage_container.storage_container[count.index].name : null))
      destination_container_name = lookup(rules.value, "destination_container_name", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.storage_object_replication_timeouts)) > 0 ? [var.storage_object_replication_timeouts] : []

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
