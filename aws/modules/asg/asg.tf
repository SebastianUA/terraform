#---------------------------------------------------
# Create AWS ASG
#---------------------------------------------------
resource "aws_autoscaling_group" "asg" {
    count                       = "${var.create_asg && !var.enable_asg_azs ? 1 : 0}"
    
    launch_configuration        = "${var.create_lc ? element(aws_launch_configuration.lc.*.name, 0) : var.launch_configuration}"
    #name                        = "${var.name}-asg-${var.environment}"
    name_prefix                 = "${var.name}-asg-"
    #Have got issue between availability_zones and vpc_zone_identifier. I preferred vpc_zone_identifier.....  
    #availability_zones          = ["${split(",", (lookup(var.availability_zones, var.region)))}"]
    vpc_zone_identifier         = ["${var.vpc_zone_identifier}"]
    max_size                    = "${var.asg_max_size}"
    min_size                    = "${var.asg_min_size}"
    desired_capacity            = "${var.desired_capacity}"
    
    health_check_grace_period   = "${var.health_check_grace_period}"
    health_check_type           = "${var.health_check_type}"
    #load_balancers              = ["${var.load_balancers}"]
    
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

    lifecycle {
        create_before_destroy   = true,
        ignore_changes          = [],
    }
    
    depends_on  = ["aws_launch_configuration.lc"]
}

resource "aws_autoscaling_group" "asg_azs" {
    count                       = "${var.create_asg && var.enable_asg_azs ? 1 : 0}"

    launch_configuration        = "${var.create_lc ? element(aws_launch_configuration.lc.*.name, 0) : var.launch_configuration}"
    #name                        = "${var.name}-asg-${var.environment}"
    name_prefix                 = "${var.name}-asg-"
    availability_zones          = ["${split(",", (lookup(var.availability_zones, var.region)))}"]
    max_size                    = "${var.asg_max_size}"
    min_size                    = "${var.asg_min_size}"
    desired_capacity            = "${var.desired_capacity}"

    health_check_grace_period   = "${var.health_check_grace_period}"
    health_check_type           = "${var.health_check_type}"
    #load_balancers              = ["${var.load_balancers}"]

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

    lifecycle {
        create_before_destroy   = true,
        ignore_changes          = [],
    }

    depends_on  = ["aws_launch_configuration.lc"]
}

data "template_file" "instances_index" {
    count       = "${var.asg_max_size}"
    template    = "${lower(var.name)}-${lower(var.environment)}-${count.index+1}"
}

#---------------------------------------------------
# Create AWS autoscaling_attachment
#---------------------------------------------------
resource "aws_autoscaling_attachment" "elb_autoscaling_attachment" {
    count                   = "${upper(var.load_balancer_type) == "ELB" && length(var.load_balancers) > 0 ? 1 : 0}"
    #autoscaling_group_name  = "${aws_autoscaling_group.asg.id}"
    autoscaling_group_name  = "${var.create_asg && !var.enable_asg_azs ? "${aws_autoscaling_group.asg.id}" : "${aws_autoscaling_group.asg_azs.id}" }"

    elb                     = "${data.template_file.elb_index.rendered}"

    lifecycle {
        create_before_destroy   = true,
        ignore_changes          = [],
    }

    depends_on  = []
}
data "template_file" "elb_index" {
    count       = "${length(var.load_balancers)}"
    template    = "${var.load_balancers[count.index]}"
}

resource "aws_autoscaling_attachment" "alb_autoscaling_attachment" {
    count                   = "${upper(var.load_balancer_type) == "ALB" && length(var.load_balancers) > 0 ? 1 : 0}"
    #autoscaling_group_name  = "${aws_autoscaling_group.asg.id}"
    autoscaling_group_name  = "${var.create_asg && !var.enable_asg_azs ? "${aws_autoscaling_group.asg.id}" : "${aws_autoscaling_group.asg_azs.id}" }"
    alb_target_group_arn    = "${data.template_file.alb_index.rendered}" 

    lifecycle {
        create_before_destroy   = true,
        ignore_changes          = [],
    }
    
    depends_on  = []
}
data "template_file" "alb_index" {
    count       = "${length(var.load_balancers)}"
    template    = "${var.load_balancers[count.index]}"
}

