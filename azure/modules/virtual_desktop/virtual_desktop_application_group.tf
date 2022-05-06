#-----------------------------------------------------------
# Azure virtual desktop application group
#-----------------------------------------------------------
resource "azurerm_virtual_desktop_application_group" "virtual_desktop_application_group" {
  count = var.enable_virtual_desktop_application_group ? 1 : 0

  name                = var.virtual_desktop_application_group_name != "" ? var.virtual_desktop_application_group_name : "${lower(var.name)}-virtual-desktop-app-group-${lower(var.environment)}"
  resource_group_name = var.virtual_desktop_application_group_resource_group_name
  location            = var.virtual_desktop_application_group_location
  type                = var.virtual_desktop_application_group_type
  host_pool_id        = var.virtual_desktop_application_group_host_pool_id != "" ? var.virtual_desktop_application_group_host_pool_id : (var.enable_virtual_desktop_host_pool ? azurerm_virtual_desktop_host_pool.virtual_desktop_host_pool[count.index].id : null)

  friendly_name                = var.virtual_desktop_application_group_friendly_name
  default_desktop_display_name = var.virtual_desktop_application_group_default_desktop_display_name
  description                  = var.virtual_desktop_application_group_description

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.virtual_desktop_application_group_timeouts)) > 0 ? [var.virtual_desktop_application_group_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.virtual_desktop_application_group_name != "" ? var.virtual_desktop_application_group_name : "${lower(var.name)}-virtual-desktop-app-group-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}