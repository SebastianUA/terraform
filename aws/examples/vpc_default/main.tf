#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.15"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "vpc_default" {
  source = "../../modules/vpc_default"

  # Default VPC
  enable_default_vpc               = true
  default_vpc_enable_dns_support   = true
  default_vpc_enable_dns_hostnames = true
  default_vpc_enable_classiclink   = false

  # Default VPC subnet
  default_subnet_azs = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f"]

  # Default VPC SG


  tags = map("Orchestration", "Terraform")
}
