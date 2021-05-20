#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.15"
}

provider "aws" {
  region  = "us-east-1"
  profile = "default"
}

module "iam_service" {
  source      = "../../modules/iam_service"
  name        = "TEST-iam-service"
  environment = "stage"

  enable_iam_service_linked_role           = true
  iam_service_linked_role_aws_service_name = "elasticbeanstalk.amazonaws.com"
  iam_service_linked_role_custom_suffix    = "custom-suffix-"
  iam_service_linked_role_description      = "Just test iam_service"
}
