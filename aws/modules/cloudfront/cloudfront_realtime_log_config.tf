#---------------------------------------------------
# AWS cloudfront realtime log config
#---------------------------------------------------
resource "aws_cloudfront_realtime_log_config" "cloudfront_realtime_log_config" {
  count = var.enable_cloudfront_realtime_log_config ? 1 : 0

  name          = var.cloudfront_realtime_log_config_name != "" ? var.cloudfront_realtime_log_config_name : "${lower(var.name)}-cloudfront-realtime-log-config-${lower(var.environment)}"
  sampling_rate = var.cloudfront_realtime_log_config_sampling_rate
  fields        = var.cloudfront_realtime_log_config_fields

  dynamic "endpoint" {
    iterator = endpoint
    for_each = length(keys(lookup(var.cloudfront_realtime_log_config_endpoints[count.index], "endpoint", {}))) > 0 ? [lookup(var.cloudfront_realtime_log_config_endpoints[count.index], "endpoint", {})] : []

    content {
      stream_type = lookup(endpoint.value, "stream_type", null)

      dynamic "kinesis_stream_config" {
        iterator = kinesis_stream_config
        for_each = length(keys(lookup(endpoint.value, "kinesis_stream_config", {}))) > 0 ? [lookup(endpoint.value, "kinesis_stream_config", {})] : []

        content {
          role_arn   = lookup(kinesis_stream_config.value, "role_arn", null)
          stream_arn = lookup(kinesis_stream_config.value, "stream_arn", null)
        }
      }
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}