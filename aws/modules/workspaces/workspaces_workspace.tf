#---------------------------------------------------
# AWS Workspaces workspace
#---------------------------------------------------
resource "aws_workspaces_workspace" "workspaces_workspace" {
  count = var.enable_workspaces_workspace ? 1 : 0

  directory_id = var.workspaces_workspace_directory_id != "" ? var.workspaces_workspace_directory_id : (var.enable_workspaces_directory ? aws_workspaces_directory.workspaces_directory[count.index].id : null)
  bundle_id    = var.workspaces_workspace_bundle_id
  user_name    = var.workspaces_workspace_user_name

  root_volume_encryption_enabled = var.workspaces_workspace_root_volume_encryption_enabled
  user_volume_encryption_enabled = var.workspaces_workspace_user_volume_encryption_enabled
  volume_encryption_key          = var.workspaces_workspace_volume_encryption_key

  dynamic "workspace_properties" {
    iterator = workspace_properties
    for_each = var.workspaces_workspace_workspace_properties

    content {
      compute_type_name                         = lookup(workspace_properties.value, "compute_type_name", null)
      user_volume_size_gib                      = lookup(workspace_properties.value, "user_volume_size_gib", null)
      root_volume_size_gib                      = lookup(workspace_properties.value, "root_volume_size_gib", null)
      running_mode                              = lookup(workspace_properties.value, "running_mode", null)
      running_mode_auto_stop_timeout_in_minutes = lookup(workspace_properties.value, "running_mode_auto_stop_timeout_in_minutes", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.workspaces_workspace_timeouts)) > 0 ? [var.workspaces_workspace_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.workspaces_workspace_name != "" ? lower(var.workspaces_workspace_name) : "${lower(var.name)}-workspaces-workspace-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = false
    ignore_changes        = [volume_encryption_key]
  }

  depends_on = []
}
