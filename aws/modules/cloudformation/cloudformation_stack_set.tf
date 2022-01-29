#---------------------------------------------------
# AWS cloudformation stack set
#---------------------------------------------------
resource "aws_cloudformation_stack_set" "cloudformation_stack_set" {
  count = var.enable_cloudformation_stack_set ? 1 : 0

  name                    = var.cloudformation_stack_set_name != "" ? lower(var.cloudformation_stack_set_name) : "${lower(var.name)}-cloudformation-stack-set-${lower(var.environment)}"
  administration_role_arn = var.cloudformation_stack_set_administration_role_arn

  capabilities        = var.cloudformation_stack_set_capabilities
  description         = var.cloudformation_stack_set_description
  execution_role_name = var.cloudformation_stack_set_execution_role_name
  parameters          = var.cloudformation_stack_set_parameters
  template_body       = var.cloudformation_stack_set_template_body
  template_url        = var.cloudformation_stack_set_template_url

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.cloudformation_stack_set_timeouts)) > 0 ? [var.cloudformation_stack_set_timeouts] : []

    content {
      update = lookup(timeouts.value, "update", null)
    }
  }

  tags = merge(
    {
      Name = var.cloudformation_stack_set_name != "" ? lower(var.cloudformation_stack_set_name) : "${lower(var.name)}-cloudformation-stack-set-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
