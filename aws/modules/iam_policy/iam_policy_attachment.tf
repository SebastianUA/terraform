#-----------------------------------------------------------
# IAM Policy Attachment
#-----------------------------------------------------------
resource "aws_iam_policy_attachment" "iam_policy_attachment" {
  count = var.enable_iam_policy_attachment ? 1 : 0

  name       = var.iam_policy_attachment_name != "" ? var.iam_policy_attachment_name : "${lower(var.name)}-policy-attachment-${lower(var.environment)}"
  roles      = var.iam_policy_attachment_roles
  users      = var.iam_policy_attachment_users
  groups     = var.iam_policy_attachment_groups
  policy_arn = var.iam_policy_attachment_policy_arn != "" && !var.enable_iam_policy ? var.iam_policy_attachment_policy_arn : (var.enable_iam_policy ? element(concat(aws_iam_policy.iam_policy.*.arn, [""]), 0) : null)

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_iam_policy.iam_policy
  ]
}
