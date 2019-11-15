#---------------------------------------------------
# Create launch_template
#---------------------------------------------------

# https://www.terraform.io/docs/providers/aws/d/launch_template.html
# https://www.terraform.io/docs/providers/aws/r/launch_template.html

#---------------------------------------------------
# Create AWS ASG
#---------------------------------------------------
resource "aws_autoscaling_group" "launch_template" {
    count                       = "${var.enable_launch_template && var.name_prefix =="" && !var.enable_asg_azs ? 1 : 0}"
    
    #launch_configuration        = "${var.launch_configuration}"
    name                        = "${var.name}-asg-${var.environment}"
    vpc_zone_identifier         = ["${var.vpc_zone_identifier}"]
    max_size                    = "${var.asg_max_size}"
    min_size                    = "${var.asg_min_size}"
    desired_capacity            = "${var.desired_capacity}"
    
    health_check_grace_period   = "${var.health_check_grace_period}"
    health_check_type           = "${var.health_check_type}"
    load_balancers              = ["${var.load_balancers}"]
    
    min_elb_capacity            = "${var.min_elb_capacity}"
    wait_for_elb_capacity       = "${var.wait_for_elb_capacity}"
    target_group_arns           = ["${var.target_group_arns}"]
    default_cooldown            = "${var.default_cooldown}"
    force_delete                = "${var.force_delete}"
    termination_policies        = "${var.termination_policies}"
    suspended_processes         = "${var.suspended_processes}"
    placement_group             = "${var.placement_group}"
    enabled_metrics             = ["${var.enabled_metrics}"]
    metrics_granularity         = "${var.metrics_granularity}"
    wait_for_capacity_timeout   = "${var.wait_for_capacity_timeout}"
    protect_from_scale_in       = "${var.protect_from_scale_in}"

    launch_template             = "${var.launch_template}"

    tags = [
        {
            key                 = "Name"
            value               = "${data.template_file.instances_index.rendered}"
            propagate_at_launch = true
        },
        {
            key                 = "Environment"
            value               = "${var.environment}"
            propagate_at_launch = true
        },
        {
            key                 = "Orchestration"
            value               = "${var.orchestration}"
            propagate_at_launch = true
        },
        {
            key                 = "Createdby"
            value               = "${var.createdby}"
            propagate_at_launch = true
        },
    ]

    timeouts {
        delete  = "${var.timeouts_delete}"
    }

    lifecycle {
        create_before_destroy   = "${var.enable_create_before_destroy}",
        ignore_changes          = [],
    }
    
    depends_on  = []
}

resource "aws_autoscaling_group" "launch_template_prefix" {
    count                       = "${var.enable_launch_template && var.name_prefix !="" && !var.enable_asg_azs ? 1 : 0}"
    
    #launch_configuration        = "${var.launch_configuration}"
    name_prefix                 = "${var.name_prefix}"
    vpc_zone_identifier         = ["${var.vpc_zone_identifier}"]
    max_size                    = "${var.asg_max_size}"
    min_size                    = "${var.asg_min_size}"
    desired_capacity            = "${var.desired_capacity}"
    
    health_check_grace_period   = "${var.health_check_grace_period}"
    health_check_type           = "${var.health_check_type}"
    load_balancers              = ["${var.load_balancers}"]
    
    min_elb_capacity            = "${var.min_elb_capacity}"
    wait_for_elb_capacity       = "${var.wait_for_elb_capacity}"
    target_group_arns           = ["${var.target_group_arns}"]
    default_cooldown            = "${var.default_cooldown}"
    force_delete                = "${var.force_delete}"
    termination_policies        = "${var.termination_policies}"
    suspended_processes         = "${var.suspended_processes}"
    placement_group             = "${var.placement_group}"
    enabled_metrics             = ["${var.enabled_metrics}"]
    metrics_granularity         = "${var.metrics_granularity}"
    wait_for_capacity_timeout   = "${var.wait_for_capacity_timeout}"
    protect_from_scale_in       = "${var.protect_from_scale_in}"

    launch_template             = "${var.launch_template}"

    tags = [
        {
            key                 = "Name"
            value               = "${data.template_file.instances_index.rendered}"
            propagate_at_launch = true
        },
        {
            key                 = "Environment"
            value               = "${var.environment}"
            propagate_at_launch = true
        },
        {
            key                 = "Orchestration"
            value               = "${var.orchestration}"
            propagate_at_launch = true
        },
        {
            key                 = "Createdby"
            value               = "${var.createdby}"
            propagate_at_launch = true
        },
    ]

    timeouts {
        delete  = "${var.timeouts_delete}"
    }

    lifecycle {
        create_before_destroy   = "${var.enable_create_before_destroy}",
        ignore_changes          = [],
    }
    
    depends_on  = []
}

