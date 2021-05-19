#---------------------------------------------------
# Create AWS ASG
#---------------------------------------------------
resource "aws_autoscaling_group" "asg" {
  count = var.enable_asg && var.name_prefix == "" && !var.enable_asg_azs ? 1 : 0

  name                 = var.asg_name != "" ? var.asg_name : "${lower(var.name)}-asg-${lower(var.environment)}"
  launch_configuration = var.launch_configuration != "" ? var.launch_configuration : element(concat(aws_launch_configuration.lc.*.name, aws_launch_configuration.lc_spot.*.name, [""]), 0)
  vpc_zone_identifier  = var.vpc_zone_identifier
  max_size             = var.asg_max_size
  min_size             = var.asg_min_size
  desired_capacity     = var.desired_capacity

  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type
  load_balancers            = var.load_balancers

  min_elb_capacity          = var.min_elb_capacity
  wait_for_elb_capacity     = var.wait_for_elb_capacity
  target_group_arns         = var.target_group_arns
  default_cooldown          = var.default_cooldown
  force_delete              = var.force_delete
  termination_policies      = var.termination_policies
  suspended_processes       = var.suspended_processes
  placement_group           = var.placement_group
  enabled_metrics           = var.enabled_metrics
  metrics_granularity       = var.metrics_granularity
  wait_for_capacity_timeout = var.wait_for_capacity_timeout
  protect_from_scale_in     = var.protect_from_scale_in

  tags = concat(
    [
      {
        key                 = "Name"
        value               = var.asg_name != "" ? var.asg_name : "${lower(var.name)}-ec2-${lower(var.environment)}"
        propagate_at_launch = true
      }
    ],
    var.tags
  )

  timeouts {
    delete = var.timeouts_delete
  }

  lifecycle {
    create_before_destroy = false
    ignore_changes        = []
  }

  depends_on = [
    aws_launch_configuration.lc,
    aws_launch_configuration.lc_spot
  ]
}

resource "aws_autoscaling_group" "asg_prefix" {
  count = var.enable_asg && var.name_prefix != "" && !var.enable_asg_azs ? 1 : 0

  launch_configuration = var.launch_configuration != "" ? var.launch_configuration : element(concat(aws_launch_configuration.lc_prefix.*.name, aws_launch_configuration.lc_spot_prefix.*.name, [""]), 0)
  name_prefix          = var.name_prefix
  vpc_zone_identifier  = var.vpc_zone_identifier
  max_size             = var.asg_max_size
  min_size             = var.asg_min_size
  desired_capacity     = var.desired_capacity

  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type
  load_balancers            = var.load_balancers

  min_elb_capacity          = var.min_elb_capacity
  wait_for_elb_capacity     = var.wait_for_elb_capacity
  target_group_arns         = var.target_group_arns
  default_cooldown          = var.default_cooldown
  force_delete              = var.force_delete
  termination_policies      = var.termination_policies
  suspended_processes       = var.suspended_processes
  placement_group           = var.placement_group
  enabled_metrics           = var.enabled_metrics
  metrics_granularity       = var.metrics_granularity
  wait_for_capacity_timeout = var.wait_for_capacity_timeout
  protect_from_scale_in     = var.protect_from_scale_in

  tags = concat(
    [
      {
        key                 = "Name"
        value               = var.name_prefix != "" ? var.name_prefix : "${lower(var.name)}-ec2-"
        propagate_at_launch = true
      }
    ],
    var.tags
  )

  timeouts {
    delete = var.timeouts_delete
  }

  lifecycle {
    create_before_destroy = false
    ignore_changes        = []
  }

  depends_on = [
    aws_launch_configuration.lc_prefix,
    aws_launch_configuration.lc_spot_prefix
  ]
}

