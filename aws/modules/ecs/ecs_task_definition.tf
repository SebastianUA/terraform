#---------------------------------------------------
# AWS ECS task definition
#---------------------------------------------------
resource "aws_ecs_task_definition" "ecs_task_definition" {
  count = var.enable_ecs_task_definition ? 1 : 0

  family                = var.ecs_task_definition_family != "" ? var.ecs_task_definition_family : "${lower(var.name)}-ecs-td-${lower(var.environment)}"
  container_definitions = var.ecs_task_definition_container_definitions

  task_role_arn      = var.ecs_task_definition_task_role_arn
  execution_role_arn = var.ecs_task_definition_execution_role_arn
  network_mode       = var.ecs_task_definition_network_mode
  ipc_mode           = var.ecs_task_definition_ipc_mode
  pid_mode           = var.ecs_task_definition_pid_mode

  cpu                      = var.ecs_task_definition_cpu
  memory                   = var.ecs_task_definition_memory
  requires_compatibilities = var.ecs_task_definition_requires_compatibilities

  dynamic "volume" {
    iterator = volume
    for_each = var.ecs_task_definition_volume

    content {
      name = lookup(volume.value, "name", null)

      host_path = lookup(volume.value, "host_path", null)

      dynamic "docker_volume_configuration" {
        iterator = docker_volume_configuration
        for_each = length(keys(lookup(volume.value, "docker_volume_configuration", {}))) > 0 ? [lookup(volume.value, "docker_volume_configuration", {})] : []

        content {
          scope         = lookup(docker_volume_configuration.value, "scope", null)
          autoprovision = lookup(docker_volume_configuration.value, "autoprovision", null)
          driver        = lookup(docker_volume_configuration.value, "driver", null)
          driver_opts   = lookup(docker_volume_configuration.value, "driver_opts", null)
          labels        = lookup(docker_volume_configuration.value, "labels", null)
        }
      }

      dynamic "efs_volume_configuration" {
        iterator = efs_volume_configuration
        for_each = length(keys(lookup(volume.value, "efs_volume_configuration", {}))) > 0 ? [lookup(volume.value, "efs_volume_configuration", {})] : []

        content {
          file_system_id = lookup(efs_volume_configuration.value, "file_system_id", null)

          root_directory          = lookup(efs_volume_configuration.value, "root_directory", null)
          transit_encryption      = lookup(efs_volume_configuration.value, "transit_encryption", null)
          transit_encryption_port = lookup(efs_volume_configuration.value, "transit_encryption_port", null)

          dynamic "authorization_config" {
            iterator = authorization_config
            for_each = length(keys(lookup(efs_volume_configuration.value, "authorization_config", {}))) > 0 ? [lookup(efs_volume_configuration.value, "authorization_config", {})] : []

            content {
              access_point_id = lookup(authorization_config.value, "access_point_id", null)
              iam             = lookup(authorization_config.value, "iam", null)
            }
          }
        }
      }
    }
  }

  dynamic "placement_constraints" {
    iterator = placement_constraints
    for_each = var.ecs_task_definition_placement_constraints

    content {
      type = lookup(placement_constraints.value, "type", null)

      expression = lookup(placement_constraints.value, "expression", null)
    }
  }

  dynamic "proxy_configuration" {
    iterator = proxy_configuration
    for_each = var.ecs_task_definition_proxy_configuration

    content {
      container_name = lookup(proxy_configuration.value, "container_name", null)
      properties     = lookup(proxy_configuration.value, "properties", null)

      type = lookup(proxy_configuration.value, "type", null)
    }
  }

  dynamic "inference_accelerator" {
    iterator = inference_accelerator
    for_each = var.ecs_task_definition_inference_accelerator

    content {
      device_name = lookup(inference_accelerator.value, "device_name", null)
      device_type = lookup(inference_accelerator.value, "device_type", null)
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
