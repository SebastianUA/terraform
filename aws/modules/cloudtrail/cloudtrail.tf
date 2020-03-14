resource "aws_cloudtrail" "cloudtrail" {
    count                           = var.enable_cloudtrail && !var.enable_cloudtrail_event_selector ? 1 : 0

    name                            = var.cloudtrail_name != "" ? lower(var.cloudtrail_name) : "${lower(var.name)}-ct-${lower(var.environment)}"
    s3_bucket_name                  = var.s3_bucket_name
    s3_key_prefix                   = var.s3_key_prefix

    cloud_watch_logs_role_arn       = var.cloud_watch_logs_role_arn
    cloud_watch_logs_group_arn      = var.cloud_watch_logs_group_arn

    enable_logging                  = var.enable_logging
    enable_log_file_validation      = var.enable_log_file_validation
    include_global_service_events   = var.include_global_service_events
    sns_topic_name                  = var.sns_topic_name
    kms_key_id                      = var.kms_key_id

    is_multi_region_trail           = var.is_multi_region_trail
    is_organization_trail           = var.is_organization_trail

    tags                            = merge(
        {
            "Name"          = var.cloudtrail_name != "" ? lower(var.cloudtrail_name) : "${lower(var.name)}-ct-${lower(var.environment)}"
        },
        var.tags,
    )

    lifecycle {
        create_before_destroy = true
    }

    depends_on                      = []
}

resource "aws_cloudtrail" "cloudtrail_event_selector" {
    count                           = var.enable_cloudtrail && var.enable_cloudtrail_event_selector ? 1 : 0

    name                            = var.cloudtrail_name != "" ? lower(var.cloudtrail_name) : "${lower(var.name)}-ct-event-selector-${lower(var.environment)}"
    s3_bucket_name                  = var.s3_bucket_name
    s3_key_prefix                   = var.s3_key_prefix

    cloud_watch_logs_role_arn       = var.cloud_watch_logs_role_arn
    cloud_watch_logs_group_arn      = var.cloud_watch_logs_group_arn

    enable_logging                  = var.enable_logging
    enable_log_file_validation      = var.enable_log_file_validation
    include_global_service_events   = var.include_global_service_events
    sns_topic_name                  = var.sns_topic_name
    kms_key_id                      = var.kms_key_id

    is_multi_region_trail           = var.is_multi_region_trail
    is_organization_trail           = var.is_organization_trail

    event_selector {
        read_write_type           = var.event_selector_read_write_type
        include_management_events = var.event_selector_include_management_events

        data_resource {
            type   = var.event_selector_data_resource_type
            values = var.event_selector_data_resource_values
        }
    }

    tags                            = merge(
        {
            "Name"          = var.cloudtrail_name != "" ? lower(var.cloudtrail_name) : "${lower(var.name)}-ct-event-selector-${lower(var.environment)}"
        },
        var.tags,
    )

    lifecycle {
        create_before_destroy = true
    }

    depends_on                      = []
}
