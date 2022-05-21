#-----------------------------------------------------------
# Azure management group subscription association
#-----------------------------------------------------------
resource "azurerm_management_group_subscription_association" "management_group_subscription_association" {
  count = var.enable_management_group_subscription_association ? 1 : 0

  management_group_id = var.management_group_subscription_association_management_group_id
  subscription_id     = var.management_group_subscription_association_subscription_id

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.management_group_subscription_association_timeouts)) > 0 ? [var.management_group_subscription_association_timeouts] : []

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

  depends_on = []
}