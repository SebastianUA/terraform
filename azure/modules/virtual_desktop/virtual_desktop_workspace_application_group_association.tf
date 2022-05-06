#-----------------------------------------------------------
# Azure virtual desktop workspace application group association
#-----------------------------------------------------------
resource "azurerm_virtual_desktop_workspace_application_group_association" "virtual_desktop_workspace_application_group_association" {
  count = var.enable_virtual_desktop_workspace_application_group_association ? 1 : 0

  workspace_id         = var.virtual_desktop_workspace_application_group_association_workspace_id != "" ? var.virtual_desktop_workspace_application_group_association_workspace_id : (var.enable_virtual_desktop_workspace ? azurerm_virtual_desktop_workspace.virtual_desktop_workspace[count.index].id : null)
  application_group_id = var.virtual_desktop_workspace_application_group_association_application_group_id != "" ? var.virtual_desktop_workspace_application_group_association_application_group_id : (var.enable_virtual_desktop_application_group ? azurerm_virtual_desktop_application_group.virtual_desktop_application_group[count.index].id : null)

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.virtual_desktop_workspace_application_group_association_timeouts)) > 0 ? [var.virtual_desktop_workspace_application_group_association_timeouts] : []

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
    azurerm_virtual_desktop_workspace.virtual_desktop_workspace,
    azurerm_virtual_desktop_application_group.virtual_desktop_application_group
  ]
}