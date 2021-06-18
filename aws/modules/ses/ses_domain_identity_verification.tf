#---------------------------------------------------
# AWS ses domain identity verification
#---------------------------------------------------
resource "aws_ses_domain_identity_verification" "ses_domain_identity_verification" {
  count = var.enable_ses_domain_identity_verification ? 1 : 0

  domain = var.ses_domain_identity_verification_domain != "" ? var.ses_domain_identity_verification_domain : (var.enable_ses_domain_identity ? aws_ses_domain_identity.ses_domain_identity[count.index].id : null)

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}