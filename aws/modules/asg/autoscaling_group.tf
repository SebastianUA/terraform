#---------------------------------------------------
# AWS ASG
#---------------------------------------------------
resource "aws_autoscaling_group" "asg" {
  count = var.enable_asg ? 1 : 0

  name        = var.asg_name != "" ? var.asg_name : (var.asg_name_prefix == null ? "${lower(var.name)}-asg-${lower(var.environment)}" : null)
  name_prefix = var.asg_name_prefix != null ? var.asg_name_prefix : (var.asg_name != "" ? null : var.asg_name_prefix)
  # verify LC & LT
  launch_configuration = var.asg_launch_configuration != "" ? var.asg_launch_configuration : (length(var.asg_launch_template) == 0 ? element(concat(aws_launch_configuration.lc.*.name, [""]), 0) : null)

  # vpc_zone_identifier or availability_zones!!!!
  vpc_zone_identifier = length(var.asg_vpc_zone_identifier) > 0 ? var.asg_vpc_zone_identifier : null
  availability_zones  = length(var.asg_vpc_zone_identifier) == 0 ? split(",", (lookup(var.asg_availability_zones, var.region))) : null

  max_size           = var.asg_max_size
  min_size           = var.asg_min_size
  desired_capacity   = var.asg_desired_capacity
  capacity_rebalance = var.asg_capacity_rebalance

  health_check_grace_period = var.asg_health_check_grace_period
  health_check_type         = upper(var.asg_health_check_type)

  target_group_arns     = var.asg_target_group_arns
  load_balancers        = var.asg_load_balancers
  min_elb_capacity      = var.asg_min_elb_capacity
  wait_for_elb_capacity = var.asg_wait_for_elb_capacity

  default_cooldown          = var.asg_default_cooldown
  force_delete              = var.asg_force_delete
  termination_policies      = var.asg_termination_policies
  suspended_processes       = var.asg_suspended_processes
  placement_group           = var.asg_placement_group
  enabled_metrics           = var.asg_enabled_metrics
  metrics_granularity       = var.asg_metrics_granularity
  wait_for_capacity_timeout = var.asg_wait_for_capacity_timeout
  protect_from_scale_in     = var.asg_protect_from_scale_in
  max_instance_lifetime     = var.asg_max_instance_lifetime
  service_linked_role_arn   = var.asg_service_linked_role_arn

  dynamic "mixed_instances_policy" {
    iterator = mixed_instances_policy
    for_each = var.asg_mixed_instances_policy

    content {
      dynamic "instances_distribution" {
        iterator = instances_distribution
        for_each = lookup(mixed_instances_policy.value, "instances_distribution", [])

        content {
          on_demand_allocation_strategy            = lookup(instances_distribution.value, "on_demand_allocation_strategy", null)
          on_demand_base_capacity                  = lookup(instances_distribution.value, "on_demand_base_capacity", null)
          on_demand_percentage_above_base_capacity = lookup(instances_distribution.value, "on_demand_percentage_above_base_capacity", null)
          spot_allocation_strategy                 = lookup(instances_distribution.value, "spot_allocation_strategy", null)
          spot_instance_pools                      = lookup(instances_distribution.value, "spot_instance_pools", null)
          spot_max_price                           = lookup(instances_distribution.value, "spot_max_price", null)
        }
      }

      dynamic "launch_template" {
        iterator = launch_template
        for_each = lookup(mixed_instances_policy.value, "launch_template", [])

        content {
          dynamic "launch_template_specification" {
            iterator = launch_template_specification
            for_each = lookup(launch_template.value, "launch_template_specification", [])

            content {
              launch_template_name = lookup(launch_template_specification.value, "launch_template_name", null)
              launch_template_id   = lookup(launch_template_specification.value, "launch_template_id", null)
              version              = lookup(launch_template_specification.value, "version", "$Default")
            }
          }

          dynamic "override" {
            iterator = override
            for_each = lookup(launch_template.value, "override", [])

            content {
              instance_type     = lookup(override.value, "instance_type", null)
              weighted_capacity = lookup(override.value, "weighted_capacity", null)
            }
          }
        }
      }
    }
  }

  dynamic "launch_template" {
    iterator = launch_template
    for_each = var.asg_launch_template

    content {
      id      = lookup(launch_template.value, "id", null)
      name    = lookup(launch_template.value, "name", null)
      version = lookup(launch_template.value, "version", "$Default")
    }
  }

  dynamic "initial_lifecycle_hook" {
    iterator = initial_lifecycle_hook
    for_each = var.asg_initial_lifecycle_hook

    content {
      name                 = lookup(initial_lifecycle_hook.value, "name", null)
      default_result       = lookup(initial_lifecycle_hook.value, "default_result", null)
      heartbeat_timeout    = lookup(initial_lifecycle_hook.value, "heartbeat_timeout", null)
      lifecycle_transition = lookup(initial_lifecycle_hook.value, "lifecycle_transition", null)

      notification_metadata   = lookup(initial_lifecycle_hook.value, "notification_metadata", null)
      notification_target_arn = lookup(initial_lifecycle_hook.value, "notification_target_arn", null)
      role_arn                = lookup(initial_lifecycle_hook.value, "role_arn", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.asg_timeouts)) > 0 ? [var.asg_timeouts] : []

    content {
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  dynamic "warm_pool" {
    iterator = warm_pool
    for_each = var.asg_warm_pool

    content {
      pool_state                  = lookup(warm_pool.value, "pool_state ", null)
      min_size                    = lookup(warm_pool.value, "min_size ", null)
      max_group_prepared_capacity = lookup(warm_pool.value, "max_group_prepared_capacity ", null)
    }
  }

  dynamic "instance_refresh" {
    iterator = instance_refresh
    for_each = var.aws_instance_refresh

    content {
      strategy = lookup(instance_refresh.value, "strategy ", null)

      triggers = lookup(warm_pool.value, "triggers ", null)

      dynamic "preferences" {
        iterator = preferences
        for_each = lookup(instance_refresh.value, "preferences", [])

        content {
          checkpoint_delay       = lookup(preferences.value, "checkpoint_delay ", null)
          checkpoint_percentages = lookup(preferences.value, "checkpoint_percentages ", null)
          instance_warmup        = lookup(preferences.value, "instance_warmup ", null)
          min_healthy_percentage = lookup(preferences.value, "min_healthy_percentage ", null)
        }
      }
    }
  }

  dynamic "tag" {
    iterator = tag
    for_each = var.asg_tags

    content {
      key                 = lookup(tag.value, "key", null)
      value               = lookup(tag.value, "value", null)
      propagate_at_launch = lookup(tag.value, "propagate_at_launch", null)
    }
  }

  lifecycle {
    create_before_destroy = false
    ignore_changes        = []
  }

  depends_on = [
    aws_launch_configuration.lc,
    aws_launch_template.lt
  ]
}
