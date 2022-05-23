#-----------------------------------------------------------
# Azure databricks workspace customer managed key
#-----------------------------------------------------------
resource "azurerm_databricks_workspace_customer_managed_key" "databricks_workspace_customer_managed_key" {
  count = var.enable_databricks_workspace_customer_managed_key ? 1 : 0

  workspace_id     = var.databricks_workspace_customer_managed_key_workspace_id != "" ? var.databricks_workspace_customer_managed_key_workspace_id : (var.enable_databricks_workspace ? azurerm_databricks_workspace.databricks_workspace[count.index].id : null)
  key_vault_key_id = var.databricks_workspace_customer_managed_key_key_vault_key_id

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.databricks_workspace_customer_managed_key_timeouts)) > 0 ? [var.databricks_workspace_customer_managed_key_timeouts] : []

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
    azurerm_databricks_workspace.databricks_workspace
  ]
}