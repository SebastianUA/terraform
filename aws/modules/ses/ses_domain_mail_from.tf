#---------------------------------------------------
# AWS ses domain email from
#---------------------------------------------------
resource "aws_ses_domain_mail_from" "ses_domain_mail_from" {
  count = var.enable_ses_domain_mail_from ? 1 : 0

  domain           = var.ses_domain_mail_from_domain != "" ? var.ses_domain_mail_from_domain : (var.enable_ses_domain_identity ? element(aws_ses_domain_identity.ses_domain_identity.*.domain, count.index) : null)
  mail_from_domain = var.ses_domain_mail_from_mail_from_domain != "" ? var.ses_domain_mail_from_mail_from_domain : (var.enable_ses_domain_identity ? "bounce.${aws_ses_domain_identity.ses_domain_identity[count.index].domain}" : null)

  behavior_on_mx_failure = var.ses_domain_mail_from_behavior_on_mx_failure

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_ses_domain_identity.ses_domain_identity
  ]
}