#---------------------------------------------------
# AWS ses email identity
#---------------------------------------------------
resource "aws_ses_email_identity" "ses_email_identity" {
  count = var.enable_ses_email_identity ? length(var.ses_email_identity_emails) : 0

  email = var.ses_email_identity_emails[count.index]

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
