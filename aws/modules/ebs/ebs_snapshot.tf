#---------------------------------------------------
# AWS EBS snapshot
#---------------------------------------------------
resource "aws_ebs_snapshot" "ebs_snapshot" {
  count = var.enable_ebs_snapshot ? 1 : 0

  volume_id   = length(var.ebs_snapshot_volume_id) > 0 ? var.ebs_snapshot_volume_id : element(concat(aws_ebs_volume.ebs_volume.*.id, [""]), 0)
  description = var.ebs_snapshot_description != "" ? var.ebs_snapshot_description : "A snapshot for ${var.ebs_snapshot_volume_id} volume"

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.ebs_snapshot_timeouts)) > 0 ? [var.ebs_snapshot_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.ebs_snapshot_name != "" ? lower(var.ebs_snapshot_name) : "${lower(var.name)}-ebs-snapshot-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_ebs_volume.ebs_volume
  ]
}
