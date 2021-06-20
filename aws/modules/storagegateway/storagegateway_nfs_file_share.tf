#---------------------------------------------------
# AWS storagegateway nfs file share
#---------------------------------------------------
resource "aws_storagegateway_nfs_file_share" "storagegateway_nfs_file_share" {
  count = var.enable_storagegateway_nfs_file_share ? 1 : 0

  client_list  = var.storagegateway_nfs_file_share_client_list
  gateway_arn  = var.storagegateway_nfs_file_share_gateway_arn != "" ? var.storagegateway_nfs_file_share_gateway_arn : (var.enable_storagegateway_gateway ? aws_storagegateway_gateway.storagegateway_gateway[count.index].arn : null)
  location_arn = var.storagegateway_nfs_file_share_location_arn
  role_arn     = var.storagegateway_nfs_file_share_role_arn

  default_storage_class   = var.storagegateway_nfs_file_share_default_storage_class
  guess_mime_type_enabled = var.storagegateway_nfs_file_share_guess_mime_type_enabled
  kms_encrypted           = var.storagegateway_nfs_file_share_kms_encrypted
  kms_key_arn             = var.storagegateway_nfs_file_share_kms_key_arn
  object_acl              = var.storagegateway_nfs_file_share_object_acl
  read_only               = var.storagegateway_nfs_file_share_read_only
  requester_pays          = var.storagegateway_nfs_file_share_requester_pays
  squash                  = var.storagegateway_nfs_file_share_squash
  file_share_name         = var.storagegateway_nfs_file_share_file_share_name
  notification_policy     = var.storagegateway_nfs_file_share_notification_policy

  dynamic "nfs_file_share_defaults" {
    iterator = nfs_file_share_defaults
    for_each = var.storagegateway_nfs_file_share_nfs_file_share_defaults

    content {
      directory_mode = lookup(nfs_file_share_defaults.value, "directory_mode", null)
      file_mode      = lookup(nfs_file_share_defaults.value, "file_mode", null)
      group_id       = lookup(nfs_file_share_defaults.value, "group_id", null)
      owner_id       = lookup(nfs_file_share_defaults.value, "owner_id", null)
    }
  }

  dynamic "cache_attributes" {
    iterator = cache_attributes
    for_each = var.storagegateway_nfs_file_share_cache_attributes

    content {
      cache_stale_timeout_in_seconds = lookup(cache_attributes.value, "cache_stale_timeout_in_seconds", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.storagegateway_nfs_file_share_timeouts)) > 0 ? [var.storagegateway_nfs_file_share_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.storagegateway_nfs_file_share_name != "" ? lower(var.storagegateway_nfs_file_share_name) : "${lower(var.name)}-storagegateway-nfs-file-share-${lower(var.environment)}"
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

