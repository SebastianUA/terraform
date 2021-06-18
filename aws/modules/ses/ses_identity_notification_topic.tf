#---------------------------------------------------
# AWS ses identity notification topic
#---------------------------------------------------
resource "aws_ses_identity_notification_topic" "ses_identity_notification_topic" {
  count = var.enable_ses_identity_notification_topic ? 1 : 0

  notification_type = var.ses_identity_notification_topic_notification_type
  identity          = var.ses_identity_notification_topic_identity != "" ? var.ses_identity_notification_topic_identity : (var.enable_ses_domain_identity ? element(aws_ses_domain_identity.ses_domain_identity.*.domain, count.index) : null)

  topic_arn                = var.ses_identity_notification_topic_topic_arn
  include_original_headers = var.ses_identity_notification_topic_include_original_headers

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_ses_domain_identity.ses_domain_identity
  ]
}