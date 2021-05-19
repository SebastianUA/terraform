#---------------------------------------------------
# AWS EFS access point
#---------------------------------------------------
resource "aws_efs_access_point" "efs_access_point" {
  count = var.enable_efs_access_point ? 1 : 0

  file_system_id = var.efs_access_point_file_system_id != "" ? var.efs_access_point_file_system_id : (var.enable_efs_file_system ? element(aws_efs_file_system.efs_file_system.*.id, 0) : null)

  dynamic "posix_user" {
    iterator = posix_user
    for_each = var.efs_access_point_posix_user

    content {
      gid = lookup(posix_user.value, "gid", null)
      uid = lookup(posix_user.value, "uid", null)

      secondary_gids = lookup(posix_user.value, "secondary_gids", null)
    }
  }

  dynamic "root_directory" {
    iterator = root_directory
    for_each = var.efs_access_point_root_directory

    content {
      path = lookup(root_directory.value, "path", null)

      dynamic "creation_info" {
        iterator = creation_info
        for_each = length(keys(lookup(root_directory.value, "creation_info", {}))) > 0 ? [lookup(root_directory.value, "creation_info", {})] : []

        content {
          owner_gid   = lookup(creation_info.value, "owner_gid", null)
          owner_uid   = lookup(creation_info.value, "owner_uid", null)
          permissions = lookup(creation_info.value, "permissions", null)
        }
      }

    }
  }

  tags = merge(
    {
      Name = var.efs_access_point_name != "" ? var.efs_access_point_name : "${lower(var.name)}-efs-access-point-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_efs_file_system.efs_file_system
  ]
}