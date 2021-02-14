resource "aws_ecs_service" "ecs_service" {
  count = var.enable_ecs_service && ! var.enable_ecs_service_daemon ? 1 : 0

  name            = var.ecs_service_name != "" ? var.ecs_service_name : "${lower(var.name)}-ecs-service-${lower(var.environment)}"
  cluster         = var.ecs_cluster_id
  task_definition = var.task_definition
  desired_count   = var.desired_count
  iam_role        = var.iam_role

  launch_type         = var.launch_type
  platform_version    = var.platform_version
  scheduling_strategy = var.scheduling_strategy

  #propagate_tags                      = var.propagate_tags
  #deployment_maximum_percent          = var.deployment_maximum_percent
  #deployment_minimum_healthy_percent  = var.deployment_minimum_healthy_percent
  #enable_ecs_managed_tags             = var.enable_ecs_managed_tags
  #health_check_grace_period_seconds   = var.health_check_grace_period_seconds

  dynamic "deployment_controller" {
    for_each = var.deployment_controller
    content {
      type = lookup(deployment_controller.value, "type", null)
    }
  }

  dynamic "network_configuration" {
    for_each = var.network_configuration
    content {
      subnets          = lookup(network_configuration.value, "subnets", null)
      security_groups  = lookup(network_configuration.value, "security_groups", null)
      assign_public_ip = lookup(network_configuration.value, "assign_public_ip", null)
    }
  }

  dynamic "load_balancer" {
    for_each = var.load_balancer
    content {
      elb_name         = lookup(load_balancer.value, "elb_name", null)
      target_group_arn = lookup(load_balancer.value, "target_group_arn", null)
      container_name   = var.load_balancer_container_name != "" ? var.load_balancer_container_name : "${lower(var.name)}-lb-container-${lower(var.environment)}"
      container_port   = lookup(load_balancer.value, "container_port", null)
    }
  }

  dynamic "service_registries" {
    for_each = var.service_registries
    content {
      registry_arn   = lookup(service_registries.value, "registry_arn", null)
      port           = lookup(service_registries.value, "port", null)
      container_name = var.service_registries_container_name != "" ? var.service_registries_container_name : "${lower(var.name)}-sr-container-${lower(var.environment)}"
      container_port = lookup(service_registries.value, "container_port", null)
    }
  }

  dynamic "ordered_placement_strategy" {
    for_each = var.ordered_placement_strategy
    content {
      type  = lookup(ordered_placement_strategy.value, "type", null)
      field = lookup(ordered_placement_strategy.value, "field", null)
    }
  }

  dynamic "placement_constraints" {
    for_each = var.placement_constraints
    content {
      type       = lookup(placement_constraints.value, "type", null)
      expression = lookup(placement_constraints.value, "expression", null)
    }
  }

  tags = merge(
    {
      Name = var.ecs_cluster_name != "" ? var.ecs_cluster_name : "${lower(var.name)}-ecs-service-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}

resource "aws_ecs_service" "ecs_service_daemon" {
  count = var.enable_ecs_service && var.enable_ecs_service_daemon ? 1 : 0

  name                = var.ecs_service_name != "" ? var.ecs_service_name : "${lower(var.name)}-ecs-service-${lower(var.environment)}"
  cluster             = var.ecs_cluster_id
  task_definition     = var.task_definition
  scheduling_strategy = "DAEMON"

  launch_type      = var.launch_type
  platform_version = var.platform_version

  tags = merge(
    {
      Name = var.ecs_cluster_name != "" ? var.ecs_cluster_name : "${lower(var.name)}-ecs-service-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
