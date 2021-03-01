#-----------------------------------------------------------
# IAM role policy
#-----------------------------------------------------------
resource "aws_iam_role_policy" "iam_role_policy" {
  count = var.enable_iam_role_policy ? 1 : 0

  name        = var.iam_role_policy_name != "" && var.iam_role_policy_name_prefix == "" ? var.iam_role_policy_name : null
  name_prefix = var.iam_role_policy_name_prefix != "" && var.iam_role_policy_name == "" ? var.iam_role_policy_name_prefix : null

  role   = var.iam_role_policy_role != "" && !var.enable_iam_role ? var.iam_role_policy_role : element(concat(aws_iam_role.iam_role.*.id, [""]), 0)
  policy = var.iam_role_policy

  depends_on = [
    aws_iam_role.iam_role
  ]
}
