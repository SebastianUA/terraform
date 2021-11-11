#---------------------------------------------------
# AWS SNS topic policies
#---------------------------------------------------
resource "aws_sns_topic_policy" "sns_topic_policy" {
  count = var.enable_sns_topic_policy ? 1 : 0

  arn    = var.sns_topic_policy_topic_arn != null ? var.sns_topic_policy_topic_arn : (var.enable_sns_topic ? element(concat(aws_sns_topic.sns_topic.*.arn, [""]), 0) : null)
  policy = var.sns_topic_policy_policy

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_sns_topic.sns_topic
  ]
}
