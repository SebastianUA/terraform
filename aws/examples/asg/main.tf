#############################################################
# AWS key pair
#############################################################
module "key_pair" {
    source                              = "../../modules/key_pair"

    enable_key_pair                     = true
    key_name                            = "test-key"
    public_key                          = file("./additional_files/prod-bastion_ukraine.pub")
}

module "asg" {
    source                              = "../../modules/asg"
    name                                = "my-first"
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
    user_data                           = file("./additional_files/bootstrap.sh")

    enable_monitoring                   = "true"
    placement_tenancy                   = "default"

    root_block_device  = [
        {
            volume_size = "8"
            volume_type = "gp2"
        },
    ]

    #enable_associate_public_ip_address  = true

    # asg
    enable_asg                          = "true"
    vpc_zone_identifier                 = ["subnet-0e2b323b731655057", "subnet-0ffa47878036f1641", "subnet-096406cfdf907ee11"]
    asg_max_size                        = 1
    asg_min_size                        = 0
    desired_capacity                    = 1
    wait_for_capacity_timeout           = "0"

    # ASG attachment
    #load_balancer_type                  = "ALB"
    #load_balancers                      = ["test-lb"]
    #alb_target_group_arn                = "lb_arn_here"

    # ASG policy
    enable_autoscaling_policy           = true
}
