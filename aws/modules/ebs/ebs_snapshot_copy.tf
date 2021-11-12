#---------------------------------------------------
# AWS EBS snapshot copy
#---------------------------------------------------
resource "aws_ebs_snapshot_copy" "ebs_snapshot_copy" {
  count = var.enable_ebs_snapshot_copy ? 1 : 0

  source_snapshot_id = var.ebs_snapshot_copy_source_snapshot_id
  source_region      = var.region
  description        = var.ebs_snapshot_copy_description != "" ? var.ebs_snapshot_copy_description : "A ebs snapshot copy from ${var.ebs_snapshot_copy_source_snapshot_id} snapshot"

  encrypted  = var.ebs_snapshot_copy_encrypted
  kms_key_id = var.ebs_snapshot_copy_kms_key_id

  tags = merge(
    {
      Name = var.ebs_snapshot_copy_name != "" ? lower(var.ebs_snapshot_copy_name) : "${lower(var.name)}-ebs-snapshot-copy-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
