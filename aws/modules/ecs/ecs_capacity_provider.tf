#---------------------------------------------------
# AWS ECS capacity provider
#---------------------------------------------------
resource "aws_ecs_capacity_provider" "ecs_capacity_provider" {
  count = var.enable_ecs_capacity_provider ? 1 : 0

  name = var.ecs_capacity_provider_name != "" ? var.ecs_capacity_provider_name : "${lower(var.name)}-ecs-cp-${lower(var.environment)}"

  dynamic "auto_scaling_group_provider" {
    iterator = auto_scaling_group_provider
    for_each = var.ecs_capacity_provider_auto_scaling_group_provider

    content {
      auto_scaling_group_arn = lookup(auto_scaling_group_provider.value, "auto_scaling_group_arn", null)

      managed_termination_protection = lookup(auto_scaling_group_provider.value, "managed_termination_protection", null)

      dynamic "managed_scaling" {
        iterator = managed_scaling
        for_each = length(keys(lookup(auto_scaling_group_provider.value, "managed_scaling", {}))) > 0 ? [lookup(auto_scaling_group_provider.value, "managed_scaling", {})] : []

        content {
          maximum_scaling_step_size = lookup(managed_scaling.value, "maximum_scaling_step_size", null)
          minimum_scaling_step_size = lookup(managed_scaling.value, "minimum_scaling_step_size", null)
          status                    = lookup(managed_scaling.value, "status", null)
          target_capacity           = lookup(managed_scaling.value, "target_capacity", null)
        }
      }
    }
  }

  tags = merge(
    {
      Name = var.ecs_capacity_provider_name != "" ? var.ecs_capacity_provider_name : "${lower(var.name)}-ecs-cp-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
