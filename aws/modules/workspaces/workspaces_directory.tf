#---------------------------------------------------
# AWS Workspaces directory
#---------------------------------------------------
resource "aws_workspaces_directory" "workspaces_directory" {
  count = var.enable_workspaces_directory ? length(var.workspaces_directory_directory_ids) : 0

  directory_id = var.workspaces_directory_directory_ids[count.index]

  subnet_ids   = var.workspaces_directory_subnet_ids
  ip_group_ids = var.workspaces_directory_ip_group_ids

  dynamic "self_service_permissions" {
    iterator = self_service_permissions
    for_each = var.workspaces_directory_self_service_permissions

    content {
      change_compute_type  = lookup(self_service_permissions.value, "change_compute_type", false)
      increase_volume_size = lookup(self_service_permissions.value, "increase_volume_size", false)
      rebuild_workspace    = lookup(self_service_permissions.value, "rebuild_workspace", false)
      restart_workspace    = lookup(self_service_permissions.value, "restart_workspace", true)
      switch_running_mode  = lookup(self_service_permissions.value, "switch_running_mode", false)
    }
  }

  dynamic "workspace_access_properties" {
    iterator = workspace_access_properties
    for_each = var.workspaces_directory_workspace_access_properties

    content {
      device_type_android    = lookup(workspace_access_properties.value, "device_type_android", null)
      device_type_chromeos   = lookup(workspace_access_properties.value, "device_type_chromeos", null)
      device_type_ios        = lookup(workspace_access_properties.value, "device_type_ios", null)
      device_type_osx        = lookup(workspace_access_properties.value, "device_type_osx", null)
      device_type_web        = lookup(workspace_access_properties.value, "device_type_web", null)
      device_type_windows    = lookup(workspace_access_properties.value, "device_type_windows", null)
      device_type_zeroclient = lookup(workspace_access_properties.value, "device_type_zeroclient", null)
    }
  }

  dynamic "workspace_creation_properties" {
    iterator = workspace_creation_properties
    for_each = var.workspaces_directory_workspace_creation_properties

    content {
      custom_security_group_id            = lookup(workspace_creation_properties.value, "custom_security_group_id", null)
      default_ou                          = lookup(workspace_creation_properties.value, "default_ou", null)
      enable_internet_access              = lookup(workspace_creation_properties.value, "enable_internet_access", null)
      enable_maintenance_mode             = lookup(workspace_creation_properties.value, "enable_maintenance_mode", null)
      user_enabled_as_local_administrator = lookup(workspace_creation_properties.value, "user_enabled_as_local_administrator", null)
    }
  }

  tags = merge(
    {
      Name = var.workspaces_directory_name != "" ? lower(var.workspaces_directory_name) : "${lower(var.name)}-workspaces-directory-${lower(var.environment)}-${count.index + 1}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
