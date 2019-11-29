#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
    required_version = "~> 0.12.12"
}

provider "aws" {
    region                  = "us-east-1"
    shared_credentials_file = pathexpand("/Users/captain/.aws/credentials")
    profile                 = "default"
}

module "alb" {
    source                              = "../../modules/alb"
    name                                = "App-Load-Balancer"
    region                              = "us-east-1"
    environment                         = "staging"
    tags                                = "${map("Mytestkey", "test")}"    

    enable_alb                          = true
    load_balancer_type                  = "application"
    alb_name                            = "MyfirstLB"
    security_groups                     = ["sg-aed75fe1"]
    subnets                             = ["subnet-ea58d88d", "subnet-cb5581f5"]
    enable_deletion_protection          = false

    enable_alb_target_group             = true 
    alb_target_group_name               = "myFirstLB"
    backend_protocol                    = "HTTP"
    alb_protocols                       = "HTTP"
    vpc_id                              = "vpc-56af732c"

    frontend_http_port                  = 80
    frontend_http_protocol              = "HTTP"
    frontend_http_default_action_type   = "forward"
    frontend_https_port                 = 443
    frontend_https_protocol             = "HTTPS"
    frontend_https_default_action_type   = "forward"

    #alb_target_group_attachment         = true
    #target_ids                          = ["test", "test2"]

}
