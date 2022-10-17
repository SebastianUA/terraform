#---------------------------------------------------
# AWS emr serverless application
#---------------------------------------------------
resource "aws_emrserverless_application" "emrserverless_application" {
  count = var.enable_emrserverless_application ? 1 : 0

  name          = var.emrserverless_application_name != "" ? var.emrserverless_application_name : "${var.name}-emrserverless-app-${var.environment}"
  release_label = var.emrserverless_application_release_label
  type          = var.emrserverless_application_type

  dynamic "initial_capacity" {
    iterator = initial_capacity
    for_each = [var.emrserverless_application_initial_capacity]

    content {
      initial_capacity_type = lookup(initial_capacity.value, "initial_capacity_type", null)

      dynamic "initial_capacity_config" {
        iterator = initial_capacity_config
        for_each = length(keys(lookup(initial_capacity.value, "initial_capacity_config", {}))) > 0 ? [lookup(initial_capacity.value, "initial_capacity_config", {})] : []

        content {
          worker_count = lookup(initial_capacity_config.value, "worker_count", null)

          dynamic "worker_configuration" {
            iterator = worker_configuration
            for_each = length(keys(lookup(initial_capacity_config.value, "worker_configuration", {}))) > 0 ? [lookup(initial_capacity_config.value, "worker_configuration", {})] : []

            content {
              cpu    = lookup(worker_configuration.value, "cpu", null)
              memory = lookup(worker_configuration.value, "memory", null)
              disk   = lookup(worker_configuration.value, "disk", null)
            }
          }
        }
      }
    }
  }

  dynamic "maximum_capacity" {
    iterator = maximum_capacity
    for_each = [var.emrserverless_application_maximum_capacity]

    content {
      cpu    = lookup(maximum_capacity.value, "cpu", null)
      memory = lookup(maximum_capacity.value, "memory", null)
      disk   = lookup(maximum_capacity.value, "disk", null)
    }
  }

  dynamic "auto_start_configuration" {
    iterator = auto_start_configuration
    for_each = [var.emrserverless_application_auto_start_configuration]

    content {
      enabled = lookup(auto_start_configuration.value, "enabled", null)
    }
  }

  dynamic "auto_stop_configuration" {
    iterator = auto_stop_configuration
    for_each = [var.emrserverless_application_auto_stop_configuration]

    content {
      enabled              = lookup(auto_stop_configuration.value, "enabled", null)
      idle_timeout_minutes = lookup(auto_stop_configuration.value, "idle_timeout_minutes", null)
    }
  }

  dynamic "network_configuration" {
    iterator = network_configuration
    for_each = [var.emrserverless_application_network_configuration]

    content {
      security_group_ids = lookup(network_configuration.value, "security_group_ids", null)
      subnet_ids         = lookup(network_configuration.value, "subnet_ids", null)
    }
  }

  tags = merge(
    {
      Name = var.emrserverless_application_name != "" ? var.emrserverless_application_name : "${var.name}-emrserverless-app-${var.environment}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}