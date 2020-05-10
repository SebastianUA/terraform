#---------------------------------------------------
# AWS Workspaces directory
#---------------------------------------------------
resource "aws_workspaces_directory" "workspaces_directory" {
    count                   = var.enable_workspaces_directory ? length(var.workspaces_directory_directory_ids) : 0

    directory_id            = var.workspaces_directory_directory_ids[count.index]

    subnet_ids              = var.workspaces_directory_subnet_ids

    dynamic "self_service_permissions" {
        iterator = self_service_permissions
        for_each = var.workspaces_directory_self_service_permissions
        content {
            change_compute_type     = lookup(self_service_permissions.value, "change_compute_type", false)
            increase_volume_size    = lookup(self_service_permissions.value, "increase_volume_size", false)
            rebuild_workspace       = lookup(self_service_permissions.value, "rebuild_workspace", false)
            restart_workspace       = lookup(self_service_permissions.value, "restart_workspace", true)
            switch_running_mode     = lookup(self_service_permissions.value, "switch_running_mode", false)
        }
    }

    tags                    = merge(
        {
            "Name"  = var.workspaces_directory_name != "" ? lower(var.workspaces_directory_name) : "${lower(var.name)}-workspaces-directory-${lower(var.environment)}-${count.index+1}"
        },
        var.tags
    )

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on              = []
}
