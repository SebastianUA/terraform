#-----------------------------------------------------------
# AWS SSM resource data sync
#-----------------------------------------------------------
resource "aws_ssm_resource_data_sync" "ssm_resource_data_sync" {
  count = var.enable_ssm_resource_data_sync ? 1 : 0

  name = var.ssm_resource_data_sync_name != "" ? lower(var.ssm_resource_data_sync_name) : "${lower(var.name)}-resource-data-sync-${lower(var.environment)}"

  s3_destination {
    bucket_name = var.s3_destination_bucket_name
    region      = var.s3_destination_region
    kms_key_arn = var.s3_destination_kms_key_arn
    prefix      = var.s3_destination_prefix
    sync_format = var.s3_destination_sync_format
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
