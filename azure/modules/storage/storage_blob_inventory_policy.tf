#-----------------------------------------------------------
# Azure storage blob inventory policy
#-----------------------------------------------------------
resource "azurerm_storage_blob_inventory_policy" "storage_blob_inventory_policy" {
  count = var.enable_storage_blob_inventory_policy ? 1 : 0

  storage_account_id = var.storage_blob_inventory_policy_storage_account_id != "" ? var.storage_blob_inventory_policy_storage_account_id : (var.enable_storage_account ? azurerm_storage_account.storage_account[count.index].id : null)
  dynamic "rules" {
    iterator = rules
    for_each = var.storage_blob_inventory_policy_rules

    content {
      name                   = lookup(rules.value, "name", "${lower(var.name)}-blob-inventory-policy-${lower(var.environment)}-${count.index + 1}")
      storage_container_name = lookup(rules.value, "storage_container_name", (var.enable_storage_container ? azurerm_storage_container.storage_container[count.index].name : null))
      format                 = lookup(rules.value, "format", null)
      schedule               = lookup(rules.value, "schedule", null)
      scope                  = lookup(rules.value, "scope", null)
      schema_fields          = lookup(rules.value, "schema_fields", null)

      dynamic "filter" {
        iterator = filter
        for_each = length(keys(lookup(rules.value, "filter", {}))) > 0 ? [lookup(rules.value, "filter", {})] : []

        content {
          blob_types = lookup(filter.value, "include_blob_versions", null)

          include_blob_versions = lookup(filter.value, "include_blob_versions", null)
          include_snapshots     = lookup(filter.value, "include_snapshots", null)
          prefix_match          = lookup(filter.value, "prefix_match", null)
        }
      }
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.storage_blob_inventory_policy_timeouts)) > 0 ? [var.storage_blob_inventory_policy_timeouts] : []

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
