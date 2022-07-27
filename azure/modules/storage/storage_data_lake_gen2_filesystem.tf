#-----------------------------------------------------------
# Azure storage data lake gen2 filesystem
#-----------------------------------------------------------
resource "azurerm_storage_data_lake_gen2_filesystem" "storage_data_lake_gen2_filesystem" {
  count = var.enable_storage_data_lake_gen2_filesystem ? 1 : 0

  name               = var.storage_data_lake_gen2_filesystem_name != "" ? var.storage_data_lake_gen2_filesystem_name : "${lower(var.name)}-storage-data-lake-gen2-fs-${lower(var.environment)}"
  storage_account_id = var.storage_data_lake_gen2_filesystem_storage_account_id != "" ? var.storage_data_lake_gen2_filesystem_storage_account_id : (var.enable_storage_account ? azurerm_storage_account.storage_account[count.index].id : null)

  properties = var.storage_data_lake_gen2_filesystem_properties
  owner      = var.storage_data_lake_gen2_filesystem_owner
  group      = var.storage_data_lake_gen2_filesystem_group

  dynamic "ace" {
    iterator = ace
    for_each = var.storage_data_lake_gen2_filesystem_ace

    content {
      type        = lookup(ace.value, "type", null)
      permissions = lookup(ace.value, "permissions", null)

      scope = lookup(ace.value, "scope", null)
      id    = lookup(ace.value, "id", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.storage_data_lake_gen2_filesystem_timeouts)) > 0 ? [var.storage_data_lake_gen2_filesystem_timeouts] : []

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