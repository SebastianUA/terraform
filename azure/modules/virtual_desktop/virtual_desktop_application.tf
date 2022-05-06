#-----------------------------------------------------------
# Azure virtual desktop application
#-----------------------------------------------------------
resource "azurerm_virtual_desktop_application" "virtual_desktop_application" {
  count = var.enable_virtual_desktop_application ? 1 : 0

  name                         = var.virtual_desktop_application_name != "" ? var.virtual_desktop_application_name : "${lower(var.name)}-virtual-desktop-app-${lower(var.environment)}"
  application_group_id         = var.virtual_desktop_application_application_group_id != "" ? var.virtual_desktop_application_application_group_id : (var.enable_ ? azurerm_virtual_desktop_application_group.virtual_desktop_application_group[count.index].id : null)
  path                         = var.virtual_desktop_application_path
  command_line_argument_policy = var.virtual_desktop_application_command_line_argument_policy

  friendly_name          = var.virtual_desktop_application_friendly_name
  description            = var.virtual_desktop_application_description
  command_line_arguments = var.virtual_desktop_application_command_line_arguments
  show_in_portal         = var.virtual_desktop_application_show_in_portal
  icon_path              = var.virtual_desktop_application_icon_path
  icon_index             = var.virtual_desktop_application_icon_index

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.virtual_desktop_application_timeouts)) > 0 ? [var.virtual_desktop_application_timeouts] : []

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
    azurerm_virtual_desktop_application_group.virtual_desktop_application_group
  ]
}