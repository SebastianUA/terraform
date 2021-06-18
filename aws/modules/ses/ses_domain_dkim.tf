#---------------------------------------------------
# AWS ses domain dkim
#---------------------------------------------------
resource "aws_ses_domain_dkim" "ses_domain_dkim" {
  count = var.enable_ses_domain_dkim ? 1 : 0

  domain = var.ses_domain_dkim_domain != "" ? var.ses_domain_dkim_domain : (var.enable_ses_domain_identity ? aws_ses_domain_identity.ses_domain_identity[count.index].domain : null)

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}