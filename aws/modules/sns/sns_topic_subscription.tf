#---------------------------------------------------
# AWS SNS topic subscription
#---------------------------------------------------
resource "aws_sns_topic_subscription" "sns_topic_subscription" {
  count = var.enable_sns_topic_subscription ? length(var.sns_topic_subscription_sns_endpoints) : 0

  topic_arn = var.sns_topic_subscription_topic_arn != "" ? var.sns_topic_subscription_topic_arn : element(concat(aws_sns_topic.sns_topic.*.arn, [""]), 0)

  confirmation_timeout_in_minutes = var.sns_topic_subscription_confirmation_timeout_in_minutes
  endpoint_auto_confirms          = var.sns_topic_subscription_endpoint_auto_confirms
  raw_message_delivery            = var.sns_topic_subscription_raw_message_delivery

  protocol = var.sns_topic_subscription_sns_protocol
  endpoint = var.sns_topic_subscription_sns_endpoints[count.index]

  filter_policy   = var.sns_topic_subscription_filter_policy
  delivery_policy = var.sns_topic_subscription_delivery_policy

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_sns_topic.sns_topic
  ]
}
