#-----------------------------------------------------------
# Azure user assigned identity
#-----------------------------------------------------------
resource "azurerm_user_assigned_identity" "user_assigned_identity" {
  count = var.enable_user_assigned_identity ? 1 : 0

  name                = var.user_assigned_identity_name != "" ? var.user_assigned_identity_name : "${lower(var.name)}-user-assigned-identity-${lower(var.environment)}"
  resource_group_name = var.user_assigned_identity_resource_group_name
  location            = var.user_assigned_identity_location

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.user_assigned_identity_timeouts)) > 0 ? [var.user_assigned_identity_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.user_assigned_identity_name != "" ? var.user_assigned_identity_name : "${lower(var.name)}-user-assigned-identity-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
