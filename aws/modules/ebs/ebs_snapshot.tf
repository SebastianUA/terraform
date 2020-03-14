#---------------------------------------------------
# AWS EBS snapshot
#---------------------------------------------------
resource "aws_ebs_snapshot" "ebs_snapshot" {
    count               = var.enable_ebs_snapshot ? 1 : 0

    volume_id           = length(var.volume_id) > 0 ? var.volume_id :  element(concat(aws_ebs_volume.ebs_volume.*.id , [""]), 0)
    description         = var.ebs_snapshot_description !="" ? var.ebs_snapshot_description : "A snapshot for ${var.volume_id} volume"

    tags                = merge(
        {
            "Name"          = var.ebs_snapshot_name !="" ? lower(var.ebs_snapshot_name) : "${lower(var.name)}-ebs-snapshot-${lower(var.environment)}"
        },
         var.tags
    )

    timeouts {
        create  = var.timeouts_create
        delete  = var.timeouts_delete
    }

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on  = [
         aws_ebs_volume.ebs_volume
    ]
}
