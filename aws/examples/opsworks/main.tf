#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
  required_version = "~> 0.15"

  required_providers {
    aws = "~> 2.49"
  }
}

provider "aws" {
  region                  = "us-east-1"
  profile                 = "default"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "iam_role" {
  source      = "../../modules/iam_role"
  name        = "TEST-role"
  environment = "stage"

  # Using IAM role
  enable_iam_role      = true
  iam_role_name        = "opsworks-role-test"
  iam_role_description = "It's just a simple IAM role to test TF module"
  iam_role_assume_role_policy   = file("additional_files/assume_role_policy.json")

  iam_role_force_detach_policies = true
  iam_role_path                  = "/"
  iam_role_max_session_duration  = 3600

  # Using IAM role policy
  enable_iam_role_policy = true
  iam_role_policy_name   = "opsworks-policy-test"
  iam_role_policy        = file("additional_files/policy.json")

  # Using IAM instance profile
  enable_iam_instance_profile = true
  iam_instance_profile_name   = "opsworks-instance-profile-test"

  tags = tomap({"Env"="stage", "Orchestration"="Terraform"})
}

module "opsworks" {
  source = "../../modules/opsworks"

  region      = "us-east-1"
  environment = "stage"

  enable_opsworks_stack                       = true
  opsworks_stack_name                         = ""
  opsworks_stack_service_role_arn             = module.iam_role.iam_role_arn
  opsworks_stack_default_instance_profile_arn = module.iam_role.instance_profile_arn
  opsworks_stack_vpc_id                       = "vpc-56af732c"
  opsworks_stack_default_subnet_id            = "subnet-8851dea6"

  enable_opsworks_static_web_layer = true
  opsworks_static_web_layer_name   = "opsworks-static-web-layer"

  enable_opsworks_custom_layer = true
  opsworks_custom_layer_name   = "opsworks-custom-layer"

  enable_opsworks_instance              = true
  opsworks_instance_instance_type       = "t2.large"
  opsworks_instance_os                  = "Amazon Linux 2015.09"
  opsworks_instance_state               = "stopped"
  opsworks_instance_virtualization_type = "hvm"
  opsworks_instance_tenancy             = "default"
  opsworks_instance_root_device_type    = "ebs"


  enable_opsworks_application     = true
  opsworks_application_name       = "opsworks-app-test"
  opsworks_application_short_name = "app-test"

  tags = tomap({"Env"="stage", "Orchestration"="Terraform"})

}
