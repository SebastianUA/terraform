#---------------------------------------------------
# AWS ses active receipt rule set
#---------------------------------------------------
resource "aws_ses_active_receipt_rule_set" "ses_active_receipt_rule_set" {
  count = var.enable_ses_active_receipt_rule_set ? 1 : 0

  rule_set_name = var.ses_active_receipt_rule_set_rule_set_name != "" ? var.ses_active_receipt_rule_set_rule_set_name : "${lower(var.name)}-ses-active-receipt-rule-set-${lower(var.environment)}"

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}