#---------------------------------------------------
# Create AWS ASG AZS
#---------------------------------------------------
resource "aws_autoscaling_group" "asg_azs" {
  count = var.enable_asg && var.name_prefix == "" && var.enable_asg_azs ? 1 : 0

  name                 = var.asg_name != "" ? var.asg_name : "${lower(var.name)}-asg-${lower(var.environment)}"
  launch_configuration = var.launch_configuration != "" ? var.launch_configuration : element(concat(aws_launch_configuration.lc.*.name, aws_launch_configuration.lc_spot.*.name, [""]), 0)
  availability_zones   = split(",", (lookup(var.availability_zones, var.region)))
  max_size             = var.asg_max_size
  min_size             = var.asg_min_size
  desired_capacity     = var.desired_capacity

  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type
  load_balancers            = var.load_balancers

  min_elb_capacity          = var.min_elb_capacity
  wait_for_elb_capacity     = var.wait_for_elb_capacity
  target_group_arns         = var.target_group_arns
  default_cooldown          = var.default_cooldown
  force_delete              = var.force_delete
  termination_policies      = var.termination_policies
  suspended_processes       = var.suspended_processes
  placement_group           = var.placement_group
  enabled_metrics           = var.enabled_metrics
  metrics_granularity       = var.metrics_granularity
  wait_for_capacity_timeout = var.wait_for_capacity_timeout
  protect_from_scale_in     = var.protect_from_scale_in

  #launch_template             = var.launch_template
  #mixed_instances_policy  {
  #    instances_distribution {
  #        on_demand_allocation_strategy               = "prioritized"
  #        on_demand_base_capacity                     = "0"
  #        on_demand_percentage_above_base_capacity    = "0"
  #        spot_allocation_strategy                    = "lowest-price"
  #        spot_instance_pools                         = "2"
  #        spot_max_price                              = ""
  #    }
  #    launch_template {
  #        launch_template_specification {
  #            launch_template_id      = ""
  #            launch_template_name    = ""
  #            version                 = "$Default"
  #        }
  #        override {
  #            instance_type = ""
  #        }
  #    }
  #}

  tags = concat(
    [
      {
        key                 = "Name"
        value               = var.asg_name != "" ? var.asg_name : "${lower(var.name)}-ec2-${lower(var.environment)}"
        propagate_at_launch = true
      }
    ],
    var.tags
  )

  timeouts {
    delete = var.timeouts_delete
  }

  lifecycle {
    create_before_destroy = false
    ignore_changes        = []
  }

  depends_on = [
    aws_launch_configuration.lc,
    aws_launch_configuration.lc_spot
  ]
}

resource "aws_autoscaling_group" "asg_azs_prefix" {
  count = var.enable_asg && var.name_prefix != "" && var.enable_asg_azs ? 1 : 0

  launch_configuration = var.launch_configuration != "" ? var.launch_configuration : element(concat(aws_launch_configuration.lc_prefix.*.name, aws_launch_configuration.lc_spot_prefix.*.name, [""]), 0)
  name_prefix          = var.name_prefix
  availability_zones   = split(",", (lookup(var.availability_zones, var.region)))
  max_size             = var.asg_max_size
  min_size             = var.asg_min_size
  desired_capacity     = var.desired_capacity

  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type
  load_balancers            = var.load_balancers

  min_elb_capacity          = var.min_elb_capacity
  wait_for_elb_capacity     = var.wait_for_elb_capacity
  target_group_arns         = var.target_group_arns
  default_cooldown          = var.default_cooldown
  force_delete              = var.force_delete
  termination_policies      = var.termination_policies
  suspended_processes       = var.suspended_processes
  placement_group           = var.placement_group
  enabled_metrics           = var.enabled_metrics
  metrics_granularity       = var.metrics_granularity
  wait_for_capacity_timeout = var.wait_for_capacity_timeout
  protect_from_scale_in     = var.protect_from_scale_in

  #launch_template             = var.launch_template
  #mixed_instances_policy  {
  #    instances_distribution {
  #        on_demand_allocation_strategy               = "prioritized"
  #        on_demand_base_capacity                     = "0"
  #        on_demand_percentage_above_base_capacity    = "0"
  #        spot_allocation_strategy                    = "lowest-price"
  #        spot_instance_pools                         = "2"
  #        spot_max_price                              = ""
  #    }
  #    launch_template {
  #        launch_template_specification {
  #            launch_template_id      = ""
  #            launch_template_name    = ""
  #            version                 = "$Default"
  #        }
  #        override {
  #            instance_type = ""
  #        }
  #    }
  #}

  tags = concat(
    [
      {
        key                 = "Name"
        value               = var.name_prefix != "" ? var.name_prefix : "${lower(var.name)}-ec2-"
        propagate_at_launch = true
      }
    ],
    var.tags
  )

  timeouts {
    delete = var.timeouts_delete
  }

  lifecycle {
    create_before_destroy = false
    ignore_changes        = []
  }

  depends_on = [
    aws_launch_configuration.lc_prefix,
    aws_launch_configuration.lc_spot_prefix
  ]
}
