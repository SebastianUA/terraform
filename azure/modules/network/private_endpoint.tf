#-----------------------------------------------------------
# Azure private endpoint
#-----------------------------------------------------------
resource "azurerm_private_endpoint" "private_endpoint" {
  count = var.enable_private_endpoint ? 1 : 0

  name                = var.private_endpoint_name != "" ? var.private_endpoint_name : "${lower(var.name)}-private-endpoint-${lower(var.environment)}"
  resource_group_name = var.private_endpoint_resource_group_name
  location            = var.private_endpoint_location
  subnet_id           = var.private_endpoint_subnet_id

  dynamic "private_dns_zone_group" {
    iterator = private_dns_zone_group
    for_each = length(keys(var.private_endpoint_private_dns_zone_group)) > 0 ? [var.private_endpoint_private_dns_zone_group] : []

    content {
      name                 = lookup(private_dns_zone_group.value, "name", null)
      private_dns_zone_ids = lookup(private_dns_zone_group.value, "private_dns_zone_ids", null)
    }
  }

  dynamic "private_service_connection" {
    iterator = private_service_connection
    for_each = length(keys(var.private_endpoint_private_service_connection)) > 0 ? [var.private_endpoint_private_service_connection] : []

    content {
      name                 = lookup(private_service_connection.value, "name", null)
      is_manual_connection = lookup(private_service_connection.value, "is_manual_connection", null)

      private_connection_resource_id    = lookup(private_service_connection.value, "private_connection_resource_id", (var.enable_private_link_service ? azurerm_private_link_service.private_link_service[count.index].id : null))
      private_connection_resource_alias = lookup(private_service_connection.value, "private_connection_resource_alias", null)
      subresource_names                 = lookup(private_service_connection.value, "subresource_names", null)
      request_message                   = lookup(private_service_connection.value, "request_message", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.private_endpoint_timeouts)) > 0 ? [var.private_endpoint_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.private_endpoint_name != "" ? var.private_endpoint_name : "${lower(var.name)}-private-endpoint-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    azurerm_private_link_service.private_link_service
  ]
}