#-----------------------------------------------------------
# Azure management lock
#-----------------------------------------------------------
resource "azurerm_management_lock" "management_lock" {
  count = var.enable_management_lock ? 1 : 0

  name       = var.management_lock_name != "" ? var.management_lock_name : "${lower(var.name)}-management-lock-${lower(var.environment)}"
  scope      = var.management_lock_scope
  lock_level = var.management_lock_lock_level

  notes = var.management_lock_notes

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.management_lock_timeouts)) > 0 ? [var.management_lock_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.management_lock_name != "" ? var.management_lock_name : "${lower(var.name)}-management-lock-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}