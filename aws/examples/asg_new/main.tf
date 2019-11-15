#############################################################
# AWS key pair
#############################################################
module "key_pair" {
    source                              = "../../modules/key_pair"

    enable_key_pair                     = "true"
    key_name                            = "test-key"
    public_key                          = "${file("./additional_files/prod-bastion_ukraine.pub")}"
}

module "lc" {
    source                              = "../../modules/asg_new"
    name                                = "launch-config"
    region                              = "us-west-2"
    environment                         = "test"

    #lc
    enable_lc                           = "true"
    ami = {
        us-west-2 = "ami-08f72eed8a0d9f8e8"
    }

    ec2_instance_type                   = "t2.micro"
    security_groups                     = ["sg-07b62c0d0ea37056d"]
    iam_instance_profile                = ""

    key_name                            = "${element(module.key_pair.aws_key_id, 0)}"
    user_data                           = "${file("./additional_files/bootstrap.sh")}"

    enable_monitoring                   = "true"
    placement_tenancy                   = "default"

    root_block_device  = [
        {
            volume_size = "8"
            volume_type = "gp2"
        },
    ]

    # NOTE: If will be used availability_zones than enable_associate_public_ip_address = false!
    enable_associate_public_ip_address  = true

}

module "asg" {
    source                              = "../../modules/asg_new"
    name                                = "my-first"
    region                              = "us-west-2"
    environment                         = "test"

    # asg
    enable_asg                          = "true"
    launch_configuration                = "${module.lc.this_launch_configuration_id}"
    vpc_zone_identifier                 = ["subnet-0e2b323b731655057", "subnet-0ffa47878036f1641", "subnet-096406cfdf907ee11"]
    asg_max_size                        = 1
    asg_min_size                        = 0
    desired_capacity                    = 1
    wait_for_capacity_timeout           = "0"
}

module "asg_attachment" {
    source                              = "../../modules/asg_new"
    
    load_balancer_type                  = "ALB"
    load_balancers                      = ""

    autoscaling_group_name              = "${module.asg.this_autoscaling_group_id}"
}

module "asg_lifecycle_hook" {
    source                                              = "../../modules/asg_new"

    enable_autoscaling_lifecycle_hook                   = false
    autoscaling_lifecycle_hook_name                     = ""
    autoscaling_group_name                              = "${module.asg.this_autoscaling_group_id}"
    
    autoscaling_lifecycle_hook_default_result           = "ABANDON"
    autoscaling_lifecycle_hook_heartbeat_timeout        = 10
    autoscaling_lifecycle_hook_lifecycle_transition     = "autoscaling:EC2_INSTANCE_LAUNCHING"

    autoscaling_lifecycle_hook_notification_metadata    = ""
    autoscaling_lifecycle_hook_notification_target_arn  = ""
    autoscaling_lifecycle_hook_role_arn                 = ""
}

module "asg_notification" {
    source                                              = "../../modules/asg_new"

    enable_autoscaling_notification                     = false
    autoscaling_notification_topic_arn                  = ""
    autoscaling_notification_notifications              = ""
    autoscaling_groups_filter                           = []
}

module "asg_policy" {
    source                                  = "../../modules/asg_new"
    
    enable_autoscaling_policy               = false

    asg_size_scale                          = "1"
    adjustment_type                         = "ChangeInCapacity"
    default_cooldown                        = "300"
    autoscaling_group_name                  = "${module.asg.this_autoscaling_group_id}"
}

module "asg_schedule" {
    source                                  = "../../modules/asg_new"
    
    enable_autoscaling_schedule             = false
    autoscaling_group_name                  = "${module.asg.this_autoscaling_group_id}"
    asg_min_size                            = 1
    asg_size_scale                          = "1"
    asg_recurrence_scale_up                 = "0 9 * * *"
    asg_recurrence_scale_down               = "0 17 * * *"
}
