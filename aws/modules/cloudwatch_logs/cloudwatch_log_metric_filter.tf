#---------------------------------------------------
# AWS CloudWatch LOG metric filter
#---------------------------------------------------
resource "aws_cloudwatch_log_metric_filter" "cw_log_metric_filter" {
  count = var.enable_cw_log_metric_filter ? 1 : 0

  name           = var.cw_log_metric_filter_name
  pattern        = var.cw_log_metric_filter_pattern
  log_group_name = var.cw_log_group_name != "" ? var.cw_log_group_name : element(concat(aws_cloudwatch_log_group.cw_log_group.*.id, [""]), 0)

  dynamic "metric_transformation" {
    iterator = metric_transformation
    for_each = var.cw_log_metric_filter_metric_transformation
    content {
      name      = lookup(metric_transformation.value, "name", null)
      namespace = lookup(metric_transformation.value, "namespace", null)
      value     = lookup(metric_transformation.value, "value", null)

      default_value = lookup(metric_transformation.value, "default_value", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_cloudwatch_log_group.cw_log_group
  ]
}
