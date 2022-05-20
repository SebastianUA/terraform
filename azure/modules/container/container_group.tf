#-----------------------------------------------------------
# Azure container group
#-----------------------------------------------------------
resource "azurerm_container_group" "container_group" {
  count = var.enable_container_group ? 1 : 0

  name                = var.container_group_name != "" ? var.container_group_name : "${lower(var.name)}-container-group-${lower(var.environment)}"
  location            = var.container_group_location
  resource_group_name = var.container_group_resource_group_name
  os_type             = var.container_group_os_type

  dynamic "container" {
    iterator = container
    for_each = var.container_group_container

    content {
      name   = lookup(container.value, "name", null)
      image  = lookup(container.value, "image", null)
      cpu    = lookup(container.value, "cpu", null)
      memory = lookup(container.value, "memory", null)

      environment_variables        = lookup(container.value, "environment_variables", null)
      secure_environment_variables = lookup(container.value, "secure_environment_variables", null)
      commands                     = lookup(container.value, "commands", null)

      dynamic "gpu" {
        iterator = gpu
        for_each = lookup(container.value, "gpu", [])

        content {
          count = lookup(gpu.value, "count", null)
          sku   = lookup(gpu.value, "sku", null)
        }
      }
      dynamic "ports" {
        iterator = ports
        for_each = lookup(container.value, "ports", [])

        content {
          port     = lookup(ports.value, "port", null)
          protocol = lookup(ports.value, "protocol", null)
        }
      }

      dynamic "volume" {
        iterator = volume
        for_each = lookup(container.value, "volume", [])

        content {
          name       = lookup(volume.value, "name", null)
          mount_path = lookup(volume.value, "mount_path", null)

          read_only            = lookup(volume.value, "read_only", null)
          empty_dir            = lookup(volume.value, "empty_dir", null)
          storage_account_name = lookup(volume.value, "storage_account_name", null)
          storage_account_key  = lookup(volume.value, "storage_account_key", null)
          share_name           = lookup(volume.value, "share_name", null)
          secret               = lookup(volume.value, "secret", null)

          dynamic "git_repo" {
            iterator = git_repo
            for_each = lookup(volume.value, "git_repo", [])

            content {
              url = lookup(git_repo.value, "url", null)

              directory = lookup(git_repo.value, "directory", null)
              revision  = lookup(git_repo.value, "revision", null)
            }
          }
        }
      }

      dynamic "readiness_probe" {
        iterator = readiness_probe
        for_each = lookup(container.value, "readiness_probe", [])

        content {
          exec                  = lookup(readiness_probe.value, "exec", null)
          initial_delay_seconds = lookup(readiness_probe.value, "initial_delay_seconds", null)
          period_seconds        = lookup(readiness_probe.value, "period_seconds", null)
          failure_threshold     = lookup(readiness_probe.value, "failure_threshold", null)
          success_threshold     = lookup(readiness_probe.value, "success_threshold", null)
          timeout_seconds       = lookup(readiness_probe.value, "timeout_seconds", null)

          dynamic "http_get" {
            iterator = http_get
            for_each = lookup(liveness_probe.value, "http_get", [])
            content {
              path   = lookup(http_get.value, "path", null)
              port   = lookup(http_get.value, "port", null)
              scheme = lookup(http_get.value, "scheme", null)
            }
          }
        }
      }

      dynamic "liveness_probe" {
        iterator = liveness_probe
        for_each = lookup(container.value, "liveness_probe", [])

        content {
          exec                  = lookup(liveness_probe.value, "exec", null)
          initial_delay_seconds = lookup(liveness_probe.value, "initial_delay_seconds", null)
          period_seconds        = lookup(liveness_probe.value, "period_seconds", null)
          failure_threshold     = lookup(liveness_probe.value, "failure_threshold", null)
          success_threshold     = lookup(liveness_probe.value, "success_threshold", null)
          timeout_seconds       = lookup(liveness_probe.value, "timeout_seconds", null)

          dynamic "http_get" {
            iterator = http_get
            for_each = lookup(liveness_probe.value, "http_get", [])
            content {
              path   = lookup(http_get.value, "path", null)
              port   = lookup(http_get.value, "port", null)
              scheme = lookup(http_get.value, "scheme", null)
            }
          }
        }
      }
    }
  }

  dns_name_label     = var.container_group_dns_name_label
  ip_address_type    = var.container_group_ip_address_type
  key_vault_key_id   = var.container_group_key_vault_key_id
  network_profile_id = var.container_group_network_profile_id
  restart_policy     = var.container_group_restart_policy

  dynamic "image_registry_credential" {
    iterator = image_registry_credential
    for_each = [var.container_group_image_registry_credential]

    content {
      username = lookup(image_registry_credential.value, "username", null)
      password = lookup(image_registry_credential.value, "password", null)
      server   = lookup(image_registry_credential.value, "server", null)
    }
  }

  dynamic "identity" {
    iterator = identity
    for_each = [var.container_group_identity]

    content {
      type = lookup(identity.value, "type", null)

      identity_ids = lookup(identity.value, "identity_ids", null)
    }
  }

  dynamic "init_container" {
    iterator = init_container
    for_each = var.container_group_init_container

    content {
      name  = lookup(init_container.value, "name", null)
      image = lookup(init_container.value, "image", null)

      environment_variables        = lookup(init_container.value, "environment_variables", null)
      secure_environment_variables = lookup(init_container.value, "secure_environment_variables", null)
      commands                     = lookup(init_container.value, "commands", null)

      dynamic "volume" {
        iterator = volume
        for_each = lookup(init_container.value, "volume", [])

        content {
          name       = lookup(volume.value, "name", null)
          mount_path = lookup(volume.value, "mount_path", null)

          read_only            = lookup(volume.value, "read_only", null)
          empty_dir            = lookup(volume.value, "empty_dir", null)
          storage_account_name = lookup(volume.value, "storage_account_name", null)
          storage_account_key  = lookup(volume.value, "storage_account_key", null)
          share_name           = lookup(volume.value, "share_name", null)
          secret               = lookup(volume.value, "secret", null)

          dynamic "git_repo" {
            iterator = git_repo
            for_each = lookup(volume.value, "git_repo", [])

            content {
              url = lookup(git_repo.value, "url", null)

              directory = lookup(git_repo.value, "directory", null)
              revision  = lookup(git_repo.value, "revision", null)
            }
          }
        }

      }
    }
  }

  dynamic "dns_config" {
    iterator = dns_config
    for_each = [var.container_group_dns_config]

    content {
      nameservers = lookup(dns_config.value, "nameservers", null)

      search_domains = lookup(dns_config.value, "search_domains", null)
      options        = lookup(dns_config.value, "options", null)
    }
  }

  dynamic "diagnostics" {
    iterator = diagnostics
    for_each = [var.container_group_diagnostics]

    content {
      log_analytics = lookup(diagnostics.value, "log_analytics", null)
    }
  }

  dynamic "exposed_port" {
    iterator = exposed_port
    for_each = var.container_group_exposed_port

    content {
      port     = lookup(exposed_port.value, "port", null)
      protocol = lookup(exposed_port.value, "protocol", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.container_group_timeouts)) > 0 ? [var.container_group_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.container_group_name != "" ? var.container_group_name : "${lower(var.name)}-container-group-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}