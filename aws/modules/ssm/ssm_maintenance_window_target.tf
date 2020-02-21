#-----------------------------------------------------------
# AWS SSM window target
#-----------------------------------------------------------
resource "aws_ssm_maintenance_window_target" "ssm_maintenance_window_target" {
    count                       = var.enable_ssm_maintenance_window_target ? 1 : 0

    name                        = var.ssm_maintenance_window_target_name != "" && !var.enable_ssm_maintenance_window ? lower(var.ssm_maintenance_window_target_name) : "${lower(var.name)}-mw-target-${lower(var.environment)}"
    description                 = var.ssm_maintenance_window_target_description
    resource_type               = upper(var.ssm_maintenance_window_target_resource_type)
    window_id                   = var.ssm_maintenance_window_target_window_id !="" ? var.ssm_maintenance_window_target_window_id  : element(concat(aws_ssm_maintenance_window.ssm_maintenance_window.*.id, [""]), 0)
    owner_information           = var.ssm_maintenance_window_target_owner_information

    dynamic "targets" {
        for_each = length(var.ssm_maintenance_window_target_targets) >0 ? [var.ssm_maintenance_window_target_targets] : []
        content {
            key    = lookup(ssm_maintenance_window_target_targets.value, "key", null)
            values = lookup(ssm_maintenance_window_target_targets.value, "values", null)
        }
    }

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on                  = [
        aws_ssm_maintenance_window.ssm_maintenance_window
    ]
}