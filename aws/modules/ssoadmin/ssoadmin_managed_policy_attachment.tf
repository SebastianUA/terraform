#---------------------------------------------------
# ssoadmin managed policy attachment
#---------------------------------------------------
resource "aws_ssoadmin_managed_policy_attachment" "ssoadmin_managed_policy_attachment" {
  count = var.enable_ssoadmin_managed_policy_attachment ? length(var.ssoadmin_managed_policy_attachment_managed_policy_arns) : 0

  instance_arn       = var.ssoadmin_managed_policy_attachment_instance_arn != "" ? var.ssoadmin_managed_policy_attachment_instance_arn : (var.enable_ssoadmin_permission_set ? aws_ssoadmin_permission_set.ssoadmin_permission_set[0].instance_arn : null)
  managed_policy_arn = var.ssoadmin_managed_policy_attachment_managed_policy_arns[count.index]
  permission_set_arn = var.ssoadmin_managed_policy_attachment_permission_set_arn != "" ? var.ssoadmin_managed_policy_attachment_permission_set_arn : (var.enable_ssoadmin_permission_set ? aws_ssoadmin_permission_set.ssoadmin_permission_set[0].arn : null)

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_ssoadmin_permission_set.ssoadmin_permission_set
  ]
}