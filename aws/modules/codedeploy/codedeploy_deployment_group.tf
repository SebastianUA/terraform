#---------------------------------------------------
# AWS codedeploy deployment group
#---------------------------------------------------
# Deployment group deployment
resource "aws_codedeploy_deployment_group" "codedeploy_deployment_group" {
  count = var.enable_codedeploy_deployment_group ? length(var.codedeploy_deployment_group_stack) : 0

  app_name              = lookup(var.codedeploy_deployment_group_stack[count.index], "app_name", (var.enable_codedeploy_app ? aws_codedeploy_app.codedeploy_app.0.name : null))
  deployment_group_name = lookup(var.codedeploy_deployment_group_stack[count.index], "deployment_group_name", "${lower(var.name)}-deployment-group-${count.index + 1}-${lower(var.environment)}")
  service_role_arn      = lookup(var.codedeploy_deployment_group_stack[count.index], "service_role_arn", null)

  deployment_config_name = lookup(var.codedeploy_deployment_group_stack[count.index], "deployment_config_name", null)
  autoscaling_groups     = lookup(var.codedeploy_deployment_group_stack[count.index], "autoscaling_groups", null)

  dynamic "auto_rollback_configuration" {
    iterator = auto_rollback_configuration
    for_each = length(keys(lookup(var.codedeploy_deployment_group_stack[count.index], "auto_rollback_configuration", {}))) > 0 ? [lookup(var.codedeploy_deployment_group_stack[count.index], "auto_rollback_configuration", {})] : []

    content {
      enabled = lookup(auto_rollback_configuration.value, "enabled", null)
      events  = lookup(auto_rollback_configuration.value, "events", null)
    }
  }

  dynamic "trigger_configuration" {
    iterator = trigger_configuration
    for_each = length(keys(lookup(var.codedeploy_deployment_group_stack[count.index], "trigger_configuration", {}))) > 0 ? [lookup(var.codedeploy_deployment_group_stack[count.index], "trigger_configuration", {})] : []

    content {
      trigger_events     = lookup(trigger_configuration.value, "trigger_events", null)
      trigger_name       = lookup(trigger_configuration.value, "trigger_name", "${lower(var.name)}-notify-trigger-${count.index + 1}-${lower(var.environment)}")
      trigger_target_arn = lookup(trigger_configuration.value, "trigger_target_arn", null)
    }
  }

  dynamic "alarm_configuration" {
    iterator = alarm_configuration
    for_each = length(keys(lookup(var.codedeploy_deployment_group_stack[count.index], "alarm_configuration", {}))) > 0 ? [lookup(var.codedeploy_deployment_group_stack[count.index], "alarm_configuration", {})] : []

    content {
      alarms  = lookup(alarm_configuration.value, "alarms", null)
      enabled = lookup(alarm_configuration.value, "enabled", null)
    }
  }

  dynamic "ec2_tag_filter" {
    iterator = ec2_tag_filter
    for_each = length(keys(lookup(var.codedeploy_deployment_group_stack[count.index], "ec2_tag_filter", {}))) > 0 ? [lookup(var.codedeploy_deployment_group_stack[count.index], "ec2_tag_filter", {})] : []

    content {
      key   = lookup(ec2_tag_filter.value, "key", null)
      type  = lookup(ec2_tag_filter.value, "type", null)
      value = lookup(ec2_tag_filter.value, "value", null)
    }
  }

  dynamic "blue_green_deployment_config" {
    iterator = blue_green_deployment_config
    for_each = length(keys(lookup(var.codedeploy_deployment_group_stack[count.index], "blue_green_deployment_config", {}))) > 0 ? [lookup(var.codedeploy_deployment_group_stack[count.index], "blue_green_deployment_config", {})] : []

    content {
      dynamic "deployment_ready_option" {
        iterator = deployment_ready_option
        for_each = length(keys(lookup(blue_green_deployment_config.value, "deployment_ready_option", {}))) > 0 ? [lookup(blue_green_deployment_config.value, "deployment_ready_option", {})] : []

        content {
          action_on_timeout    = lookup(deployment_ready_option.value, "action_on_timeout", null)
          wait_time_in_minutes = lookup(deployment_ready_option.value, "wait_time_in_minutes", null)
        }
      }

      dynamic "terminate_blue_instances_on_deployment_success" {
        iterator = terminate_blue_instances_on_deployment_success
        for_each = length(keys(lookup(blue_green_deployment_config.value, "terminate_blue_instances_on_deployment_success", {}))) > 0 ? [lookup(blue_green_deployment_config.value, "terminate_blue_instances_on_deployment_success", {})] : []

        content {
          action                           = lookup(terminate_blue_instances_on_deployment_success.value, "action", null)
          termination_wait_time_in_minutes = lookup(terminate_blue_instances_on_deployment_success.value, "termination_wait_time_in_minutes", null)
        }
      }
    }
  }

  dynamic "deployment_style" {
    iterator = deployment_style
    for_each = length(keys(lookup(var.codedeploy_deployment_group_stack[count.index], "deployment_style", {}))) > 0 ? [lookup(var.codedeploy_deployment_group_stack[count.index], "deployment_style", {})] : []

    content {
      # For Blue-Green deployment should be - WITH_TRAFFIC_CONTROL
      deployment_option = lookup(deployment_style.value, "deployment_option", null)
      # For Blue-Green deployment should be - BLUE_GREEN
      deployment_type = lookup(deployment_style.value, "deployment_type", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_codedeploy_app.codedeploy_app
  ]
}