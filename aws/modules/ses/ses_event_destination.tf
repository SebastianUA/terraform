#---------------------------------------------------
# AWS ses event destination
#---------------------------------------------------
resource "aws_ses_event_destination" "ses_event_destination" {
  count = var.enable_ses_event_destination ? 1 : 0

  name                   = var.ses_event_destination_name != "" ? var.ses_event_destination_name : "${lower(var.name)}-ses-event-destination-${lower(var.environment)}"
  configuration_set_name = var.ses_event_destination_configuration_set_name != "" ? var.ses_event_destination_configuration_set_name : (var.enable_ses_configuration_set ? aws_ses_configuration_set.ses_configuration_set[count.index].name : null)
  matching_types         = var.ses_event_destination_matching_types

  enabled = var.ses_event_destination_enabled

  dynamic "cloudwatch_destination" {
    iterator = cloudwatch_destination
    for_each = var.ses_event_destination_cloudwatch_destination

    content {
      default_value  = lookup(cloudwatch_destination.value, "default_value", null)
      dimension_name = lookup(cloudwatch_destination.value, "dimension_name", null)
      value_source   = lookup(cloudwatch_destination.value, "value_source", null)
    }
  }

  dynamic "kinesis_destination" {
    iterator = kinesis_destination
    for_each = var.ses_event_destination_kinesis_destination

    content {
      stream_arn = lookup(kinesis_destination.value, "stream_arn", null)
      role_arn   = lookup(kinesis_destination.value, "role_arn", null)
    }
  }

  dynamic "sns_destination" {
    iterator = sns_destination
    for_each = var.ses_event_destination_sns_destination

    content {
      topic_arn = lookup(sns_destination.value, "topic_arn", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_ses_configuration_set.ses_configuration_set
  ]
}