resource "aws_autoscaling_group" "launch_template_mixed_instances_policy" {
    count                       = "${var.enable_launch_template_mixed_instances_policy && var.name_prefix =="" && !var.enable_asg_azs ? 1 : 0}"
    
    #launch_configuration        = "${var.launch_configuration}"
    name                        = "${var.name}-asg-${var.environment}"
    vpc_zone_identifier         = ["${var.vpc_zone_identifier}"]
    max_size                    = "${var.asg_max_size}"
    min_size                    = "${var.asg_min_size}"
    desired_capacity            = "${var.desired_capacity}"
    
    health_check_grace_period   = "${var.health_check_grace_period}"
    health_check_type           = "${var.health_check_type}"
    load_balancers              = ["${var.load_balancers}"]
    
    min_elb_capacity            = "${var.min_elb_capacity}"
    wait_for_elb_capacity       = "${var.wait_for_elb_capacity}"
    target_group_arns           = ["${var.target_group_arns}"]
    default_cooldown            = "${var.default_cooldown}"
    force_delete                = "${var.force_delete}"
    termination_policies        = "${var.termination_policies}"
    suspended_processes         = "${var.suspended_processes}"
    placement_group             = "${var.placement_group}"
    enabled_metrics             = ["${var.enabled_metrics}"]
    metrics_granularity         = "${var.metrics_granularity}"
    wait_for_capacity_timeout   = "${var.wait_for_capacity_timeout}"
    protect_from_scale_in       = "${var.protect_from_scale_in}"

    mixed_instances_policy  {
        instances_distribution {
            on_demand_allocation_strategy               = "prioritized"
            on_demand_base_capacity                     = "0"
            on_demand_percentage_above_base_capacity    = "0"
            spot_allocation_strategy                    = "lowest-price"
            spot_instance_pools                         = "2"
            spot_max_price                              = ""
        }
        launch_template {
            launch_template_specification {
                launch_template_id      = ""
                launch_template_name    = ""
                version                 = "$Default"
            }
            override {
                instance_type = ""
            }
        }    
    }    

    tags = [
        {
            key                 = "Name"
            value               = "${data.template_file.instances_index.rendered}"
            propagate_at_launch = true
        },
        {
            key                 = "Environment"
            value               = "${var.environment}"
            propagate_at_launch = true
        },
        {
            key                 = "Orchestration"
            value               = "${var.orchestration}"
            propagate_at_launch = true
        },
        {
            key                 = "Createdby"
            value               = "${var.createdby}"
            propagate_at_launch = true
        },
    ]

    timeouts {
        delete  = "${var.timeouts_delete}"
    }

    lifecycle {
        create_before_destroy   = "${var.enable_create_before_destroy}",
        ignore_changes          = [],
    }
    
    depends_on  = []
}

resource "aws_autoscaling_group" "launch_template_prefix_mixed_instances_policy" {
    count                       = "${var.enable_launch_template_mixed_instances_policy && var.name_prefix !="" && !var.enable_asg_azs ? 1 : 0}"
    
    #launch_configuration        = "${var.launch_configuration}"
    name_prefix                 = "${var.name_prefix}"
    vpc_zone_identifier         = ["${var.vpc_zone_identifier}"]
    max_size                    = "${var.asg_max_size}"
    min_size                    = "${var.asg_min_size}"
    desired_capacity            = "${var.desired_capacity}"
    
    health_check_grace_period   = "${var.health_check_grace_period}"
    health_check_type           = "${var.health_check_type}"
    load_balancers              = ["${var.load_balancers}"]
    
    min_elb_capacity            = "${var.min_elb_capacity}"
    wait_for_elb_capacity       = "${var.wait_for_elb_capacity}"
    target_group_arns           = ["${var.target_group_arns}"]
    default_cooldown            = "${var.default_cooldown}"
    force_delete                = "${var.force_delete}"
    termination_policies        = "${var.termination_policies}"
    suspended_processes         = "${var.suspended_processes}"
    placement_group             = "${var.placement_group}"
    enabled_metrics             = ["${var.enabled_metrics}"]
    metrics_granularity         = "${var.metrics_granularity}"
    wait_for_capacity_timeout   = "${var.wait_for_capacity_timeout}"
    protect_from_scale_in       = "${var.protect_from_scale_in}"

    mixed_instances_policy  {
        instances_distribution {
            on_demand_allocation_strategy               = "prioritized"
            on_demand_base_capacity                     = "0"
            on_demand_percentage_above_base_capacity    = "0"
            spot_allocation_strategy                    = "lowest-price"
            spot_instance_pools                         = "2"
            spot_max_price                              = ""
        }
        launch_template {
            launch_template_specification {
                launch_template_id      = ""
                launch_template_name    = ""
                version                 = "$Default"
            }
            override {
                instance_type = ""
            }
        }    
    } 

    tags = [
        {
            key                 = "Name"
            value               = "${data.template_file.instances_index.rendered}"
            propagate_at_launch = true
        },
        {
            key                 = "Environment"
            value               = "${var.environment}"
            propagate_at_launch = true
        },
        {
            key                 = "Orchestration"
            value               = "${var.orchestration}"
            propagate_at_launch = true
        },
        {
            key                 = "Createdby"
            value               = "${var.createdby}"
            propagate_at_launch = true
        },
    ]

    timeouts {
        delete  = "${var.timeouts_delete}"
    }

    lifecycle {
        create_before_destroy   = "${var.enable_create_before_destroy}",
        ignore_changes          = [],
    }
    
    depends_on  = []
}


data "template_file" "instances_index" {
    count       = "${var.asg_max_size}"
    template    = "${lower(var.name)}-${lower(var.environment)}-${count.index+1}"
}