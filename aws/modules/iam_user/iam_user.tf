#-----------------------------------------------------------
# IAM user
#-----------------------------------------------------------
resource "aws_iam_user" "iam_user" {
  count = var.enable_iam_user ? 1 : 0

  name = var.iam_user_name != "" ? var.iam_user_name : "${lower(var.name)}-user-${lower(var.environment)}"
  path = var.iam_user_path

  permissions_boundary = var.iam_user_permissions_boundary
  force_destroy        = var.iam_user_force_destroy

  tags = merge(
    {
      Name = var.iam_user_name != "" ? var.iam_user_name : "${lower(var.name)}-user-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
