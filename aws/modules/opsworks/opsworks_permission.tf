#---------------------------------------------------
# AWS opsworks permission
#---------------------------------------------------
resource "aws_opsworks_permission" "opsworks_permission" {
  count = var.enable_opsworks_permission ? 1 : 0

  stack_id = var.opsworks_permission_stack_id != "" && !var.enable_opsworks_stack ? var.opsworks_permission_stack_id : element(concat(aws_opsworks_stack.opsworks_stack.*.id, [""]), 0)
  user_arn = var.opsworks_permission_user_arn

  allow_ssh  = var.opsworks_permission_allow_ssh
  allow_sudo = var.opsworks_permission_allow_sudo
  level      = lower(var.opsworks_permission_level)

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_opsworks_stack.opsworks_stack
  ]
}
