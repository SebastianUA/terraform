#---------------------------------------------------
# AWS storagegateway smb file share
#---------------------------------------------------
resource "aws_storagegateway_smb_file_share" "storagegateway_smb_file_share" {
  count = var.enable_storagegateway_smb_file_share ? 1 : 0

  gateway_arn  = var.storagegateway_smb_file_share_gateway_arn != "" ? var.storagegateway_smb_file_share_gateway_arn : (var.enable_storagegateway_gateway ? aws_storagegateway_gateway.storagegateway_gateway[count.index].arn : null)
  location_arn = var.storagegateway_smb_file_share_location_arn
  role_arn     = var.storagegateway_smb_file_share_role_arn

  authentication           = var.storagegateway_smb_file_share_authentication
  admin_user_list          = var.storagegateway_smb_file_share_admin_user_list
  audit_destination_arn    = var.storagegateway_smb_file_share_audit_destination_arn
  default_storage_class    = var.storagegateway_smb_file_share_default_storage_class
  file_share_name          = var.storagegateway_smb_file_share_file_share_name
  guess_mime_type_enabled  = var.storagegateway_smb_file_share_guess_mime_type_enabled
  invalid_user_list        = var.storagegateway_smb_file_share_invalid_user_list
  kms_encrypted            = var.storagegateway_smb_file_share_kms_encrypted
  kms_key_arn              = var.storagegateway_smb_file_share_kms_key_arn
  object_acl               = var.storagegateway_smb_file_share_object_acl
  read_only                = var.storagegateway_smb_file_share_read_only
  requester_pays           = var.storagegateway_smb_file_share_requester_pays
  smb_acl_enabled          = var.storagegateway_smb_file_share_smb_acl_enabled
  case_sensitivity         = var.storagegateway_smb_file_share_case_sensitivity
  valid_user_list          = var.storagegateway_smb_file_share_valid_user_list
  access_based_enumeration = var.storagegateway_smb_file_share_access_based_enumeration
  notification_policy      = var.storagegateway_smb_file_share_notification_policy

  dynamic "cache_attributes" {
    iterator = cache_attributes
    for_each = var.storagegateway_smb_file_share_cache_attributes

    content {
      cache_stale_timeout_in_seconds = lookup(cache_attributes.value, "cache_stale_timeout_in_seconds", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.storagegateway_smb_file_share_timeouts)) > 0 ? [var.storagegateway_smb_file_share_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.storagegateway_smb_file_share_name != "" ? lower(var.storagegateway_smb_file_share_name) : "${lower(var.name)}-storagegateway-smb-file-share-${lower(var.environment)}"
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