#---------------------------------------------------
# Create AWS autoscaling_notification
#---------------------------------------------------
data "aws_autoscaling_groups" "autoscaling_groups" {
    filter = ["${var.autoscaling_groups_filter}"]
}

resource "aws_autoscaling_notification" "autoscaling_notification" {
    count                   = "${var.enable_autoscaling_notification && length(var.autoscaling_notification_topic_arn) > 0 ? 1 : 0}"
    
    group_names             = ["${data.aws_autoscaling_groups.autoscaling_groups.names}"]
    notifications           = ["${var.autoscaling_notification_notifications}"]
    topic_arn               = "${var.autoscaling_notification_topic_arn}"

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }
 
    depends_on = ["data.aws_autoscaling_groups.autoscaling_groups"]
}

#---------------------------------------------------
# Create AWS autoscaling lifecycle hook
#---------------------------------------------------
resource "aws_autoscaling_lifecycle_hook" "autoscaling_lifecycle_hook" {
    count                   = "${var.enable_autoscaling_lifecycle_hook && !var.enable_asg_azs ? 1 : 0 }"
                                                         
    name                    = "${lower(var.name)}-asg-lifecycle-hook-${lower(var.environment)}"
    #autoscaling_group_name  = "${aws_autoscaling_group.asg.name}"
    autoscaling_group_name  = "${length(var.autoscaling_group_name) > 0 ? "${var.autoscaling_group_name}" : "${aws_autoscaling_group.asg.name}" }"

    default_result          = "${var.autoscaling_lifecycle_hook_default_result}"
    heartbeat_timeout       = "${var.autoscaling_lifecycle_hook_heartbeat_timeout}"
    lifecycle_transition    = "${var.autoscaling_lifecycle_hook_lifecycle_transition}"
    
    notification_metadata   = "${var.autoscaling_lifecycle_hook_notification_metadata}"

    notification_target_arn = "${var.autoscaling_lifecycle_hook_notification_target_arn}"
    role_arn                = "${var.autoscaling_lifecycle_hook_role_arn}"

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on = ["aws_autoscaling_group.asg"]
}

resource "aws_autoscaling_lifecycle_hook" "autoscaling_lifecycle_hook_azs" {
    count                   = "${var.enable_autoscaling_lifecycle_hook && var.enable_asg_azs ? 1 : 0 }"
    
    name                    = "${lower(var.name)}-asg-lifecycle-hook-${lower(var.environment)}"
    autoscaling_group_name  = "${length(var.autoscaling_group_name) > 0 ? "${var.autoscaling_group_name}" : "${aws_autoscaling_group.asg_azs.name}" }"

    default_result          = "${var.autoscaling_lifecycle_hook_default_result}"
    heartbeat_timeout       = "${var.autoscaling_lifecycle_hook_heartbeat_timeout}"
    lifecycle_transition    = "${var.autoscaling_lifecycle_hook_lifecycle_transition}"

    notification_metadata   = "${var.autoscaling_lifecycle_hook_notification_metadata}"

    notification_target_arn = "${var.autoscaling_lifecycle_hook_notification_target_arn}"
    role_arn                = "${var.autoscaling_lifecycle_hook_role_arn}"

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on = ["aws_autoscaling_group.asg"]
}
#---------------------------------------------------
# Define SSH key pair for our instances
#---------------------------------------------------
resource "aws_key_pair" "key_pair" {
    key_name    = "${lower(var.name)}-key_pair-${lower(var.environment)}"
    public_key  = "${file("${var.key_path}")}"
}
#---------------------------------------------------
# Launch AWS configuration
#---------------------------------------------------
resource "aws_launch_configuration" "lc" {
    count                       = "${var.create_lc}"
    
    #name                        = "${var.name}-lc-${var.environment}"
    name_prefix                 = "${var.name}-lc-"
    image_id                    = "${lookup(var.ami, var.region)}"
    instance_type               = "${var.ec2_instance_type}"
    security_groups             = ["${var.security_groups}"]
    iam_instance_profile        = "${var.iam_instance_profile}"
    
    key_name                    = "${aws_key_pair.key_pair.id}"
    #
    #user_data                   = "$${null}"
    #user_data                   = "${var.user_data}"
    #user_data                   = "${file("${var.user_data}")}"
    #user_data                    = "${file(var.user_data)}"     
    user_data                   = "${data.template_file.user_data.rendered}"
    
              
    #associate_public_ip_address = "${var.enable_associate_public_ip_address}"
    associate_public_ip_address = "${!var.enable_asg_azs ? var.enable_associate_public_ip_address : false }"   

    enable_monitoring           = "${var.monitoring}"
    
    placement_tenancy           = "${var.placement_tenancy}"
    #placement_tenancy does not work with spot_price
    #spot_price                  = "${var.spot_price}"  
    
    ebs_optimized               = "${var.ebs_optimized}"
    ebs_block_device            = "${var.ebs_block_device}"
    ephemeral_block_device      = "${var.ephemeral_block_device}"
    root_block_device           = "${var.root_block_device}"

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = ["user_data"]
    }
    
    depends_on = [
        "aws_key_pair.key_pair",
        "data.template_file.user_data"
    ]
}
  
