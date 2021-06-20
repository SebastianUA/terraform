#---------------------------------------------------
# AWS storagegateway cached
#---------------------------------------------------
resource "aws_storagegateway_cache" "storagegateway_cache" {
  count = var.enable_storagegateway_cache ? 1 : 0

  gateway_arn = var.storagegateway_cache_gateway_arn != "" ? var.storagegateway_cache_gateway_arn : (var.enable_storagegateway_gateway ? aws_storagegateway_gateway.storagegateway_gateway[count.index].arn : null)
  disk_id     = var.storagegateway_cache_disk_id

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_storagegateway_gateway.storagegateway_gateway
  ]
}