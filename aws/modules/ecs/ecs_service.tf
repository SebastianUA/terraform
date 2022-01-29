#---------------------------------------------------
# AWS ECS service
#---------------------------------------------------
resource "aws_ecs_service" "ecs_service" {
  count = var.enable_ecs_service ? 1 : 0

  name            = var.ecs_service_name != "" ? var.ecs_service_name : "${lower(var.name)}-ecs-service-${lower(var.environment)}"
  cluster         = var.ecs_service_cluster != "" ? var.ecs_service_cluster : (var.enable_ecs_cluster ? element(aws_ecs_cluster.ecs_cluster.*.ecs_cluster_id, 0) : null)
  task_definition = var.ecs_service_task_definition
  desired_count   = var.ecs_service_desired_count
  iam_role        = var.ecs_service_iam_role

  launch_type         = var.ecs_service_launch_type
  platform_version    = var.ecs_service_platform_version
  scheduling_strategy = upper(var.ecs_service_scheduling_strategy)

  propagate_tags                     = var.ecs_service_propagate_tags
  deployment_maximum_percent         = var.ecs_service_deployment_maximum_percent
  deployment_minimum_healthy_percent = var.ecs_service_deployment_minimum_healthy_percent
  enable_ecs_managed_tags            = var.ecs_service_enable_ecs_managed_tags
  health_check_grace_period_seconds  = var.ecs_service_health_check_grace_period_seconds
  force_new_deployment               = var.ecs_service_force_new_deployment
  wait_for_steady_state              = var.ecs_service_wait_for_steady_state

  dynamic "capacity_provider_strategy" {
    iterator = capacity_provider_strategy
    for_each = var.ecs_service_capacity_provider_strategy

    content {
      capacity_provider = lookup(capacity_provider_strategy.value, "capacity_provider", null)
      weight            = lookup(capacity_provider_strategy.value, "weight", null)

      base = lookup(capacity_provider_strategy.value, "base", null)
    }
  }

  dynamic "deployment_controller" {
    iterator = deployment_controller
    for_each = var.ecs_service_deployment_controller

    content {
      type = lookup(deployment_controller.value, "type", null)
    }
  }

  dynamic "network_configuration" {
    iterator = network_configuration
    for_each = var.ecs_service_network_configuration

    content {
      subnets = lookup(network_configuration.value, "subnets", null)

      security_groups  = lookup(network_configuration.value, "security_groups", null)
      assign_public_ip = lookup(network_configuration.value, "assign_public_ip", null)
    }
  }

  dynamic "load_balancer" {
    iterator = load_balancer
    for_each = var.ecs_service_load_balancer

    content {
      container_name   = lookup(load_balancer.value, "container_name", "${lower(var.name)}-lb-container-${lower(var.environment)}")
      elb_name         = lookup(load_balancer.value, "elb_name", null)
      target_group_arn = lookup(load_balancer.value, "target_group_arn", null)
      container_port   = lookup(load_balancer.value, "container_port", null)
    }
  }

  dynamic "service_registries" {
    iterator = service_registries
    for_each = var.ecs_service_service_registries

    content {
      registry_arn = lookup(service_registries.value, "registry_arn", null)

      container_name = lookup(service_registries.value, "container_name", "${lower(var.name)}-sr-container-${lower(var.environment)}")
      port           = lookup(service_registries.value, "port", null)
      container_port = lookup(service_registries.value, "container_port", null)
    }
  }

  dynamic "ordered_placement_strategy" {
    iterator = ordered_placement_strategy
    for_each = var.ecs_service_ordered_placement_strategy

    content {
      type = lookup(ordered_placement_strategy.value, "type", null)

      field = lookup(ordered_placement_strategy.value, "field", null)
    }
  }

  dynamic "placement_constraints" {
    iterator = placement_constraints
    for_each = var.ecs_service_placement_constraints

    content {
      type = lookup(placement_constraints.value, "type", null)

      expression = lookup(placement_constraints.value, "expression", null)
    }
  }

  tags = merge(
    {
      Name = var.ecs_service_name != "" ? var.ecs_cluster_name : "${lower(var.name)}-ecs-service-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_ecs_cluster.ecs_cluster
  ]
}
