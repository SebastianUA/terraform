#-----------------------------------------------------------
# Azure resource provider registration
#-----------------------------------------------------------
resource "azurerm_resource_provider_registration" "resource_provider_registration" {
  count = var.enable_resource_provider_registration ? 1 : 0

  name = var.resource_provider_registration_name

  dynamic "feature" {
    iterator = feature
    for_each = var.resource_provider_registration_feature

    content {
      name       = lookup(feature.value, "name ", null)
      registered = lookup(feature.value, "registered ", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.resource_provider_registration_timeouts)) > 0 ? [var.resource_provider_registration_timeouts] : []

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