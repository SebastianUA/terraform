#---------------------------------------------------
# AWS SNS platform application
#---------------------------------------------------
resource "aws_sns_platform_application" "sns_platform_application" {
  count = var.enable_sns_platform_application ? 1 : 0

  name                = var.sns_platform_application_name != "" ? var.sns_platform_application_name : "${lower(var.name)}-sns-plat-app-${lower(var.environment)}"
  platform            = var.sns_platform_application_platform
  platform_credential = var.sns_platform_application_platform_credential

  event_delivery_failure_topic_arn = var.sns_platform_application_event_delivery_failure_topic_arn
  event_endpoint_created_topic_arn = var.sns_platform_application_event_endpoint_created_topic_arn
  event_endpoint_deleted_topic_arn = var.sns_platform_application_event_endpoint_deleted_topic_arn
  event_endpoint_updated_topic_arn = var.sns_platform_application_event_endpoint_updated_topic_arn

  failure_feedback_role_arn    = var.sns_platform_application_failure_feedback_role_arn
  platform_principal           = var.sns_platform_application_platform_principal
  success_feedback_role_arn    = var.sns_platform_application_success_feedback_role_arn
  success_feedback_sample_rate = var.sns_platform_application_success_feedback_sample_rate

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
