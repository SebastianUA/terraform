#---------------------------------------------------
# AWS appautoscaling target
#---------------------------------------------------
resource "aws_appautoscaling_target" "appautoscaling_target" {
    count                       = var.enable_appautoscaling_target ? 1 : 0

    max_capacity                = var.appautoscaling_target_max_capacity
    min_capacity                = var.appautoscaling_target_min_capacity
    resource_id                 = var.appautoscaling_target_resource_id
    scalable_dimension          = var.appautoscaling_target_scalable_dimension
    service_namespace           = var.appautoscaling_target_service_namespace

    role_arn                    = var.appautoscaling_target_role_arn

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on                  = []
}
