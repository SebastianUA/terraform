#---------------------------------------------------
# Create AWS EBS volume
#---------------------------------------------------
resource "aws_ebs_volume" "ebs_volume" {
  count = var.enable_ebs_volume ? 1 : 0

  availability_zone = length(var.availability_zone) > 0 ? var.availability_zone : element(split(",", (lookup(var.availability_zones, var.region))), 0)
  type              = var.type
  size              = var.size

  encrypted   = var.ebs_volume_encrypted
  iops        = var.iops
  snapshot_id = var.snapshot_id
  kms_key_id  = var.kms_key_id

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
