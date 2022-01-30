#---------------------------------------------------
# AWS SNS topic
#---------------------------------------------------
resource "aws_sns_topic" "sns_topic" {
  count = var.enable_sns_topic ? 1 : 0

  name            = var.sns_topic_name != "" && var.sns_topic_name_prefix == "" ? var.sns_topic_name : null
  name_prefix     = var.sns_topic_name_prefix != "" && var.sns_topic_name == "" ? var.sns_topic_name_prefix : null
  display_name    = var.sns_topic_display_name != "" ? var.sns_topic_display_name : "${lower(var.name)}-sns-${lower(var.environment)}"
  policy          = var.sns_topic_policy
  delivery_policy = var.sns_topic_delivery_policy

  application_success_feedback_role_arn    = var.sns_topic_application_success_feedback_role_arn
  application_success_feedback_sample_rate = var.sns_topic_application_success_feedback_sample_rate
  application_failure_feedback_role_arn    = var.sns_topic_application_failure_feedback_role_arn

  http_success_feedback_role_arn    = var.sns_topic_http_success_feedback_role_arn
  http_success_feedback_sample_rate = var.sns_topic_http_success_feedback_sample_rate
  http_failure_feedback_role_arn    = var.sns_topic_http_failure_feedback_role_arn

  kms_master_key_id = var.sns_topic_kms_master_key_id

  lambda_success_feedback_role_arn    = var.sns_topic_lambda_success_feedback_role_arn
  lambda_success_feedback_sample_rate = var.sns_topic_lambda_success_feedback_sample_rate
  lambda_failure_feedback_role_arn    = var.sns_topic_lambda_failure_feedback_role_arn

  sqs_success_feedback_role_arn    = var.sns_topic_sqs_success_feedback_role_arn
  sqs_success_feedback_sample_rate = var.sns_topic_sqs_success_feedback_sample_rate
  sqs_failure_feedback_role_arn    = var.sns_topic_sqs_failure_feedback_role_arn

  tags = merge(
    {
      Name = var.sns_topic_display_name != "" ? var.sns_topic_display_name : "${lower(var.name)}-sns-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
