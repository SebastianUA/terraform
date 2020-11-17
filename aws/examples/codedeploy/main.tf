#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.13.5"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
  profile                 = "default"
}

module "codedeploy" {
  source      = "../../modules/codedeploy"
  name        = "TEST"
  region      = "us-east-1"
  environment = "stage"

  enable_codedeploy_app           = true
  codedeploy_app_name             = ""
  codedeploy_app_compute_platform = "Server"

  # Canary
  enable_codedeploy_deployment_config_canary = true

  # Liner
  enable_codedeploy_deployment_config_linear = false

  enable_deployment_group_deployment           = true
  codedeploy_deployment_group_service_role_arn = "arn:aws:iam::167127734783:role/admin-role"

}
