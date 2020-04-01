#---------------------------------------------------
# AWS VPC flow log
#---------------------------------------------------
resource "aws_flow_log" "flow_log" {
    count                       = var.enable_flow_log ? 1 : 0

    traffic_type                = upper(var.flow_log_traffic_type)

    eni_id                      = var.flow_log_eni_id
    iam_role_arn                = var.flow_log_iam_role_arn
    log_destination_type        = var.flow_log_log_destination_type
    log_destination             = var.flow_log_log_destination
    subnet_id                   = var.flow_log_subnet_id
    vpc_id                      = var.vpc_id != "" && !var.enable_vpc ? var.vpc_id : element(concat(aws_vpc.vpc.*.id, [""]), 0)
    log_format                  = var.flow_log_log_format
    max_aggregation_interval    = var.flow_log_max_aggregation_interval

    tags                        = merge(
        {
            "Name"  = var.flow_log_name != "" ? lower(var.flow_log_name) : "${lower(var.name)}-flow-log-${lower(var.environment)}"
        },
        var.tags
    )

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on                  = [
        aws_vpc.vpc
    ]
}
