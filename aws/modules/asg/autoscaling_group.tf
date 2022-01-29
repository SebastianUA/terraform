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

  max_size         = var.asg_max_size
  min_size         = var.asg_min_size
  desired_capacity = var.asg_desired_capacity

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

  dynamic "mixed_instances_policy" {
    iterator = mixed_instances_policy
    for_each = var.asg_mixed_instances_policy

    content {
      instances_distribution {
        on_demand_allocation_strategy            = lookup(mixed_instances_policy.value, "on_demand_allocation_strategy", null)
        on_demand_base_capacity                  = lookup(mixed_instances_policy.value, "on_demand_base_capacity", null)
        on_demand_percentage_above_base_capacity = lookup(mixed_instances_policy.value, "on_demand_percentage_above_base_capacity", null)
        spot_allocation_strategy                 = lookup(mixed_instances_policy.value, "spot_allocation_strategy", null)
        spot_instance_pools                      = lookup(mixed_instances_policy.value, "spot_instance_pools", null)
        spot_max_price                           = lookup(mixed_instances_policy.value, "spot_max_price", null)
      }

      launch_template {
        launch_template_specification {
          launch_template_name = lookup(mixed_instances_policy.value, "launch_template_name", null)
          launch_template_id   = lookup(mixed_instances_policy.value, "launch_template_id", null)
          version              = lookup(mixed_instances_policy.value, "version", "$Default")
        }

        override {
          instance_type     = lookup(mixed_instances_policy.value, "instance_type", null)
          weighted_capacity = lookup(mixed_instances_policy.value, "weighted_capacity", null)
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
    for_each = var.asg_timeouts

    content {
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = concat(
    [
      {
        key                 = "Name"
        value               = var.asg_name != "" ? var.asg_name : (var.asg_name_prefix == null ? "${lower(var.name)}-asg-${lower(var.environment)}" : var.asg_name_prefix)
        propagate_at_launch = true
      }
    ],
    var.asg_tags
  )

  lifecycle {
    create_before_destroy = false
    ignore_changes        = []
  }

  depends_on = [
    aws_launch_configuration.lc,
    aws_launch_template.lt
  ]
}
