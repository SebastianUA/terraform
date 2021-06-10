#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("/Users/captain/.aws/credentials")
  profile                 = "default"

}

module "alb" {
  source      = "../../modules/alb"
  name        = "App-Load-Balancer"
  environment = "staging"

  # Create a new ALB
  enable_alb                     = true
  alb_load_balancer_type         = "application"
  alb_name                       = "MyfirstLB"
  alb_security_groups            = ["sg-0cfb43249902af8f2"]
  alb_subnets                    = ["subnet-087ab3540e1a1ace4", "subnet-03212d250885f6986", "subnet-02b0ff71a1d00deb2"]
  alb_internal                   = false
  alb_enable_deletion_protection = false

  # Create ALB target group
  enable_alb_target_group   = true
  alb_target_group_name     = "myFirstLB"
  alb_target_group_protocol = "HTTP"
  alb_target_group_vpc_id   = "vpc-0ea8873ab2bf7900d"

  alb_target_group_health_check = [
    {
      enabled             = true
      port                = 80
      protocol            = "HTTP"
      interval            = 10
      path                = "/"
      healthy_threshold   = 3
      unhealthy_threshold = 3
      timeout             = 5
      matcher             = "200-299"
    }
  ]

  alb_target_group_stickiness = [
    {
      enabled         = true
      type            = "lb_cookie"
      cookie_duration = 300
    }
  ]

  # Create ALB target group attachment
  enable_alb_target_group_attachment     = false
  alb_target_group_attachment_port       = 80
  alb_target_group_attachment_target_ids = ["id-43243cxfd4", "id-32rxcer34"]

  # Create ALB listener
  enable_alb_listener              = true
  alb_listener_port                = 80
  alb_listener_protocol            = "HTTP"
  alb_listener_default_action_type = "fixed-response"
  alb_listener_default_action_fixed_response = [
    {
      content_type = "text/plain"
      message_body = null
      status_code  = "200"
    }
  ]

  # listener rule rule
  enable_alb_listener_rule      = true
  alb_listener_rule_action_type = "fixed-response"
  alb_listener_rule_action_fixed_response = [
    {
      content_type = "text/plain"
      message_body = null
      status_code  = "200"
    }
  ]
  alb_listener_rule_condition_http_header = [
    {
      http_header_name = "X-Forwarded-For"
      values           = ["0.0.0.0/0"]
    }
  ]

  tags = tomap({
    "Environment" = "dev",
    "Createdby"   = "Vitaliy Natarov"
  })

}


module "alb_name_prefix" {
  source      = "../../modules/alb"
  name        = "App-Load-Balancer"
  environment = "staging"

  # Create a new ALB
  enable_alb                     = false
  alb_load_balancer_type         = "application"
  alb_name_prefix                = "alb-"
  alb_security_groups            = ["sg-0cfb43249902af8f2"]
  alb_subnets                    = ["subnet-087ab3540e1a1ace4", "subnet-03212d250885f6986", "subnet-02b0ff71a1d00deb2"]
  alb_internal                   = false
  alb_enable_deletion_protection = false


  tags = tomap({
    "Environment" = "dev",
    "Createdby"   = "Vitaliy Natarov"
  })

}
