#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region = "us-east-1"
}

module "elb" {
  source      = "../../modules/elb"
  name        = "TEST"
  environment = "stage"

  enable_elb             = true
  elb_name               = "my-elb-here"
  elb_security_groups    = []
  elb_subnets            = []
  elb_availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]

  elb_access_logs = []
  elb_listener = [
    {
      instance_port     = "80"
      instance_protocol = "HTTP"
      lb_port           = "80"
      lb_protocol       = "HTTP"
    },
    #    {
    #        instance_port      = 443
    #        instance_protocol  = "https"
    #        lb_port            = 443
    #        lb_protocol        = "https"
    #        ssl_certificate_id = "${var.elb_certificate}"
    #    },
  ]
  elb_health_check = [
    {
      target              = "HTTP:80/"
      interval            = 30
      healthy_threshold   = 2
      unhealthy_threshold = 2
      timeout             = 5
    }
  ]

  # Enable AWS ELB app cookie stickiness policy
  enable_app_cookie_stickiness_policy = true
  app_cookie_stickiness_policy_stack = [
    {
      name        = "app-cookie-stickiness-policy"
      lb_port     = 80
      cookie_name = "MyAppCookie"
    }
  ]

  # Enable lb cookie stickiness policy
  enable_lb_cookie_stickiness_policy = true
  lb_cookie_stickiness_policy_stack = [
    {
      name                     = "lb-cookie-stickiness-policy"
      lb_port                  = 80
      cookie_expiration_period = 600
    }
  ]

  # Enable lb ssl negotiation policy
  enable_lb_ssl_negotiation_policy  = true
  lb_ssl_negotiation_policy_name    = "lb-ssl-negotiation-policy"
  lb_ssl_negotiation_policy_lb_port = 443
  lb_ssl_negotiation_policy_attribute = [
    {
      name  = "Protocol-TLSv1"
      value = false
    },
    {
      name  = "Protocol-TLSv1.1"
      value = false
    },
    {
      name  = "Protocol-TLSv1.2"
      value = true
    },
    {
      name  = "Server-Defined-Cipher-Order"
      value = true
    },
    {
      name  = "ECDHE-RSA-AES128-GCM-SHA256"
      value = true
    },
    {
      name  = "AES128-GCM-SHA256"
      value = true
    },
    {
      name  = "EDH-RSA-DES-CBC3-SHA"
      value = false
    }
  ]

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}
