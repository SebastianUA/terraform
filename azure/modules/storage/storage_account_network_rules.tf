#-----------------------------------------------------------
# Azure storage account network rules
#-----------------------------------------------------------
resource "azurerm_storage_account_network_rules" "storage_account_network_rules" {
  count = var.enable_storage_account_network_rules ? 1 : 0

  default_action = var.storage_account_network_rules_default_action

  storage_account_id         = var.storage_account_network_rules_storage_account_id != "" ? var.storage_account_network_rules_storage_account_id : (var.enable_storage_account ? azurerm_storage_account.storage_account[count.index].id : null)
  bypass                     = var.storage_account_network_rules_bypass
  ip_rules                   = var.storage_account_network_rules_ip_rules
  virtual_network_subnet_ids = var.storage_account_network_rules_virtual_network_subnet_ids

  dynamic "private_link_access" {
    iterator = private_link_access
    for_each = length(keys(var.storage_account_network_rules_private_link_access)) > 0 ? [var.storage_account_network_rules_private_link_access] : []

    content {
      endpoint_resource_id = lookup(private_link_access.value, "endpoint_resource_id", null)

      endpoint_tenant_id = lookup(private_link_access.value, "endpoint_tenant_id", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.storage_account_network_rules_timeouts)) > 0 ? [var.storage_account_network_rules_timeouts] : []

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