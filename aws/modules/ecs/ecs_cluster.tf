#---------------------------------------------------
# AWS ECS cluster
#---------------------------------------------------
resource "aws_ecs_cluster" "ecs_cluster" {
  count = var.enable_ecs_cluster ? 1 : 0

  name = var.ecs_cluster_name != "" ? var.ecs_cluster_name : "${lower(var.name)}-ecs-cluster-${lower(var.environment)}"

  capacity_providers = var.ecs_cluster_capacity_providers

  dynamic "default_capacity_provider_strategy" {
    iterator = default_capacity_provider_strategy
    for_each = var.ecs_cluster_default_capacity_provider_strategy

    content {
      capacity_provider = lookup(default_capacity_provider_strategy.value, "capacity_provider", null)

      weight = lookup(default_capacity_provider_strategy.value, "weight", null)
      base   = lookup(default_capacity_provider_strategy.value, "base", null)
    }
  }

  dynamic "setting" {
    iterator = setting
    for_each = var.ecs_cluster_setting

    content {
      name  = lookup(setting.value, "name", null)
      value = lookup(setting.value, "value", null)
    }
  }

  tags = merge(
    {
      Name = var.ecs_cluster_name != "" ? var.ecs_cluster_name : "${lower(var.name)}-ecs-cluster-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
