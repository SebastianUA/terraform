#---------------------------------------------------
# AWS EBS volume attachment
#---------------------------------------------------
resource "aws_volume_attachment" "ebs_volume_attachment" {
    count               = var.enable_ebs_volume_attachment ? 1 : 0

    device_name         = var.device_name
    instance_id         = var.instance_id
    volume_id           = length(var.volume_id) > 0 ? var.volume_id : element(concat(aws_ebs_volume.ebs_volume.*.id , [""]), 0)

    force_detach        = var.force_detach
    skip_destroy        = var.skip_destroy

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on          = [
        aws_ebs_volume.ebs_volume
    ]
}
