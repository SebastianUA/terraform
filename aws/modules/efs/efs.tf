#---------------------------------------------------
# Create AWS EFS file system
#---------------------------------------------------
resource "aws_efs_file_system" "efs_file_system" {
    creation_token      = "${lower(var.name)}-efs-${lower(var.environment)}"
    performance_mode    = "${var.performance_mode}"
    creation_token      = "${var.creation_token}"
    encrypted           = "${var.encrypted}"
    kms_key_id          = "${var.kms_key_id}"

    tags {
        Name            = "${lower(var.name)}-efs-${lower(var.environment)}"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }

}
#---------------------------------------------------
# Create AWS EFS mount target
#---------------------------------------------------
resource "aws_efs_mount_target" "efs_mount_target" {
    count           = "${length(var.subnet_ids) > 0 ? length(var.subnet_ids) : 0}"

    file_system_id  = "${aws_efs_file_system.efs_file_system.id}"
    subnet_id       = "${data.template_file.subnet_id.rendered}"
}

data "template_file" "subnet_id" {
    count    = "${length(var.subnet_ids) > 0 ? length(var.subnet_ids) : 0}"                
    template = "${element(var.subnet_ids, count.index)}"
}
