#---------------------------------------------------
# AWS CloudWatch LOG metric filter
#---------------------------------------------------
resource "aws_cloudwatch_log_metric_filter" "cw_log_metric_filter" {
  count = var.enable_cw_log_metric_filter ? 1 : 0

  name           = var.cw_log_metric_filter_name
  pattern        = var.cw_log_metric_filter_pattern
  log_group_name = var.cw_log_group_name != "" ? var.cw_log_group_name : element(concat(aws_cloudwatch_log_group.cw_log_group.*.id, [""]), 0)

  metric_transformation {
    name          = var.metric_transformation_name
    namespace     = var.metric_transformation_namespace
    value         = var.metric_transformation_value
    default_value = var.metric_transformation_default_value
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_cloudwatch_log_group.cw_log_group
  ]
}
