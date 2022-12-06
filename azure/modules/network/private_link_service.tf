#-----------------------------------------------------------
# Azure private link service
#-----------------------------------------------------------
resource "azurerm_private_link_service" "private_link_service" {
  count = var.enable_private_link_service ? 1 : 0

  name                                        = var.private_link_service_name != "" ? var.private_link_service_name : "${lower(var.name)}-private-link-service-${lower(var.environment)}"
  resource_group_name                         = var.private_link_service_resource_group_name
  location                                    = var.private_link_service_location
  load_balancer_frontend_ip_configuration_ids = var.private_link_service_load_balancer_frontend_ip_configuration_ids

  auto_approval_subscription_ids = var.private_link_service_auto_approval_subscription_ids
  enable_proxy_protocol          = var.private_link_service_enable_proxy_protocol
  fqdns                          = var.private_link_service_fqdns
  visibility_subscription_ids    = var.private_link_service_visibility_subscription_ids

  dynamic "nat_ip_configuration" {
    iterator = nat_ip_configuration
    for_each = var.private_link_service_nat_ip_configuration

    content {
      name                       = lookup(nat_ip_configuration.value, "name", null)
      subnet_id                  = lookup(nat_ip_configuration.value, "subnet_id", null)
      primary                    = lookup(nat_ip_configuration.value, "primary", null)
      private_ip_address         = lookup(nat_ip_configuration.value, "private_ip_address", null)
      private_ip_address_version = lookup(nat_ip_configuration.value, "private_ip_address_version", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.private_link_service_timeouts)) > 0 ? [var.private_link_service_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.private_link_service_name != "" ? var.private_link_service_name : "${lower(var.name)}-private-link-service-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}