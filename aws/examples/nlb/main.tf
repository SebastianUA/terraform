#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.15"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
  profile                 = "default"
}

module "nlb" {
  source = "../../modules/nlb"

  # NLB
  enable_nlb                     = true
  nlb_name                       = "Network-Load-Balancer"
  nlb_subnets                    = ["subnet-8851dea6", "subnet-c3a5f589", "subnet-1d7df041"]
  nlb_enable_deletion_protection = false
  nlb_internal                   = false

  # NLB target group
  enable_nlb_target_group   = true
  nlb_target_group_name     = "Network-Load-Balancer"
  nlb_target_group_vpc_id   = "vpc-56af732c"
  nlb_target_group_protocol = "TCP"
  nlb_target_group_port     = 80
  nlb_target_group_health_check = [
    {
      enabled  = true
      interval = 10
      port     = 80
      protocol = "HTTP"
      timeout  = 60
    },
  ]

  # NLB target group attachment
  enable_nlb_target_group_attachment     = true
  nlb_target_group_attachment_target_ids = []

  # NLB listener
  enable_nlb_listener   = true
  nlb_listener_protocol = "TCP"
  nlb_listener_rule_action_redirect = [
    {
      protocol = "TCP"
      port     = 80
    }
  ]

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}
