#---------------------------------------------------
# Create AWS CloudWatch metric alarm
#---------------------------------------------------
resource "aws_cloudwatch_metric_alarm" "cw_metric_alarm" {
  count = var.enable_cw_metric_alarm ? 1 : 0

  alarm_name        = var.alarm_name != "" ? var.alarm_name : "${lower(var.name)}-cw_metric-${lower(var.environment)}"
  alarm_description = var.alarm_description
  actions_enabled   = var.actions_enabled

  comparison_operator = var.comparison_operator
  evaluation_periods  = var.evaluation_periods
  threshold           = var.threshold
  unit                = var.unit

  alarm_actions             = var.alarm_actions
  ok_actions                = var.ok_actions
  insufficient_data_actions = var.insufficient_data_actions

  datapoints_to_alarm                   = var.datapoints_to_alarm
  treat_missing_data                    = var.treat_missing_data
  evaluate_low_sample_count_percentiles = var.evaluate_low_sample_count_percentiles

  dimensions = var.dimensions

  # conflicts with metric_query
  metric_name        = var.metric_name
  namespace          = var.namespace
  period             = var.period
  extended_statistic = var.extended_statistic
  statistic          = var.statistic

  # conflicts with metric_name
  dynamic "metric_query" {
    iterator = metric_query
    for_each = var.metric_query
    content {
      id = lookup(metric_query.value, "id", null)

      expression  = lookup(metric_query.value, "expression", null)
      label       = lookup(metric_query.value, "label", null)
      return_data = lookup(metric_query.value, "return_data", null)

      metric {
        metric_name = lookup(metric_query.value, "metric_name", null)
        namespace   = lookup(metric_query.value, "namespace", null)
        period      = lookup(metric_query.value, "period", null)
        stat        = lookup(metric_query.value, "stat", null)
        unit        = lookup(metric_query.value, "unit", null)
        dimensions  = lookup(memetric_querytric.value, "dimensions", null)
      }
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
