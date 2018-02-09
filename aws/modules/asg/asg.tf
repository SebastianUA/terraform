#---------------------------------------------------
# Create AWS ASG
#---------------------------------------------------
resource "aws_autoscaling_group" "asg" {
    count                       = "${var.create_asg}"
    
    launch_configuration        = "${var.create_lc ? element(aws_launch_configuration.lc.*.name, 0) : var.launch_configuration}"
    #name                        = "${var.name}-asg-${var.environment}"
    name_prefix                 = "${var.name}-asg-"
    #Have got issue with availability_zones usage. So, I skip this parameter.
    #availability_zones          = ["${split(",", (lookup(var.availability_zones, var.region)))}"] #["us-east-1a", "us-east-1b"]
    max_size                    = "${var.asg_max_size}"
    min_size                    = "${var.asg_min_size}"
    vpc_zone_identifier         = ["${var.vpc_zone_identifier}"]
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
    
    depends_on  = ["aws_launch_configuration.lc"]
}
#---------------------------------------------------
# Data for ASG
#---------------------------------------------------
data "template_file" "instances_index" {
    count       = "${var.asg_max_size}"
    template    = "${lower(var.name)}-${lower(var.environment)}-${count.index+1}"
}
#---------------------------------------------------
# Define SSH key pair for our instances
#---------------------------------------------------
resource "aws_key_pair" "key_pair" {
  key_name = "${lower(var.name)}-key_pair-${lower(var.environment)}"
  public_key = "${file("${var.key_path}")}"
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
    user_data                   = "${var.user_data}"
    associate_public_ip_address = "${var.enable_associate_public_ip_address}"
    
    enable_monitoring           = "${var.monitoring}"
    
    placement_tenancy           = "${var.placement_tenancy}"
    #placement_tenancy does not work with spot_price
    #spot_price                  = "${var.spot_price}"  
    
    ebs_optimized               = "${var.ebs_optimized}"
    ebs_block_device            = "${var.ebs_block_device}"
    ephemeral_block_device      = "${var.ephemeral_block_device}"
    root_block_device           = "${var.root_block_device}"

    lifecycle {
        create_before_destroy = "true" #"${var.enable_create_before_destroy}"
    }
    
    depends_on = ["aws_key_pair.key_pair"]
    
}
#---------------------------------------------------
# Add autoscaling policy rules
#---------------------------------------------------
resource "aws_autoscaling_policy" "scale_up" {
    count                   = "${var.enable_autoscaling_schedule ? 1 : 0}"
    
    name                    = "${var.name}-asg_policy-${var.environment}-scale_up"
    scaling_adjustment      = "${var.asg_size_scale}"
    adjustment_type         = "${var.adjustment_type}"
    cooldown                = "${var.default_cooldown}"
    autoscaling_group_name  = "${aws_autoscaling_group.asg.name}"
    
    lifecycle { 
        create_before_destroy = true 
    }
    
    depends_on  = ["aws_autoscaling_group.asg"]
}
resource "aws_autoscaling_policy" "scale_down" {
    count                   = "${var.enable_autoscaling_schedule ? 1 : 0}"
    
    name                    = "${var.name}-asg_policy-${var.environment}-scale_down"
    scaling_adjustment      = "-${var.asg_size_scale}"
    adjustment_type         = "${var.adjustment_type}"
    cooldown                = "${var.default_cooldown}"
    autoscaling_group_name  = "${aws_autoscaling_group.asg.name}"

    lifecycle {
        create_before_destroy = true
    }
    
    depends_on  = ["aws_autoscaling_group.asg"]
}
#---------------------------------------------------
# ASW ASG Scale-up/Scale-down
#---------------------------------------------------
resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
    count                   = "${var.enable_autoscaling_schedule ? 1 : 0}"
    
    scheduled_action_name   = "scale-out-during-business-hours"
    min_size                = "${var.asg_min_size}"
    max_size                = "${var.asg_size_scale}"
    desired_capacity        = "${var.asg_size_scale}"
    recurrence              = "${var.asg_recurrence_scale_up}"
    autoscaling_group_name  = "${aws_autoscaling_group.asg.name}"

    depends_on              = ["aws_autoscaling_group.asg"]
}
resource "aws_autoscaling_schedule" "scale_in_at_night" {
    count                   = "${var.enable_autoscaling_schedule ? 1 : 0}"
    
    scheduled_action_name   = "scale-in-at-night"
    min_size                = "${var.asg_min_size}"
    max_size                = "${var.asg_size_scale}"
    desired_capacity        = "${var.asg_min_size}"
    recurrence              = "${var.asg_recurrence_scale_down}"
    autoscaling_group_name  = "${aws_autoscaling_group.asg.name}"

    depends_on              = ["aws_autoscaling_group.asg"]
}

