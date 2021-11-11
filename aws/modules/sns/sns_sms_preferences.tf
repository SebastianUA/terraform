#---------------------------------------------------
# AWS SNS sms preferences
#---------------------------------------------------
resource "aws_sns_sms_preferences" "sns_sms_preferences" {
  count = var.enable_sns_sms_preferences ? 1 : 0

  monthly_spend_limit                   = var.sns_sms_preferences_monthly_spend_limit
  delivery_status_iam_role_arn          = var.sns_sms_preferences_delivery_status_iam_role_arn
  delivery_status_success_sampling_rate = var.sns_sms_preferences_delivery_status_success_sampling_rate
  default_sender_id                     = var.sns_sms_preferences_default_sender_id
  default_sms_type                      = var.sns_sms_preferences_default_sms_type
  usage_report_s3_bucket                = var.sns_sms_preferences_usage_report_s3_bucket

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
