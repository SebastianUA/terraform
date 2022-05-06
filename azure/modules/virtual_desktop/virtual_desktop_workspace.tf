#-----------------------------------------------------------
# Azure virtual desktop workspace
#-----------------------------------------------------------
resource "azurerm_virtual_desktop_workspace" "virtual_desktop_workspace" {
  count = var.enable_virtual_desktop_workspace ? 1 : 0

  name                = var.virtual_desktop_workspace_name != "" ? var.virtual_desktop_workspace_name : "${lower(var.name)}-virtual-desktop-workspace-${lower(var.environment)}"
  location            = var.virtual_desktop_workspace_location
  resource_group_name = var.virtual_desktop_workspace_resource_group_name

  friendly_name = var.virtual_desktop_workspace_friendly_name
  description   = var.virtual_desktop_workspace_description

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.virtual_desktop_workspace_timeouts)) > 0 ? [var.virtual_desktop_workspace_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.virtual_desktop_workspace_name != "" ? var.virtual_desktop_workspace_name : "${lower(var.name)}-virtual-desktop-workspace-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}