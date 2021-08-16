#-----------------------------------------------------------
# Instance Profile
#-----------------------------------------------------------
resource "aws_iam_instance_profile" "iam_instance_profile" {
  count = var.enable_iam_instance_profile ? 1 : 0

  name = var.iam_instance_profile_name != "" ? var.iam_instance_profile_name : "${lower(var.name)}-instance-profile-${lower(var.environment)}"
  role = var.iam_instance_profile_role != "" && !var.enable_iam_role ? var.iam_instance_profile_role : element(concat(aws_iam_role.iam_role.*.name, [""]), 0)

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_iam_role.iam_role
  ]
}
