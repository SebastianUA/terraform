#---------------------------------------------------
# Cloudwatch metric alarm
#---------------------------------------------------
resource "aws_cloudwatch_metric_alarm" "cw_metric_alarm" {
  count = var.enable_cw_metric_alarm ? 1 : 0

  alarm_name          = var.cw_metric_alarm_name != "" ? var.cw_metric_alarm_name : "${lower(var.name)}-cw-metric-alarm-${lower(var.environment)}"
  comparison_operator = var.cw_metric_alarm_comparison_operator
  evaluation_periods  = var.cw_metric_alarm_evaluation_periods

  metric_name                           = var.cw_metric_alarm_metric_name
  namespace                             = var.cw_metric_alarm_namespace
  period                                = var.cw_metric_alarm_period
  statistic                             = var.cw_metric_alarm_statistic
  threshold                             = var.cw_metric_alarm_threshold
  threshold_metric_id                   = var.cw_metric_alarm_threshold_metric_id
  actions_enabled                       = var.cw_metric_alarm_actions_enabled
  alarm_actions                         = var.cw_metric_alarm_actions
  alarm_description                     = var.cw_metric_alarm_description
  datapoints_to_alarm                   = var.cw_metric_alarm_datapoints_to_alarm
  dimensions                            = var.cw_metric_alarm_dimensions
  insufficient_data_actions             = var.cw_metric_alarm_insufficient_data_actions
  ok_actions                            = var.cw_metric_alarm_ok_actions
  unit                                  = var.cw_metric_alarm_unit
  extended_statistic                    = var.cw_metric_alarm_extended_statistic
  treat_missing_data                    = var.cw_metric_alarm_treat_missing_data
  evaluate_low_sample_count_percentiles = var.cw_metric_alarm_evaluate_low_sample_count_percentiles

  dynamic "metric_query" {
    iterator = metric_query
    for_each = var.cw_metric_alarm_metric_query

    content {
      id = lookup(metric_query.value, "id", null)

      account_id  = lookup(metric_query.value, "account_id", null)
      expression  = lookup(metric_query.value, "expression", null)
      label       = lookup(metric_query.value, "label", null)
      return_data = lookup(metric_query.value, "return_data", null)

      dynamic "metric" {
        iterator = metric
        for_each = length(keys(lookup(metric_query.value, "metric", {}))) > 0 ? [lookup(metric_query.value, "metric", {})] : []

        content {
          metric_name = lookup(metric.value, "metric_name", null)
          namespace   = lookup(metric.value, "namespace", null)
          period      = lookup(metric.value, "period", null)
          stat        = lookup(metric.value, "stat", null)

          dimensions = lookup(metric.value, "dimensions", null)
          unit       = lookup(metric.value, "unit", null)
        }
      }
    }
  }

  tags = merge(
    {
      Name = var.cw_metric_alarm_name != "" ? var.cw_metric_alarm_name : "${lower(var.name)}-cw-metric-alarm-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}