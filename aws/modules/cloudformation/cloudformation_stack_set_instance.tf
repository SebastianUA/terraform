#---------------------------------------------------
# AWS cloudformation stack set instance
#---------------------------------------------------
resource "aws_cloudformation_stack_set_instance" "cloudformation_stack_set_instance" {
  count = var.enable_cloudformation_stack_set_instance ? 1 : 0

  stack_set_name = var.cloudformation_stack_set_instance_stack_set_name != "" && !var.enable_cloudformation_stack_set ? var.cloudformation_stack_set_instance_stack_set_name : element(concat(aws_cloudformation_stack_set.cloudformation_stack_set.*.name, [""]), 0)

  account_id          = var.cloudformation_stack_set_instance_account_id
  parameter_overrides = var.cloudformation_stack_set_instance_parameter_overrides
  region              = var.region
  retain_stack        = var.cloudformation_stack_set_instance_retain_stack

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.cloudformation_stack_set_instance_timeouts)) > 0 ? [var.cloudformation_stack_set_instance_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_cloudformation_stack_set.cloudformation_stack_set
  ]
}
