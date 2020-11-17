#---------------------------------------------------
# AWS cloudformation
#---------------------------------------------------
resource "aws_cloudformation_stack" "cloudformation_stack" {
  count = var.enable_cloudformation_stack ? 1 : 0

  name = var.cloudformation_stack_name != "" ? lower(var.cloudformation_stack_name) : "${lower(var.name)}-cloudformation-stack-${lower(var.environment)}"

  template_body      = var.cloudformation_stack_template_body
  template_url       = var.cloudformation_stack_template_url
  capabilities       = var.cloudformation_stack_capabilities
  disable_rollback   = var.cloudformation_stack_disable_rollback
  notification_arns  = var.cloudformation_stack_notification_arns
  on_failure         = var.cloudformation_stack_on_failure
  policy_body        = var.cloudformation_stack_policy_body
  policy_url         = var.cloudformation_stack_policy_url
  iam_role_arn       = var.cloudformation_stack_iam_role_arn
  timeout_in_minutes = var.cloudformation_stack_timeout_in_minutes

  parameters = var.cloudformation_stack_parameters

  tags = merge(
    {
      "Name" = var.cloudformation_stack_name != "" ? lower(var.cloudformation_stack_name) : "${lower(var.name)}-cloudformation-stack-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
