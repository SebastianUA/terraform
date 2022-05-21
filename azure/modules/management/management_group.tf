#-----------------------------------------------------------
# Azure management group
#-----------------------------------------------------------
resource "azurerm_management_group" "management_group" {
  count = var.enable_management_group ? 1 : 0

  name                       = var.management_group_name != "" ? var.management_group_name : "${lower(var.name)}-management-group-${lower(var.environment)}"
  display_name               = var.management_group_display_name
  parent_management_group_id = var.management_group_parent_management_group_id
  subscription_ids           = var.management_group_subscription_ids

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.management_group_timeouts)) > 0 ? [var.management_group_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.management_group_name != "" ? var.management_group_name : "${lower(var.name)}-management-group-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}