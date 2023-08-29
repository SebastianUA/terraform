#---------------------------------------------------
# Cloudwatch event archive
#---------------------------------------------------
resource "aws_cloudwatch_event_archive" "cloudwatch_event_archive" {
  count = var.enable_cloudwatch_event_archive ? 1 : 0

  name             = var.cloudwatch_event_archive_name != "" ? var.cloudwatch_event_archive_name : "${lower(var.name)}-cw-event-archive-${lower(var.environment)}"
  event_source_arn = var.cloudwatch_event_archive_event_source_arn

  description    = var.cloudwatch_event_archive_description
  event_pattern  = var.cloudwatch_event_archive_event_pattern
  retention_days = var.cloudwatch_event_archive_retention_days

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}