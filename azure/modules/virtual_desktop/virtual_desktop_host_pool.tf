#-----------------------------------------------------------
# Azure virtual desktop host pool
#-----------------------------------------------------------
resource "azurerm_virtual_desktop_host_pool" "virtual_desktop_host_pool" {
  count = var.enable_virtual_desktop_host_pool ? 1 : 0

  name                = var.virtual_desktop_host_pool_name != "" ? var.virtual_desktop_host_pool_name : "${lower(var.name)}-virtual-desktop-host-pool-${lower(var.environment)}"
  resource_group_name = var.virtual_desktop_host_pool_resource_group_name
  location            = var.virtual_desktop_host_pool_location
  type                = var.virtual_desktop_host_pool_type

  load_balancer_type               = var.virtual_desktop_host_pool_load_balancer_type
  friendly_name                    = var.virtual_desktop_host_pool_friendly_name
  description                      = var.virtual_desktop_host_pool_description
  validate_environment             = var.virtual_desktop_host_pool_validate_environment
  start_vm_on_connect              = var.virtual_desktop_host_pool_start_vm_on_connect
  custom_rdp_properties            = var.virtual_desktop_host_pool_custom_rdp_properties
  personal_desktop_assignment_type = var.virtual_desktop_host_pool_personal_desktop_assignment_type
  maximum_sessions_allowed         = var.virtual_desktop_host_pool_maximum_sessions_allowed
  preferred_app_group_type         = var.virtual_desktop_host_pool_preferred_app_group_type

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.virtual_desktop_host_pool_timeouts)) > 0 ? [var.virtual_desktop_host_pool_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.virtual_desktop_host_pool_name != "" ? var.virtual_desktop_host_pool_name : "${lower(var.name)}-virtual-desktop-host-pool-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}