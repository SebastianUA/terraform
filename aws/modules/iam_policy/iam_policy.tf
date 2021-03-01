#-----------------------------------------------------------
# IAM Policy
#-----------------------------------------------------------
resource "aws_iam_policy" "iam_policy" {
  count = var.enable_iam_policy ? 1 : 0

  policy = var.iam_policy_policy

  name        = var.iam_policy_name != null && var.iam_policy_name_prefix == null ? var.iam_policy_name : null
  name_prefix = var.iam_policy_name_prefix != null && var.iam_policy_name == null ? var.iam_policy_name_prefix : null
  description = var.iam_policy_description
  path        = var.iam_policy_path


  depends_on = []
}
