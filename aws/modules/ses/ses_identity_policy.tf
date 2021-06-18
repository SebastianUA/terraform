#---------------------------------------------------
# AWS ses identity policy
#---------------------------------------------------
resource "aws_ses_identity_policy" "ses_identity_policy" {
  count = var.enable_ses_identity_policy ? 1 : 0

  name     = var.ses_identity_policy_name != "" ? var.ses_identity_policy_name : "${lower(var.name)}-ses-identity-policy-${lower(var.environment)}"
  identity = var.ses_identity_policy_identity != "" ? var.ses_identity_policy_identity : (var.enable_ses_domain_identity ? element(aws_ses_domain_identity.ses_domain_identity.*.arn, count.index) : null)
  policy   = var.ses_identity_policy_policy

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}