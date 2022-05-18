#-----------------------------------------------------------
# Azure resource group
#-----------------------------------------------------------
resource "azurerm_resource_group" "resource_group" {
  count = var.enable_resource_group ? 1 : 0

  name     = var.resource_group_name != "" ? var.resource_group_name : "${lower(var.name)}-resource-group-${lower(var.environment)}"
  location = var.resource_group_location

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.resource_group_timeouts)) > 0 ? [var.resource_group_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.resource_group_name != "" ? var.resource_group_name : "${lower(var.name)}-resource-group-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}