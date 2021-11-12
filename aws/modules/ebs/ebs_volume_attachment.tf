#---------------------------------------------------
# AWS EBS volume attachment
#---------------------------------------------------
resource "aws_volume_attachment" "ebs_volume_attachment" {
  count = var.enable_ebs_volume_attachment ? 1 : 0

  device_name = var.ebs_volume_attachment_device_name
  instance_id = var.ebs_volume_attachment_instance_id
  volume_id   = length(var.ebs_volume_attachment_volume_id) > 0 ? var.ebs_volume_attachment_volume_id : element(concat(aws_ebs_volume.ebs_volume.*.id, [""]), 0)

  force_detach = var.ebs_volume_attachment_force_detach
  skip_destroy = var.ebs_volume_attachment_skip_destroy

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_ebs_volume.ebs_volume
  ]
}
