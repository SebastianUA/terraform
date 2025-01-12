#-----------------------------------------------------------
# container instances container instance
#-----------------------------------------------------------
resource "oci_container_instances_container_instance" "container_instance" {
  count = var.enable_container_instance ? 1 : 0

  # Required
  availability_domain = var.container_instance_availability_domain
  compartment_id      = var.container_instance_compartment_id
  shape               = var.container_instance_shape
  dynamic "containers" {
    iterator = containers
    for_each = var.container_instance_containers

    content {
      # Required
      image_url = lookup(containers.value, "image_url", null)

      # Optional
      arguments             = lookup(containers.value, "arguments", null)
      command               = lookup(containers.value, "command", null)
      defined_tags          = lookup(containers.value, "defined_tags", null)
      display_name          = lookup(containers.value, "display_name", null)
      environment_variables = lookup(containers.value, "environment_variables", null)
      freeform_tags         = lookup(containers.value, "freeform_tags", null)

      is_resource_principal_disabled = lookup(containers.value, "is_resource_principal_disabled", null)
      working_directory              = lookup(containers.value, "working_directory", null)

      dynamic "health_checks" {
        iterator = health_checks
        for_each = lookup(containers.value, "health_checks", [])

        content {
          # Required
          health_check_type = lookup(health_checks.value, "health_check_type", null)

          # Optional
          command           = lookup(health_checks.value, "command", null)
          failure_action    = lookup(health_checks.value, "failure_action", null)
          failure_threshold = lookup(health_checks.value, "failure_threshold", null)

          dynamic "headers" {
            iterator = headers
            for_each = lookup(health_checks.value, "headers", [])

            content {
              # Optional
              name  = lookup(headers.value, "name", null)
              value = lookup(headers.value, "value", null)
            }
          }

          initial_delay_in_seconds = lookup(health_checks.value, "initial_delay_in_seconds", null)
          interval_in_seconds      = lookup(health_checks.value, "interval_in_seconds", null)
          name                     = lookup(health_checks.value, "name", null)
          path                     = lookup(health_checks.value, "path", null)
          port                     = lookup(health_checks.value, "port", null)
          success_threshold        = lookup(health_checks.value, "success_threshold", null)
          timeout_in_seconds       = lookup(health_checks.value, "timeout_in_seconds", null)
        }
      }

      dynamic "resource_config" {
        iterator = resource_config
        for_each = length(keys(lookup(containers.value, "resource_config", {}))) > 0 ? [lookup(containers.value, "resource_config", {})] : []

        content {
          # Optional
          memory_limit_in_gbs = lookup(resource_config.value, "memory_limit_in_gbs", [])
          vcpus_limit         = lookup(resource_config.value, "vcpus_limit", [])
        }
      }

      dynamic "security_context" {
        iterator = security_context
        for_each = lookup(containers.value, "security_context", [])

        content {
          # Optional
          dynamic "capabilities" {
            iterator = capabilities
            for_each = lookup(security_context.value, "capabilities", [])

            content {
              # Optional
              add_capabilities  = lookup(capabilities.value, "add_capabilities", null)
              drop_capabilities = lookup(capabilities.value, "drop_capabilities", null)
            }
          }
          is_non_root_user_check_enabled = lookup(security_context.value, "is_non_root_user_check_enabled", null)
          is_root_file_system_readonly   = lookup(security_context.value, "is_root_file_system_readonly", null)
          run_as_group                   = lookup(security_context.value, "run_as_group", null)
          run_as_user                    = lookup(security_context.value, "run_as_user", null)
          security_context_type          = lookup(security_context.value, "security_context_type", null)
        }
      }
      dynamic "volume_mounts" {
        iterator = volume_mounts
        for_each = lookup(containers.value, "volume_mounts", [])

        content {
          # Required
          mount_path  = lookup(volume_mounts.value, "mount_path", null)
          volume_name = lookup(volume_mounts.value, "volume_name", null)

          # Optional
          is_read_only = lookup(volume_mounts.value, "is_read_only", null)
          partition    = lookup(volume_mounts.value, "partition", null)
          sub_path     = lookup(volume_mounts.value, "sub_path", null)
        }
      }

    }
  }

  dynamic "shape_config" {
    iterator = shape_config
    for_each = length(keys(var.container_instance_shape_config)) > 0 ? [var.container_instance_shape_config] : []

    content {
      # Required
      ocpus = lookup(shape_config.value, "ocpus", null)

      # Optional
      memory_in_gbs = lookup(shape_config.value, "memory_in_gbs", null)
    }
  }

  dynamic "vnics" {
    iterator = vnics
    for_each = var.container_instance_vnics

    content {
      # Required
      subnet_id = lookup(vnics.value, "subnet_id", null)

      # Optional
      defined_tags           = lookup(vnics.value, "defined_tags", null)
      display_name           = lookup(vnics.value, "display_name", null)
      freeform_tags          = lookup(vnics.value, "freeform_tags", null)
      hostname_label         = lookup(vnics.value, "hostname_label", null)
      is_public_ip_assigned  = lookup(vnics.value, "is_public_ip_assigned", null)
      nsg_ids                = lookup(vnics.value, "nsg_ids", null)
      private_ip             = lookup(vnics.value, "private_ip", null)
      skip_source_dest_check = lookup(vnics.value, "skip_source_dest_check", null)
    }
  }

  # Optional
  container_restart_policy             = var.container_instance_container_restart_policy
  display_name                         = var.container_instance_display_name != "" ? var.container_instance_display_name : "${lower(var.name)}-container-instance-${lower(var.environment)}"
  fault_domain                         = var.container_instance_fault_domain
  graceful_shutdown_timeout_in_seconds = var.container_instance_graceful_shutdown_timeout_in_seconds

  dynamic "dns_config" {
    iterator = dns_config
    for_each = length(keys(var.container_instance_dns_config)) > 0 ? [var.container_instance_dns_config] : []

    content {
      # Optional
      nameservers = lookup(dns_config.value, "nameservers", null)
      options     = lookup(dns_config.value, "options", null)
      searches    = lookup(dns_config.value, "searches", null)
    }
  }

  dynamic "image_pull_secrets" {
    iterator = image_pull_secrets
    for_each = var.container_instance_image_pull_secrets

    content {
      # Required
      registry_endpoint = lookup(image_pull_secrets.value, "registry_endpoint", null)
      secret_type       = lookup(image_pull_secrets.value, "secret_type", null)

      # Optional
      password  = lookup(image_pull_secrets.value, "password", null)
      secret_id = lookup(image_pull_secrets.value, "secret_id", null)
      username  = lookup(image_pull_secrets.value, "username", null)
    }
  }

  dynamic "volumes" {
    iterator = volumes
    for_each = var.container_instance_volumes

    content {
      # Required
      name        = lookup(volumes.value, "name", null)
      volume_type = lookup(volumes.value, "volume_type", null)

      # Optional
      backing_store = lookup(volumes.value, "backing_store", null)
      dynamic "configs" {
        iterator = configs
        for_each = length(keys(lookup(volumes.value, "configs", {}))) > 0 ? [lookup(volumes.value, "configs", {})] : []

        content {
          # Optional
          data      = lookup(configs.value, "data", null)
          file_name = lookup(configs.value, "file_name", null)
          path      = lookup(configs.value, "path", null)
        }
      }
    }
  }

  defined_tags = merge(
    {
      Name = var.container_instance_display_name != "" ? var.container_instance_display_name : "${lower(var.name)}-container-instance-${lower(var.environment)}"
    },
    var.tags
  )

  freeform_tags = var.ccc_infrastructure_freeform_tags

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.container_instance_timeouts)) > 0 ? [var.container_instance_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}