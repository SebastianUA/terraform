#---------------------------------------------------
# AWS Codecommit approval rule template association
#---------------------------------------------------
resource "aws_codecommit_approval_rule_template_association" "codecommit_approval_rule_template_association" {
  count = var.enable_codecommit_approval_rule_template_association ? 1 : 0

  approval_rule_template_name = var.codecommit_approval_rule_template_association_approval_rule_template_name != "" ? var.codecommit_approval_rule_template_association_approval_rule_template_name : (var.enable_codecommit_approval_rule_template ? aws_codecommit_approval_rule_template.codecommit_approval_rule_template[count.index].name : null)
  repository_name             = var.codecommit_approval_rule_template_association_repository_name != "" ? var.codecommit_approval_rule_template_association_repository_name : (var.enable_codecommit_repository ? aws_codecommit_repository.codecommit_repository[count.index].repository_name : null)

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}