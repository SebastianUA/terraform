#-----------------------------------------------------------
# Azure storage data lake gen2 path
#-----------------------------------------------------------
resource "azurerm_storage_data_lake_gen2_path" "storage_data_lake_gen2_path" {
  count = var.enable_storage_data_lake_gen2_path ? 1 : 0

  path               = var.storage_data_lake_gen2_path_path != "" ? var.storage_data_lake_gen2_path_path : "${lower(var.name)}-storage-data-lake-gen2-path-${lower(var.environment)}"
  filesystem_name    = var.storage_data_lake_gen2_path_filesystem_name != "" ? var.storage_data_lake_gen2_path_filesystem_name : (var.enable_storage_data_lake_gen2_filesystem ? azurerm_storage_data_lake_gen2_filesystem.storage_data_lake_gen2_filesystem[count.index].name : null)
  storage_account_id = var.storage_data_lake_gen2_path_storage_account_id != "" ? var.storage_data_lake_gen2_path_storage_account_id : (var.enable_storage_account ? azurerm_storage_account.storage_account[count.index].id : null)
  resource           = var.storage_data_lake_gen2_path_resource

  owner = var.storage_data_lake_gen2_path_owner
  group = var.storage_data_lake_gen2_path_group

  dynamic "ace" {
    iterator = ace
    for_each = var.storage_data_lake_gen2_path_ace

    content {
      type        = lookup(ace.value, "type", null)
      permissions = lookup(ace.value, "permissions", null)

      scope = lookup(ace.value, "scope", null)
      id    = lookup(ace.value, "id", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.storage_data_lake_gen2_path_timeouts)) > 0 ? [var.storage_data_lake_gen2_path_timeouts] : []

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