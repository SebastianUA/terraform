#-----------------------------------------------------------
# IAM iam user group membership
#-----------------------------------------------------------
resource "aws_iam_user_group_membership" "iam_user_group_membership" {
  count = var.enable_iam_user_group_membership ? 1 : 0

  user   = var.iam_user_group_membership_user != "" && ! var.enable_iam_user ? var.iam_user_group_membership_user : element(concat(aws_iam_user.iam_user.*.name, [""]), 0)
  groups = var.iam_user_group_membership_groups

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_iam_user.iam_user
  ]
}
