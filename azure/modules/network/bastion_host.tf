#-----------------------------------------------------------
# Azure bastion host
#-----------------------------------------------------------
resource "azurerm_bastion_host" "bastion_host" {
  count = var.enable_bastion_host ? 1 : 0

  name                = var.bastion_host_name != "" ? var.bastion_host_name : "${lower(var.name)}-bastion-host-${lower(var.environment)}"
  resource_group_name = var.bastion_host_resource_group_name
  location            = var.bastion_host_location

  copy_paste_enabled     = var.bastion_host_copy_paste_enabled
  file_copy_enabled      = var.bastion_host_file_copy_enabled
  sku                    = var.bastion_host_sku
  ip_connect_enabled     = var.bastion_host_ip_connect_enabled
  scale_units            = var.bastion_host_scale_units
  shareable_link_enabled = var.bastion_host_shareable_link_enabled
  tunneling_enabled      = var.bastion_host_tunneling_enabled

  dynamic "ip_configuration" {
    iterator = ip_configuration
    for_each = length(keys(var.bastion_host_ip_configuration)) > 0 ? [var.bastion_host_ip_configuration] : []

    content {
      name                 = lookup(ip_configuration.value, "name", null)
      subnet_id            = lookup(ip_configuration.value, "subnet_id", null)
      public_ip_address_id = lookup(ip_configuration.value, "public_ip_address_id", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.bastion_host_timeouts)) > 0 ? [var.bastion_host_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.bastion_host_name != "" ? var.bastion_host_name : "${lower(var.name)}-bastion-host-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}