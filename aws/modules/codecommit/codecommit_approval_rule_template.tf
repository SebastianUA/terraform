#---------------------------------------------------
# AWS Codecommit approval rule template
#---------------------------------------------------
resource "aws_codecommit_approval_rule_template" "codecommit_approval_rule_template" {
  count = var.enable_codecommit_approval_rule_template ? 1 : 0

  name    = var.codecommit_approval_rule_template_name != "" ? var.codecommit_approval_rule_template_name : "${lower(var.name)}-codecommit-approval-rule-template-${lower(var.environment)}"
  content = var.codecommit_approval_rule_template_content

  description = var.codecommit_approval_rule_template_description

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}