#-----------------------------------------------------------
# Azure container registry task
#-----------------------------------------------------------
resource "azurerm_container_registry_task" "container_registry_task" {
  count = var.enable_container_registry_task ? 1 : 0

  name                  = var.container_registry_task_name != "" ? var.container_registry_task_name : "${lower(var.name)}-container-registry-task-${lower(var.environment)}"
  container_registry_id = var.container_registry_task_container_registry_id != "" ? var.container_registry_task_container_registry_id : (var.enable_ ? azurerm_container_registry.container_registry[count.index].id : null)

  agent_pool_name    = var.container_registry_task_agent_pool_name
  enabled            = var.container_registry_task_enabled
  is_system_task     = var.container_registry_task_is_system_task
  log_template       = var.container_registry_task_log_template
  timeout_in_seconds = var.container_registry_task_timeout_in_seconds

  dynamic "agent_setting" {
    iterator = agent_setting
    for_each = [var.container_registry_task_agent_setting]

    content {
      cpu = lookup(agent_setting.value, "cpu", null)
    }
  }

  dynamic "identity" {
    iterator = identity
    for_each = [var.container_registry_task_identity]

    content {
      type         = lookup(identity.value, "type", null)
      identity_ids = lookup(identity.value, "identity_ids", null)
    }
  }

  dynamic "platform" {
    iterator = platform
    for_each = [var.container_registry_task_platform]

    content {
      os = lookup(platform.value, "os", null)

      architecture = lookup(platform.value, "architecture", null)
      variant      = lookup(platform.value, "variant", null)
    }
  }

  dynamic "docker_step" {
    iterator = docker_step
    for_each = [var.container_registry_task_docker_step]

    content {
      context_access_token = lookup(docker_step.value, "context_access_token", null)
      context_path         = lookup(docker_step.value, "context_path", null)
      dockerfile_path      = lookup(docker_step.value, "dockerfile_path", null)

      arguments        = lookup(docker_step.value, "arguments", null)
      image_names      = lookup(docker_step.value, "image_names", null)
      cache_enabled    = lookup(docker_step.value, "cache_enabled", null)
      push_enabled     = lookup(docker_step.value, "push_enabled", null)
      secret_arguments = lookup(docker_step.value, "secret_arguments", null)
      target           = lookup(docker_step.value, "target", null)
    }
  }

  dynamic "encoded_step" {
    iterator = encoded_step
    for_each = [var.container_registry_task_encoded_step]

    content {
      task_content         = lookup(encoded_step.value, "task_content", null)
      context_access_token = lookup(encoded_step.value, "context_access_token", null)
      context_path         = lookup(encoded_step.value, "context_path", null)

      secret_values = lookup(encoded_step.value, "secret_values", null)
      value_content = lookup(encoded_step.value, "value_content", null)
      values        = lookup(encoded_step.value, "values", null)
    }
  }

  dynamic "file_step" {
    iterator = file_step
    for_each = [var.container_registry_task_file_step]

    content {
      task_file_path       = lookup(file_step.value, "task_file_path", null)
      context_access_token = lookup(file_step.value, "context_access_token", null)
      context_path         = lookup(file_step.value, "context_path", null)

      secret_values   = lookup(file_step.value, "secret_values", null)
      value_file_path = lookup(file_step.value, "value_file_path", null)
      values          = lookup(file_step.value, "values", null)
    }
  }

  dynamic "base_image_trigger" {
    iterator = base_image_trigger
    for_each = [var.container_registry_task_base_image_trigger]

    content {
      name = lookup(base_image_trigger.value, "name", null)
      type = lookup(base_image_trigger.value, "type", null)

      enabled                     = lookup(base_image_trigger.value, "enabled", null)
      update_trigger_endpoint     = lookup(base_image_trigger.value, "update_trigger_endpoint", null)
      update_trigger_payload_type = lookup(base_image_trigger.value, "update_trigger_payload_type", null)
    }
  }

  dynamic "source_trigger" {
    iterator = source_trigger
    for_each = [var.container_registry_task_source_trigger]

    content {
      name           = lookup(source_trigger.value, "name", null)
      events         = lookup(source_trigger.value, "events", null)
      repository_url = lookup(source_trigger.value, "repository_url", null)
      source_type    = lookup(source_trigger.value, "source_type", null)

      branch  = lookup(source_trigger.value, "branch", null)
      enabled = lookup(source_trigger.value, "enabled", null)

      dynamic "authentication" {
        iterator = authentication
        for_each = lookup(source_trigger.value, "authentication", [])

        content {
          token      = lookup(authentication.value, "token", null)
          token_type = lookup(authentication.value, "token_type", null)

          expire_in_seconds = lookup(authentication.value, "expire_in_seconds", null)
          refresh_token     = lookup(authentication.value, "refresh_token", null)
          scope             = lookup(authentication.value, "scope", null)
        }
      }
    }
  }

  dynamic "timer_trigger" {
    iterator = timer_trigger
    for_each = var.container_registry_task_timer_trigger

    content {
      name     = lookup(timer_trigger.value, "name", null)
      schedule = lookup(timer_trigger.value, "schedule", null)

      enabled = lookup(timer_trigger.value, "enabled", null)
    }
  }

  dynamic "registry_credential" {
    iterator = registry_credential
    for_each = [var.container_registry_task_registry_credential]

    content {
      dynamic "source" {
        iterator = source
        for_each = lookup(registry_credential.value, "source", [])

        content {
          login_mode = lookup(source.value, "login_mode", null)
        }
      }

      dynamic "custom" {
        iterator = custom
        for_each = lookup(registry_credential.value, "custom", [])

        content {
          login_server = lookup(custom.value, "login_server", null)

          identity = lookup(custom.value, "identity", null)
          password = lookup(custom.value, "password", null)
          username = lookup(custom.value, "username", null)
        }
      }
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.container_registry_task_timeouts)) > 0 ? [var.container_registry_task_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.container_registry_task_name != "" ? var.container_registry_task_name : "${lower(var.name)}-container-registry-task-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    azurerm_container_registry.container_registry
  ]
}