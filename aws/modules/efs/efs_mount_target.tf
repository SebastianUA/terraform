#---------------------------------------------------
# Create AWS EFS mount target
#---------------------------------------------------
resource "aws_efs_mount_target" "efs_mount_target" {
    count           = var.enable_efs_mount_target && length(var.subnet_ids) > 0 ? length(var.subnet_ids) : 0

    file_system_id  = var.file_system_id !="" ? var.file_system_id : element(concat(aws_efs_file_system.efs_file_system.*.id, [""]), 0)
    subnet_id       = var.subnet_ids[count.index]
    ip_address      = var.ip_address
    security_groups = var.security_groups

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on      = [
        aws_efs_file_system.efs_file_system
    ]
}
