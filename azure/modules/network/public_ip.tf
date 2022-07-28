#-----------------------------------------------------------
# Azure public ip
#-----------------------------------------------------------
resource "azurerm_public_ip" "public_ip" {
  count = var.enable_public_ip ? 1 : 0

  name                = var.public_ip_name != "" ? var.public_ip_name : "${lower(var.name)}-public-ip-${lower(var.environment)}"
  resource_group_name = var.public_ip_resource_group_name
  location            = var.public_ip_location
  allocation_method   = var.public_ip_allocation_method

  zones                   = var.public_ip_zones
  domain_name_label       = var.public_ip_domain_name_label
  edge_zone               = var.public_ip_edge_zone
  idle_timeout_in_minutes = var.public_ip_idle_timeout_in_minutes

  ip_tags    = var.public_ip_ip_tags
  ip_version = var.public_ip_ip_version

  public_ip_prefix_id = var.public_ip_public_ip_prefix_id
  reverse_fqdn        = var.public_ip_reverse_fqdn

  sku      = var.public_ip_sku
  sku_tier = var.public_ip_sku_tier

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.public_ip_timeouts)) > 0 ? [var.public_ip_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.public_ip_name != "" ? var.public_ip_name : "${lower(var.name)}-public-ip-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}