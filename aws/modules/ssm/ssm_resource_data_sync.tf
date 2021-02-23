#-----------------------------------------------------------
# AWS SSM resource data sync
#-----------------------------------------------------------
resource "aws_ssm_resource_data_sync" "ssm_resource_data_sync" {
  count = var.enable_ssm_resource_data_sync ? 1 : 0

  name = var.ssm_resource_data_sync_name != "" ? lower(var.ssm_resource_data_sync_name) : "${lower(var.name)}-resource-data-sync-${lower(var.environment)}"

  dynamic "s3_destination" {
    iterator = s3_destination
    for_each = var.ssm_resource_data_sync_s3_destination
    content {
      bucket_name = lookup(s3_destination.value, "bucket_name", null)
      region      = lookup(s3_destination.value, "region", null)
      kms_key_arn = lookup(s3_destination.value, "kms_key_arn", null)
      prefix      = lookup(s3_destination.value, "prefix", null)
      sync_format = lookup(s3_destination.value, "sync_format", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
