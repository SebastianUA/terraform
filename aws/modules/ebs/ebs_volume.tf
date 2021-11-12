#---------------------------------------------------
# AWS EBS volume
#---------------------------------------------------
resource "aws_ebs_volume" "ebs_volume" {
  count = var.enable_ebs_volume ? 1 : 0

  availability_zone = length(var.ebs_volume_availability_zone) > 0 ? var.ebs_volume_availability_zone : element(split(",", (lookup(var.availability_zones, var.region))), 0)
  type              = var.ebs_volume_type
  size              = var.ebs_volume_size

  encrypted   = var.ebs_volume_encrypted
  iops        = var.ebs_volume_iops
  snapshot_id = var.ebs_volume_snapshot_id
  kms_key_id  = var.ebs_volume_kms_key_id

  tags = merge(
    {
      Name = var.ebs_volume_name != "" ? lower(var.ebs_volume_name) : "${lower(var.name)}-ebs-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
