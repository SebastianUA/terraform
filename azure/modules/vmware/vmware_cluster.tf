#-----------------------------------------------------------
# Azure vmware cluster
#-----------------------------------------------------------
resource "azurerm_vmware_cluster" "vmware_cluster" {
  count = var.enable_vmware_cluster ? 1 : 0

  name               = var.vmware_cluster_name != "" ? var.vmware_cluster_name : "${lower(var.name)}-vmware-cluster-${lower(var.environment)}"
  vmware_cloud_id    = var.vmware_cluster_vmware_cloud_id != "" ? var.vmware_cluster_vmware_cloud_id : (var.enable_vmware_private_cloud ? azurerm_vmware_private_cloud.vmware_private_cloud[count.index].id : null)
  cluster_node_count = var.vmware_cluster_cluster_node_count
  sku_name           = var.vmware_cluster_sku_name

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.vmware_cluster_timeouts)) > 0 ? [var.vmware_cluster_timeouts] : []

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

  depends_on = [
    azurerm_vmware_private_cloud.vmware_private_cloud
  ]
}