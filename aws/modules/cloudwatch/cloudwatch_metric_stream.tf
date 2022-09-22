#---------------------------------------------------
# AWS CloudWatch metric stream
#---------------------------------------------------
resource "aws_cloudwatch_metric_stream" "cw_metric_stream" {
  count = var.enable_cw_metric_stream ? 1 : 0

  firehose_arn  = var.cw_metric_stream_firehose_arn
  role_arn      = var.cw_metric_stream_role_arn
  output_format = var.cw_metric_stream_output_format

  name        = var.cw_metric_stream_name != "" ? var.cw_metric_stream_name : "${lower(var.name)}-cw-metric-stream-${lower(var.environment)}"
  name_prefix = var.cw_metric_stream_name_prefix

  dynamic "exclude_filter" {
    iterator = exclude_filter
    for_each = var.cw_metric_stream_exclude_filter

    content {
      namespace = lookup(exclude_filter.value, "namespace", null)
    }
  }

  dynamic "include_filter" {
    iterator = include_filter
    for_each = var.cw_metric_stream_include_filter

    content {
      namespace = lookup(include_filter.value, "namespace", null)
    }
  }

  # dynamic "statistics_configuration" {
  #   iterator = statistics_configuration
  #   for_each = var.cw_metric_stream_statistics_configuration

  #   content {
  #     additional_statistics = lookup(statistics_configuration.value, "additional_statistics", null)

  #     dynamic "include_metric" {
  #       iterator = include_metric
  #       for_each = length(keys(lookup(statistics_configuration.value, "include_metric", {}))) > 0 ? [lookup(statistics_configuration.value, "include_metric", {})] : []

  #       content {
  #         metric_name = lookup(include_metric.value, "metric_name", null)
  #         namespace   = lookup(include_metric.value, "namespace", null)
  #       }
  #     }
  #   }
  # }

  tags = merge(
    {
      Name = var.cw_metric_stream_name != "" ? var.cw_metric_stream_name : "${lower(var.name)}-cw-metric-stream-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}