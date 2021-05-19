# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# AWS CloudTrail
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
resource "aws_cloudtrail" "cloudtrail" {
  count = var.enable_cloudtrail ? 1 : 0

  name           = var.cloudtrail_name != "" ? lower(var.cloudtrail_name) : "${lower(var.name)}-cloudtrail-${lower(var.environment)}"
  s3_bucket_name = var.cloudtrail_s3_bucket_name
  s3_key_prefix  = var.cloudtrail_s3_key_prefix

  cloud_watch_logs_role_arn  = var.cloudtrail_cloud_watch_logs_role_arn
  cloud_watch_logs_group_arn = var.cloudtrail_cloud_watch_logs_group_arn

  enable_logging                = var.cloudtrail_enable_logging
  enable_log_file_validation    = var.cloudtrail_enable_log_file_validation
  include_global_service_events = var.cloudtrail_include_global_service_events
  sns_topic_name                = var.cloudtrail_sns_topic_name
  kms_key_id                    = var.cloudtrail_kms_key_id

  is_multi_region_trail = var.cloudtrail_is_multi_region_trail
  is_organization_trail = var.cloudtrail_is_organization_trail

  dynamic "event_selector" {
    iterator = event_selector
    for_each = var.cloudtrail_event_selector

    content {
      read_write_type           = lookup(event_selector.value, "read_write_type", null)
      include_management_events = lookup(event_selector.value, "include_management_events", null)

      dynamic "data_resource" {
        iterator = data_resource
        for_each = length(keys(lookup(event_selector.value, "data_resource", {}))) > 0 ? [lookup(event_selector.value, "data_resource", {})] : []

        content {
          type   = lookup(data_resource.value, "type", null)
          values = lookup(data_resource.value, "values", null)
        }
      }
    }
  }

  tags = merge(
    {
      Name = var.cloudtrail_name != "" ? lower(var.cloudtrail_name) : "${lower(var.name)}-cloudtrail-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
