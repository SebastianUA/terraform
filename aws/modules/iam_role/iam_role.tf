#-----------------------------------------------------------
# IAM Role
#-----------------------------------------------------------
resource "aws_iam_role" "iam_role" {
  count = var.enable_iam_role ? 1 : 0

  name        = var.iam_role_name != "" && var.iam_role_name_prefix == "" ? var.iam_role_name : null
  name_prefix = var.iam_role_name_prefix != "" && var.iam_role_name == "" ? var.iam_role_name_prefix : null
  description = var.iam_role_description

  assume_role_policy = var.iam_role_assume_role_policy

  force_detach_policies = var.iam_role_force_detach_policies
  path                  = var.iam_role_path
  max_session_duration  = var.iam_role_max_session_duration
  permissions_boundary  = var.iam_role_permissions_boundary

  tags = merge(
    {
      Name = var.iam_role_name != "" && var.iam_role_name_prefix == "" ? var.iam_role_name : var.iam_role_name_prefix
    },
    var.tags
  )

  depends_on = []
}
