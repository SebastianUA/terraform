#-----------------------------------------------------------
# Azure subscription
#-----------------------------------------------------------
resource "azurerm_subscription" "subscription" {
  count = var.enable_subscription ? 1 : 0

  subscription_name = var.subscription_name != "" ? var.subscription_name : "${lower(var.name)}-subscription-${lower(var.environment)}"

  alias            = var.subscription_alias
  billing_scope_id = var.subscription_billing_scope_id
  subscription_id  = var.subscription_id
  workload         = var.subscription_workload

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.subscription_timeouts)) > 0 ? [var.subscription_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.subscription_name != "" ? var.subscription_name : "${lower(var.name)}-subscription-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}