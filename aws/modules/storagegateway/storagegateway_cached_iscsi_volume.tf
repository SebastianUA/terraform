#---------------------------------------------------
# AWS storagegateway cached iscsi volume
#---------------------------------------------------
resource "aws_storagegateway_cached_iscsi_volume" "storagegateway_cached_iscsi_volume" {
  count = var.enable_storagegateway_cached_iscsi_volume ? 1 : 0

  gateway_arn          = var.storagegateway_cached_iscsi_volume_gateway_arn != "" ? var.storagegateway_cached_iscsi_volume_gateway_arn : (var.enable_storagegateway_cache ? aws_storagegateway_cache.storagegateway_cache[count.index].gateway_arn : null)
  network_interface_id = var.storagegateway_cached_iscsi_volume_network_interface_id
  target_name          = var.storagegateway_cached_iscsi_volume_target_name
  volume_size_in_bytes = var.storagegateway_cached_iscsi_volume_volume_size_in_bytes

  snapshot_id       = var.storagegateway_cached_iscsi_volume_snapshot_id
  source_volume_arn = var.storagegateway_cached_iscsi_volume_source_volume_arn

  kms_encrypted = var.storagegateway_cached_iscsi_volume_kms_encrypted
  kms_key       = var.storagegateway_cached_iscsi_volume_kms_key

  tags = merge(
    {
      Name = var.storagegateway_cached_iscsi_volume_target_name != "" ? lower(var.storagegateway_cached_iscsi_volume_target_name) : "${lower(var.name)}-storagegateway-cached-iscsi-volume-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_storagegateway_cache.storagegateway_cache
  ]
}