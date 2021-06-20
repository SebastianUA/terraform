#---------------------------------------------------
# AWS storagegateway working storage
#---------------------------------------------------
resource "aws_storagegateway_working_storage" "storagegateway_working_storage" {
  count = var.enable_storagegateway_working_storage ? 1 : 0

  gateway_arn = var.storagegateway_working_storage_gateway_arn != "" ? var.storagegateway_working_storage_gateway_arn : (var.enable_storagegateway_gateway ? aws_storagegateway_gateway.storagegateway_gateway[count.index].arn : null)
  disk_id     = var.storagegateway_working_storage_disk_id

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_storagegateway_gateway.storagegateway_gateway
  ]
}