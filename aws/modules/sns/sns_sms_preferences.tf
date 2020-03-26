#---------------------------------------------------
# Create AWS SNS sms preferences
#---------------------------------------------------
resource "aws_sns_sms_preferences" "sns_sms_preferences" {
    count                                   = var.enable_sns_sms_preferences ? 1 : 0

    monthly_spend_limit                     = var.monthly_spend_limit
    delivery_status_iam_role_arn            = var.delivery_status_iam_role_arn
    delivery_status_success_sampling_rate   = var.delivery_status_success_sampling_rate
    default_sender_id                       = var.default_sender_id
    default_sms_type                        = var.default_sms_type
    usage_report_s3_bucket                  = var.usage_report_s3_bucket

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on                              = []
}
