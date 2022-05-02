#-----------------------------------------------------------
# Azure vmware private cloud
#-----------------------------------------------------------
resource "azurerm_vmware_private_cloud" "vmware_private_cloud" {
  count = var.enable_vmware_private_cloud ? 1 : 0

  name                = var.vmware_private_cloud_name != "" ? var.vmware_private_cloud_name : "${lower(var.name)}-vmware-private-cloud-${lower(var.environment)}"
  resource_group_name = var.vmware_private_cloud_resource_group_name
  location            = var.vmware_private_cloud_location
  network_subnet_cidr = var.vmware_private_cloud_network_subnet_cidr
  sku_name            = var.vmware_private_cloud_sku_name

  dynamic "management_cluster" {
    iterator = management_cluster
    for_each = length(keys(var.vmware_private_cloud_management_cluster)) > 0 ? [var.vmware_private_cloud_management_cluster] : []

    content {
      size = lookup(management_cluster.value, "size", null)
    }
  }

  internet_connection_enabled = var.vmware_private_cloud_internet_connection_enabled
  nsxt_password               = var.vmware_private_cloud_nsxt_password
  vcenter_password            = var.vmware_private_cloud_vcenter_password

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.vmware_private_cloud_timeouts)) > 0 ? [var.vmware_private_cloud_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.vmware_private_cloud_name != "" ? var.vmware_private_cloud_name : "${lower(var.name)}-vmware-private-cloud-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}