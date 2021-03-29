#---------------------------------------------------
# AWS serverlessapplicationrepository cloudformation stack
#---------------------------------------------------
resource "aws_serverlessapplicationrepository_cloudformation_stack" "serverlessapplicationrepository_cloudformation_stack" {
  count = var.enable_serverlessapplicationrepository_cloudformation_stack ? 1 : 0

  name           = var.serverlessapplicationrepository_cloudformation_stack_name != "" ? lower(var.serverlessapplicationrepository_cloudformation_stack_name) : "${lower(var.name)}-serverlessapplicationrepository-cloudformation-stack-${lower(var.environment)}"
  application_id = var.serverlessapplicationrepository_cloudformation_stack_application_id
  capabilities   = var.serverlessapplicationrepository_cloudformation_stack_capabilities

  parameters       = var.serverlessapplicationrepository_cloudformation_stack_parameters
  semantic_version = var.serverlessapplicationrepository_cloudformation_stack_semantic_version

  tags = merge(
    {
      Name = var.serverlessapplicationrepository_cloudformation_stack_name != "" ? lower(var.serverlessapplicationrepository_cloudformation_stack_name) : "${lower(var.name)}-serverlessapplicationrepository-cloudformation-stack-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
