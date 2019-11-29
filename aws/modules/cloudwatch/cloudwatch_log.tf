#---------------------------------------------------
# Create AWS CloudWatch LOG group
#---------------------------------------------------
resource "aws_cloudwatch_log_group" "cw_log_group" {
    count               = var.enable_cw_log_group ? 1 : 0
    
    name                = var.cw_log_group_name != "" ? var.cw_log_group_name : "${lower(var.name)}-cw_log_group-${lower(var.environment)}"
    retention_in_days   = var.cw_log_group_retention_in_days
    kms_key_id          = var.cw_log_group_kms_key_id
                                
    tags = merge(
        var.tags,
        {
            "Name"          = var.cw_log_group_name != "" ? var.cw_log_group_name : "${lower(var.name)}-cw_log_group-${lower(var.environment)}"
        },
        {
            "Environment"   = var.environment
        },
        {
            "Orchestration" = var.orchestration
        },
        {
            "Createdby"     = var.createdby
        },
    )

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }   

    depends_on  = []
}

#---------------------------------------------------
# Create AWS CloudWatch LOG stream
#---------------------------------------------------
resource "aws_cloudwatch_log_stream" "cw_log_stream" {
    count               = var.enable_cw_log_stream ? 1 : 0

    name                = var.cloudwatch_log_stream_name
    log_group_name      = var.cw_log_group_name != "" ? var.cw_log_group_name : element(concat(aws_cloudwatch_log_group.cw_log_group.*.id, [""]), 0)
    

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }   

    depends_on  = [
        aws_cloudwatch_log_group.cw_log_group
    ]
}

#---------------------------------------------------
# Create AWS CloudWatch LOG metric filter
#---------------------------------------------------
resource "aws_cloudwatch_log_metric_filter" "cw_log_metric_filter" {
    count               = var.enable_cw_log_metric_filter ? 1 : 0
                        
    name                = var.cw_log_metric_filter_name
    pattern             = var.cw_log_metric_filter_pattern
    log_group_name      = var.cw_log_group_name != "" ? var.cw_log_group_name : element(concat(aws_cloudwatch_log_group.cw_log_group.*.id, [""]), 0)
    
    metric_transformation {
        name            = var.metric_transformation_name
        namespace       = var.metric_transformation_namespace
        value           = var.metric_transformation_value
        default_value   = var.metric_transformation_default_value
    }

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }   

    depends_on  = [
        aws_cloudwatch_log_group.cw_log_group
    ]
}