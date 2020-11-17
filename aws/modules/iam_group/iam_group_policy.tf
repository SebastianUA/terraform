#-----------------------------------------------------------
# IAM group policy
#-----------------------------------------------------------
resource "aws_iam_group_policy" "iam_group_policy" {
  count = var.enable_iam_group_policy ? 1 : 0

  name        = var.iam_group_policy_name != "" && var.iam_group_policy_name_prefix == "" ? lower(var.iam_group_policy_name) : null
  name_prefix = var.iam_group_policy_name_prefix != "" && var.iam_group_policy_name == "" ? lower(var.iam_group_policy_name_prefix) : null

  group  = var.iam_group_policy_group != "" ? var.iam_group_policy_group : element(concat(aws_iam_group.iam_group.*.id, [""]), 0)
  policy = var.iam_group_policy

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_iam_group.iam_group
  ]
}