data "template_file" "user_data" {
    template    = "${file("${var.user_data}")}"
}           
#---------------------------------------------------
# Add autoscaling policy rules
#---------------------------------------------------
resource "aws_autoscaling_policy" "scale_up" {
    count                   = "${var.enable_autoscaling_schedule && !var.enable_asg_azs ? 1 : 0}"
    
    name                    = "${var.name}-asg_policy-${var.environment}-scale_up"
    scaling_adjustment      = "${var.asg_size_scale}"
    adjustment_type         = "${var.adjustment_type}"
    cooldown                = "${var.default_cooldown}"
    #autoscaling_group_name  = "${aws_autoscaling_group.asg.name}"
    autoscaling_group_name  = "${length(var.autoscaling_group_name) > 0 ? "${var.autoscaling_group_name}" : "${aws_autoscaling_group.asg.name}" }"    

    lifecycle {
        create_before_destroy   = true,
        ignore_changes          = [],
    }   

    depends_on  = ["aws_autoscaling_group.asg"]
}

resource "aws_autoscaling_policy" "scale_down" {
    count                   = "${var.enable_autoscaling_schedule && !var.enable_asg_azs ? 1 : 0}"
    
    name                    = "${var.name}-asg_policy-${var.environment}-scale_down"
    scaling_adjustment      = "-${var.asg_size_scale}"
    adjustment_type         = "${var.adjustment_type}"
    cooldown                = "${var.default_cooldown}"
    #autoscaling_group_name  = "${aws_autoscaling_group.asg.name}"
    autoscaling_group_name  = "${length(var.autoscaling_group_name) > 0 ? "${var.autoscaling_group_name}" : "${aws_autoscaling_group.asg.name}" }"    

    lifecycle {
        create_before_destroy   = true,
        ignore_changes          = [],
    }   

    depends_on  = ["aws_autoscaling_group.asg"]
}

resource "aws_autoscaling_policy" "scale_up_azs" {
    count                   = "${var.enable_autoscaling_schedule && var.enable_asg_azs ? 1 : 0}"
    
    name                    = "${var.name}-asg_policy-${var.environment}-scale_up"
    scaling_adjustment      = "${var.asg_size_scale}"
    adjustment_type         = "${var.adjustment_type}"
    cooldown                = "${var.default_cooldown}"
    #autoscaling_group_name  = "${aws_autoscaling_group.asg.name}"
    autoscaling_group_name  = "${length(var.autoscaling_group_name) > 0 ? "${var.autoscaling_group_name}" : "${aws_autoscaling_group.asg_azs.name}" }"

    lifecycle {
        create_before_destroy   = true,
        ignore_changes          = [],
    }   

    depends_on  = ["aws_autoscaling_group.asg_azs"]
}

