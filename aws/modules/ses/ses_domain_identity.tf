#---------------------------------------------------
# AWS ses domain identity
#---------------------------------------------------
resource "aws_ses_domain_identity" "ses_domain_identity" {
  count = var.enable_ses_domain_identity ? length(var.ses_domain_identity_domains) : 0

  domain = var.ses_domain_identity_domains[count.index]

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}