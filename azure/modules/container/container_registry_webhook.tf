#-----------------------------------------------------------
# Azure container registry webhook
#-----------------------------------------------------------
resource "azurerm_container_registry_webhook" "container_registry_webhook" {
  count = var.enable_container_registry_webhook ? 1 : 0

  name                = var.container_registry_webhook_name != "" ? var.container_registry_webhook_name : "${lower(var.name)}-container-registry-webhook-${lower(var.environment)}"
  resource_group_name = var.container_registry_webhook_resource_group_name
  location            = var.container_registry_webhook_location
  registry_name       = var.container_registry_webhook_registry_name != "" ? var.container_registry_webhook_registry_name : (var.enable_container_registry ? azurerm_container_registry.container_registry[count.index].name : null)
  service_uri         = var.container_registry_webhook_service_uri
  actions             = var.container_registry_webhook_actions

  status         = var.container_registry_webhook_status
  scope          = var.container_registry_webhook_scope
  custom_headers = var.container_registry_webhook_custom_headers

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.container_registry_webhook_timeouts)) > 0 ? [var.container_registry_webhook_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.container_registry_webhook_name != "" ? var.container_registry_webhook_name : "${lower(var.name)}-container-registry-webhook-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    azurerm_container_registry.container_registry
  ]
}