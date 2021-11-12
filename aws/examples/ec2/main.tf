#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region  = "us-west-2"
  profile = "default"
}

module "ec2" {
  source = "../../modules/ec2"

  region      = "us-west-2"
  environment = "dev"


  enable_instance                      = true
  instance_name                        = "ec2-test-machine-dev"
  instance_type                        = "t2.micro"
  instance_associate_public_ip_address = true
  instance_disk_size                   = 8
  instance_tenancy                     = "default"
  instance_iam_instance_profile        = ""
  instance_subnet_id                   = ""
  instance_vpc_security_group_ids      = []

  instance_monitoring = true

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}
