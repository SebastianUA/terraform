#---------------------------------------------------
# ssoadmin permission set inline policy
#---------------------------------------------------
resource "aws_ssoadmin_permission_set_inline_policy" "ssoadmin_permission_set_inline_policy" {
  count = var.enable_ssoadmin_permission_set_inline_policy ? length(var.ssoadmin_permission_set_inline_policy_inline_policies) : 0

  inline_policy      = var.ssoadmin_permission_set_inline_policy_inline_policies[count.index]
  instance_arn       = var.ssoadmin_permission_set_inline_policy_instance_arn != "" ? var.ssoadmin_permission_set_inline_policy_instance_arn : (var.enable_ssoadmin_permission_set ? aws_ssoadmin_permission_set.ssoadmin_permission_set[0].instance_arn : null)
  permission_set_arn = var.ssoadmin_permission_set_inline_policy_permission_set_arn != "" ? var.ssoadmin_permission_set_inline_policy_permission_set_arn : (var.enable_ssoadmin_permission_set ? aws_ssoadmin_permission_set.ssoadmin_permission_set[0].arn : null)

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_ssoadmin_permission_set.ssoadmin_permission_set
  ]
}