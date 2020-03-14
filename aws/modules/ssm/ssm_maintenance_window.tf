#-----------------------------------------------------------
# AWS SSM window
#-----------------------------------------------------------
resource "aws_ssm_maintenance_window" "ssm_maintenance_window" {
    count                       = var.enable_ssm_maintenance_window ? 1 : 0

    name                        = var.ssm_maintenance_window_name != "" ? lower(var.ssm_maintenance_window_name) : "${lower(var.name)}-mw-${lower(var.environment)}"
    schedule                    = var.ssm_maintenance_window_schedule
    duration                    = var.ssm_maintenance_window_duration
    cutoff                      = var.ssm_maintenance_window_cutoff

    description                 = var.ssm_maintenance_window_description
    allow_unassociated_targets  = var.ssm_maintenance_window_allow_unassociated_targets
    enabled                     = var.ssm_maintenance_window_enabled
    end_date                    = var.ssm_maintenance_window_end_date
    schedule_timezone           = var.ssm_maintenance_window_schedule_timezone
    start_date                  = var.ssm_maintenance_window_start_date

    tags                        = merge(
        {
            "Name"          = var.ssm_maintenance_window_name != "" ? lower(var.ssm_maintenance_window_name) : "${lower(var.name)}-mw-${lower(var.environment)}"
        },
        var.tags
    )

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on                      = []
}
