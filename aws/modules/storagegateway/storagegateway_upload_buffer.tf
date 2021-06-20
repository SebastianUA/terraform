#---------------------------------------------------
# AWS storagegateway upload buffer
#---------------------------------------------------
resource "aws_storagegateway_upload_buffer" "storagegateway_upload_buffer" {
  count = var.enable_storagegateway_upload_buffer ? 1 : 0

  gateway_arn = var.storagegateway_upload_buffer_gateway_arn != "" ? var.storagegateway_upload_buffer_gateway_arn : (var.enable_storagegateway_gateway ? aws_storagegateway_gateway.storagegateway_gateway[count.index].arn : null)

  disk_id   = var.storagegateway_upload_buffer_disk_id
  disk_path = var.storagegateway_upload_buffer_disk_path

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_storagegateway_gateway.storagegateway_gateway
  ]
}