#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "sg_default" {
  source      = "../../modules/sg"
  name        = "test"
  environment = "dev"

  enable_default_security_group = true
  default_security_group_name   = "default"
  default_security_group_vpc_id = "vpc-0ea8873ab2bf7900d"


  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}

module "sg" {
  source      = "../../modules/sg"
  name        = "test"
  environment = "dev"

  enable_security_group = true
  security_group_name   = "my-test-sg-here"
  security_group_vpc_id = "vpc-0ea8873ab2bf7900d"


  security_group_ingress = [
    {
      from_port = 443
      to_port   = 443
      protocol  = "tcp"

      cidr_blocks      = null
      ipv6_cidr_blocks = null
      prefix_list_ids  = null
      description      = "TLS from VPC"
      security_groups  = null
      self             = null
    },
    {
      from_port = 80
      to_port   = 80
      protocol  = "http"

      cidr_blocks      = null
      ipv6_cidr_blocks = null
      prefix_list_ids  = null
      description      = "HTTP from VPC"
      security_groups  = null
      self             = null
    }
  ]


  security_group_egress = [
    {
      from_port = 443
      to_port   = 443
      protocol  = "tcp"

      cidr_blocks      = null
      ipv6_cidr_blocks = null
      prefix_list_ids  = null
      description      = "TLS to VPC"
      security_groups  = null
      self             = null
    },
    {
      from_port = 80
      to_port   = 80
      protocol  = "http"

      cidr_blocks      = null
      ipv6_cidr_blocks = null
      prefix_list_ids  = null
      description      = "HTTP from VPC"
      security_groups  = null
      self             = null
    }
  ]

  # Using sg rule (ingress)
  enable_sg_rule_ingress_ports = true

  ingress_ports_stack = [
    {
      from_port   = 444
      to_port     = 444
      protocol    = "tcp"
      description = "444"
    },
    {
      from_port   = 445
      to_port     = 445
      protocol    = "tcp"
      description = "445"
    }
  ]

  # Using sg rule (egress)
  enable_sg_rule_egress_ports = true

  egress_ports_stack = [
    {
      from_port   = 444
      to_port     = 444
      protocol    = "tcp"
      description = "444"
    },
    {
      from_port   = 445
      to_port     = 445
      protocol    = "tcp"
      description = "445"
    }
  ]

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}


module "sg_allow_all" {
  source      = "../../modules/sg"
  name        = "test"
  environment = "dev"

  enable_security_group = true
  security_group_name   = "sg-allow-all"
  security_group_vpc_id = "vpc-0ea8873ab2bf7900d"

  # Using ingress
  enable_sg_rule_ingress_ports_all = true
  enable_sg_rule_egress_ports_all  = true

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}
