#---------------------------------------------------
# AWS storagegateway gateway
#---------------------------------------------------
resource "aws_storagegateway_gateway" "storagegateway_gateway" {
  count = var.enable_storagegateway_gateway ? 1 : 0

  gateway_name     = var.storagegateway_gateway_name != "" ? lower(var.storagegateway_gateway_name) : "${lower(var.name)}-storagegateway-gtw-${lower(var.environment)}"
  gateway_timezone = var.storagegateway_gateway_timezone

  gateway_ip_address   = var.storagegateway_gateway_ip_address
  gateway_type         = var.storagegateway_gateway_type
  gateway_vpc_endpoint = var.storagegateway_gateway_vpc_endpoint
  medium_changer_type  = var.storagegateway_gateway_medium_changer_type
  tape_drive_type      = var.storagegateway_gateway_tape_drive_type

  activation_key           = var.storagegateway_gateway_activation_key
  cloudwatch_log_group_arn = var.storagegateway_gateway_cloudwatch_log_group_arn

  average_download_rate_limit_in_bits_per_sec = var.storagegateway_gateway_average_download_rate_limit_in_bits_per_sec
  average_upload_rate_limit_in_bits_per_sec   = var.storagegateway_gateway_average_upload_rate_limit_in_bits_per_sec

  smb_guest_password        = var.storagegateway_gateway_smb_guest_password
  smb_security_strategy     = var.storagegateway_gateway_smb_security_strategy
  smb_file_share_visibility = var.storagegateway_gateway_smb_file_share_visibility

  dynamic "smb_active_directory_settings" {
    iterator = smb_active_directory_settings
    for_each = var.storagegateway_gateway_smb_active_directory_settings

    content {
      domain_name = lookup(smb_active_directory_settings.value, "domain_name", null)
      password    = lookup(smb_active_directory_settings.value, "password", null)
      username    = lookup(smb_active_directory_settings.value, "username", null)

      timeout_in_seconds  = lookup(smb_active_directory_settings.value, "timeout_in_seconds", null)
      organizational_unit = lookup(smb_active_directory_settings.value, "organizational_unit", null)
      domain_controllers  = lookup(smb_active_directory_settings.value, "domain_controllers", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.storagegateway_gateway_timeouts)) > 0 ? [var.storagegateway_gateway_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
    }
  }

  tags = merge(
    {
      Name = var.storagegateway_gateway_name != "" ? lower(var.storagegateway_gateway_name) : "${lower(var.name)}-storagegateway-gtw-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
