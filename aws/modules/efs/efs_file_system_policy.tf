#---------------------------------------------------
# AWS EFS file system policy
#---------------------------------------------------
resource "aws_efs_file_system_policy" "efs_file_system_policy" {
  count = var.enable_efs_file_system_policy ? 1 : 0

  file_system_id = var.efs_file_system_policy_file_system_id != "" ? var.efs_file_system_policy_file_system_id : (var.enable_efs_file_system ? element(aws_efs_file_system.efs_file_system.*.id, 0) : null)

  policy = var.efs_file_system_policy_policy

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_efs_file_system.efs_file_system
  ]
}