resource "aws_autoscaling_policy" "scale_down_azs" {
    count                   = "${var.enable_autoscaling_schedule && var.enable_asg_azs ? 1 : 0}"
    
    name                    = "${var.name}-asg_policy-${var.environment}-scale_down"
    scaling_adjustment      = "-${var.asg_size_scale}"
    adjustment_type         = "${var.adjustment_type}"
    cooldown                = "${var.default_cooldown}"
    #autoscaling_group_name  = "${aws_autoscaling_group.asg.name}"
    autoscaling_group_name  = "${length(var.autoscaling_group_name) > 0 ? "${var.autoscaling_group_name}" : "${aws_autoscaling_group.asg_azs.name}" }"

    lifecycle {
        create_before_destroy   = true,
        ignore_changes          = [],
    }   

    depends_on  = ["aws_autoscaling_group.asg_azs"]
}

#---------------------------------------------------
# ASW ASG Scale-up/Scale-down
#---------------------------------------------------
resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
    count                   = "${var.enable_autoscaling_schedule && !var.enable_asg_azs ? 1 : 0}"
    
    scheduled_action_name   = "scale-out-during-business-hours"
    min_size                = "${var.asg_min_size}"
    max_size                = "${var.asg_size_scale}"
    desired_capacity        = "${var.asg_size_scale}"
    recurrence              = "${var.asg_recurrence_scale_up}"
    #autoscaling_group_name  = "${aws_autoscaling_group.asg.name}"
    autoscaling_group_name  = "${length(var.autoscaling_group_name) > 0 ? "${var.autoscaling_group_name}" : "${aws_autoscaling_group.asg.name}" }"

    lifecycle {
        create_before_destroy   = true,
        ignore_changes          = [],
    }

    depends_on              = ["aws_autoscaling_group.asg"]
}

resource "aws_autoscaling_schedule" "scale_in_at_night" {
    count                   = "${var.enable_autoscaling_schedule && !var.enable_asg_azs ? 1 : 0}"
    
    scheduled_action_name   = "scale-in-at-night"
    min_size                = "${var.asg_min_size}"
    max_size                = "${var.asg_size_scale}"
    desired_capacity        = "${var.asg_min_size}"
    recurrence              = "${var.asg_recurrence_scale_down}"
    #autoscaling_group_name  = "${aws_autoscaling_group.asg.name}"
    autoscaling_group_name  = "${length(var.autoscaling_group_name) > 0 ? "${var.autoscaling_group_name}" : "${aws_autoscaling_group.asg.name}" }"

    lifecycle {
        create_before_destroy   = true,
        ignore_changes          = [],
    }

    depends_on              = ["aws_autoscaling_group.asg"]
}

resource "aws_autoscaling_schedule" "scale_out_during_business_hours_azs" {
    count                   = "${var.enable_autoscaling_schedule && var.enable_asg_azs ? 1 : 0}"

    scheduled_action_name   = "scale-out-during-business-hours"
    min_size                = "${var.asg_min_size}"
    max_size                = "${var.asg_size_scale}"
    desired_capacity        = "${var.asg_size_scale}"
    recurrence              = "${var.asg_recurrence_scale_up}"
    #autoscaling_group_name  = "${aws_autoscaling_group.asg.name}"
    autoscaling_group_name  = "${length(var.autoscaling_group_name) > 0 ? "${var.autoscaling_group_name}" : "${aws_autoscaling_group.asg_azs.name}" }"

    lifecycle {
        create_before_destroy   = true,
        ignore_changes          = [],
    }

    depends_on              = ["aws_autoscaling_group.asg_azs"]
}
resource "aws_autoscaling_schedule" "scale_in_at_night_azs" {
    count                   = "${var.enable_autoscaling_schedule && var.enable_asg_azs ? 1 : 0}"

    scheduled_action_name   = "scale-in-at-night"
    min_size                = "${var.asg_min_size}"
    max_size                = "${var.asg_size_scale}"
    desired_capacity        = "${var.asg_min_size}"
    recurrence              = "${var.asg_recurrence_scale_down}"
    #autoscaling_group_name  = "${aws_autoscaling_group.asg.name}"
    autoscaling_group_name  = "${length(var.autoscaling_group_name) > 0 ? "${var.autoscaling_group_name}" : "${aws_autoscaling_group.asg_azs.name}" }"

    lifecycle {
        create_before_destroy   = true,
        ignore_changes          = [],
    }

    depends_on              = ["aws_autoscaling_group.asg_azs"]
}
