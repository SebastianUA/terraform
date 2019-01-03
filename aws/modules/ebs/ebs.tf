#---------------------------------------------------
# Create AWS EBS volume
#---------------------------------------------------
resource "aws_ebs_volume" "ebs_volume" {
    count               = "${var.enable_ebs_volume}"
                                            
    availability_zone   = "${length(var.availability_zone) > 0 ? var.availability_zone : "${element(split(",", (lookup(var.availability_zones, var.region))), 0)}"}"
    type                = "${var.type}"
    size                = "${var.size}"

    encrypted           = "${var.ebs_volume_encrypted}"
    iops                = "${var.iops}"
    snapshot_id         = "${var.snapshot_id}"
    kms_key_id          = "${var.kms_key_id}"
                        
    tags {
        Name            = "${lower(var.name)}-ebs-${lower(var.environment)}"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }

    lifecycle = {
        create_before_destroy   = true,
        ignore_changes          = ["tags"]
    } 

    depends_on  = []
}


#---------------------------------------------------
# AWS EBS volume attachment
#---------------------------------------------------
resource "aws_volume_attachment" "ebs_volume_attachment" {
    count               = "${var.enable_ebs_volume_attachment}"
            
    device_name         = "${var.device_name}"
    instance_id         = "${var.instance_id}"
    volume_id           = "${length(var.volume_id) > 0 ? var.volume_id : aws_ebs_volume.ebs_volume.id }"

    force_detach        = "${var.force_detach}"
    skip_destroy        = "${var.skip_destroy}"
    
    lifecycle = {
        create_before_destroy   = true
        ignore_changes          = ["volume_id"]
    }

    depends_on  = []
}

#---------------------------------------------------
# AWS EBS snapshot
#---------------------------------------------------
resource "aws_ebs_snapshot" "ebs_snapshot" {
    count               = "${var.enable_ebs_snapshot}"

    volume_id           = "${length(var.volume_id) > 0 ? var.volume_id : aws_ebs_volume.ebs_volume.id }"
    description         = "A snapshot for ${var.volume_id} volume"

    tags = {
        Name            = "${lower(var.name)}-ebs-snapshot-${lower(var.environment)}"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }

    lifecycle = {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on  = []
}

#---------------------------------------------------
# AWS EBS snapshot copy
#---------------------------------------------------
resource "aws_ebs_snapshot_copy" "ebs_snapshot_copy" {
    count               = "${var.enable_ebs_snapshot_copy}"

    source_snapshot_id  = "${var.source_snapshot_id}"
    source_region       = "${var.source_region}"
    description         = "A ebs snapshot copy from ${var.source_snapshot_id} snapshot"

    encrypted           = "${var.ebs_snapshot_copy_encrypted}"
    kms_key_id          = "${var.ebs_snapshot_copy_kms_key_id}"

    tags = {
        Name            = "${lower(var.name)}-ebs-snapshot-copy-${lower(var.environment)}"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }

    lifecycle = {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on  = []
}
