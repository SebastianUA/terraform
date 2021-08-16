#-----------------------------------------------------------
# IAM group
#-----------------------------------------------------------
resource "aws_iam_group" "iam_group" {
  count = var.enable_iam_group ? 1 : 0

  name = var.iam_group_name != "" ? var.iam_group_name : "${lower(var.name)}-group-${lower(var.environment)}"
  path = var.iam_group_path

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
