#---------------------------------------------------
# Cloudwatch event api destination
#---------------------------------------------------
resource "aws_cloudwatch_event_api_destination" "cloudwatch_event_api_destination" {
  count = var.enable_cloudwatch_event_api_destination ? 1 : 0

  name                = var.cloudwatch_event_api_destination_name != "" ? var.cloudwatch_event_api_destination_name : "${lower(var.name)}-cw-event-api-dst-${lower(var.environment)}"
  invocation_endpoint = var.cloudwatch_event_api_destination_invocation_endpoint
  http_method         = var.cloudwatch_event_api_destination_http_method
  connection_arn      = var.cloudwatch_event_api_destination_connection_arn

  description                      = var.cloudwatch_event_api_destination_description
  invocation_rate_limit_per_second = var.cloudwatch_event_api_destination_invocation_rate_limit_per_second

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
