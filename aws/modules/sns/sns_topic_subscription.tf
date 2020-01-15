#---------------------------------------------------
# Create AWS SNS topic subscription
#---------------------------------------------------
resource "aws_sns_topic_subscription" "sns_topic_subscription" {
    count                           = var.enable_sns_topic_subscription ? 1 : 0

    topic_arn                       = var.topic_arn != "" ? var.topic_arn : element(concat(aws_sns_topic.sns_topic.*.arn, [""]), 0)

    confirmation_timeout_in_minutes = var.confirmation_timeout_in_minutes
    endpoint_auto_confirms          = var.endpoint_auto_confirms
    raw_message_delivery            = var.raw_message_delivery

    protocol                        = var.sns_protocol
    endpoint                        = var.sns_endpoint

    filter_policy                   = var.filter_policy
    delivery_policy                 = var.sns_topic_delivery_policy

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on = [
        aws_sns_topic.sns_topic
    ]
}