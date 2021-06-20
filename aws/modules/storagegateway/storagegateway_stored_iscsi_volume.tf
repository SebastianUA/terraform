#---------------------------------------------------
# AWS storagegateway stored iscsi volume
#---------------------------------------------------
resource "aws_storagegateway_stored_iscsi_volume" "storagegateway_stored_iscsi_volume" {
  count = var.enable_storagegateway_stored_iscsi_volume ? 1 : 0

  gateway_arn            = var.storagegateway_stored_iscsi_volume_gateway_arn != "" ? var.storagegateway_stored_iscsi_volume_gateway_arn : (var.enable_storagegateway_gateway ? aws_storagegateway_gateway.storagegateway_gateway[count.index].arn : null)
  network_interface_id   = var.storagegateway_stored_iscsi_volume_network_interface_id
  target_name            = var.storagegateway_stored_iscsi_volume_target_name
  preserve_existing_data = var.storagegateway_stored_iscsi_volume_preserve_existing_data
  disk_id                = var.storagegateway_stored_iscsi_volume_disk_id

  snapshot_id   = var.storagegateway_stored_iscsi_volume_snapshot_id
  kms_encrypted = var.storagegateway_stored_iscsi_volume_kms_encrypted
  kms_key       = var.storagegateway_stored_iscsi_volume_kms_key

  tags = merge(
    {
      Name = var.storagegateway_stored_iscsi_volume_name != "" ? lower(var.storagegateway_stored_iscsi_volume_name) : "${lower(var.name)}-storagegateway-stored-iscsi-volume-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_storagegateway_gateway.storagegateway_gateway
  ]
}