#---------------------------------------------------
# Create AWS EFS file system
#---------------------------------------------------
resource "aws_efs_file_system" "efs_file_system" {
  count = var.enable_efs_file_system ? 1 : 0

  creation_token   = var.creation_token
  encrypted        = var.encrypted
  kms_key_id       = var.kms_key_id
  performance_mode = var.performance_mode

  provisioned_throughput_in_mibps = var.provisioned_throughput_in_mibps
  throughput_mode                 = var.throughput_mode

  dynamic "lifecycle_policy" {
    for_each = var.lifecycle_policy
    content {
      transition_to_ia = lookup(lifecycle_policy.value, "transition_to_ia", null)
    }
  }

  tags = merge(
    {
      "Name" = var.efs_file_system_name != "" ? var.efs_file_system_name : "${lower(var.name)}-efs-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
