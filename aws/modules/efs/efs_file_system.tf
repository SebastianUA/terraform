#---------------------------------------------------
# AWS EFS file system
#---------------------------------------------------
resource "aws_efs_file_system" "efs_file_system" {
  count = var.enable_efs_file_system ? 1 : 0

  creation_token   = var.efs_file_system_creation_token
  encrypted        = var.efs_file_system_encrypted
  kms_key_id       = var.efs_file_system_kms_key_id
  performance_mode = var.efs_file_system_performance_mode

  provisioned_throughput_in_mibps = var.efs_file_system_provisioned_throughput_in_mibps
  throughput_mode                 = var.efs_file_system_throughput_mode

  dynamic "lifecycle_policy" {
    iterator = lifecycle_policy
    for_each = var.efs_file_system_lifecycle_policy
    content {
      transition_to_ia = lookup(lifecycle_policy.value, "transition_to_ia", null)
    }
  }

  tags = merge(
    {
      Name = var.efs_file_system_name != "" ? var.efs_file_system_name : "${lower(var.name)}-efs-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
