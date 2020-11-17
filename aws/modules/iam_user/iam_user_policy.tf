#-----------------------------------------------------------
# IAM user policy
#-----------------------------------------------------------
resource "aws_iam_user_policy" "iam_user_policy" {
  count = var.enable_iam_user_policy ? 1 : 0

  name        = var.iam_user_policy_name != "" && var.iam_user_policy_name_prefix == "" ? var.iam_user_policy_name : null
  name_prefix = var.iam_user_policy_name_prefix != "" && var.iam_user_policy_name == "" ? var.iam_user_policy_name_prefix : null

  user   = var.iam_user_policy_user != "" && ! var.enable_iam_user ? var.iam_user_policy_user : element(concat(aws_iam_user.iam_user.*.id, [""]), 0)
  policy = var.iam_user_policy_policy

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_iam_user.iam_user
  ]
}
