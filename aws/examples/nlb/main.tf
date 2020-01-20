#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
    required_version = "~> 0.12.12"
}

provider "aws" {
    region                  = "us-east-1"
    shared_credentials_file = pathexpand("~/.aws/credentials")
    profile                 = "default"
}

module "nlb" {
    source                              = "../../modules/nlb"
    region                              = "us-east-1"
   
    # NLB
    enable_nlb                          = true
    nlb_name                            = "Network-Load-Balancer"
    subnets                             = ["subnet-8851dea6", "subnet-c3a5f589", "subnet-1d7df041"]
    enable_deletion_protection          = false
    lb_internal                         = false

    # NLB target group
    enable_nlb_target_group             = true
    nlb_target_group_name               = "Network-Load-Balancer"
    vpc_id                              = "vpc-56af732c"
    backend_protocol                    = "TCP"
    backend_port                        = 80
    health_check                        = [
        {
            enabled     = true
            interval    = 10
            port        = 80
            protocol    = "HTTP"
            timeout     = 60
        },
    ]

    # NLB target group attachment
    enable_nlb_target_group_attachment  = true
    target_ids                          = []

    # NLB listeners
    enable_nlb_listener1                = true
    alb_protocols                       = "TCP"
    nlb_listener1_port                  = 80
    nlb_listener1_protocol              = "TCP"

    enable_nlb_listener2                = false
    nlb_listener2_port                  = 443
    nlb_listener2_protocol              = "TCP"
        
}
