resource "aws_ecs_task_definition" "ecs_task_definition" {
  count = var.enable_ecs_task_definition && ! var.enable_appmesh_proxy ? 1 : 0

  family                = var.family != "" ? var.family : "${lower(var.name)}-ecs-td-${lower(var.environment)}"
  container_definitions = var.container_definitions

  task_role_arn      = var.task_role_arn
  execution_role_arn = var.execution_role_arn
  network_mode       = var.network_mode
  ipc_mode           = var.ipc_mode
  pid_mode           = var.pid_mode

  dynamic "volume" {
    for_each = var.volume
    content {
      name      = lookup(volume.value, "name", null)
      host_path = lookup(volume.value, "host_path", null)
    }
  }

  dynamic "placement_constraints" {
    for_each = var.placement_constraints
    content {
      type       = lookup(placement_constraints.value, "type", null)
      expression = lookup(placement_constraints.value, "expression", null)
    }
  }

  proxy_configuration {
    type           = var.proxy_configuration_type
    container_name = var.proxy_configuration_container_name != "" ? var.proxy_configuration_container_name : "${lower(var.name)}-container-${lower(var.environment)}"

    properties = {
      AppPorts         = var.proxy_configuration_properties_appports
      EgressIgnoredIPs = var.proxy_configuration_properties_egressignoredips
      IgnoredUID       = var.proxy_configuration_properties_ignoreduid
      ProxyEgressPort  = var.proxy_configuration_properties_proxyegressport
      ProxyIngressPort = var.proxy_configuration_properties_proxyingressport
    }
  }

  tags = merge(
    {
      Name = var.ecs_cluster_name != "" ? var.ecs_cluster_name : "${lower(var.name)}-ecs-td-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
