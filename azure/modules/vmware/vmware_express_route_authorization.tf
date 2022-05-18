#-----------------------------------------------------------
# Azure vmware express route authorization
#-----------------------------------------------------------
resource "azurerm_vmware_express_route_authorization" "vmware_express_route_authorization" {
  count = var.enable_vmware_express_route_authorization ? 1 : 0

  name             = var.vmware_express_route_authorization_name != "" ? var.vmware_express_route_authorization_name : fdsfdsf
  private_cloud_id = var.vmware_express_route_authorization_private_cloud_id != "" ? var.vmware_express_route_authorization_private_cloud_id : (var.enable_vmware_private_cloud ? azurerm_vmware_private_cloud.vmware_private_cloud[count.index].id : null)

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.vmware_express_route_authorization_timeouts)) > 0 ? [var.vmware_express_route_authorization_timeouts] : []

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