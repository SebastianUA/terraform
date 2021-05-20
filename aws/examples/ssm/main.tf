#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
  required_version = "~> 0.15"
}

provider "aws" {
  region                  = "us-east-1"
  profile                 = "default"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "ssm" {
  source = "../../modules/ssm"

  name        = "name"
  environment = "stage"

  #enable_ssm_association                          = true
  #ssm_association_name                            = "test-association"

  enable_ssm_maintenance_window   = true
  ssm_maintenance_window_name     = ""
  ssm_maintenance_window_schedule = "cron(0 16 ? * TUE *)"
  ssm_maintenance_window_duration = 3
  ssm_maintenance_window_cutoff   = 1

  enable_ssm_maintenance_window_task           = true
  ssm_maintenance_window_task_name             = ""
  ssm_maintenance_window_task_service_role_arn = "arn:aws:iam::167127734783:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"
  ssm_maintenance_window_task_task_arn         = "AWS-RestartEC2Instance"
  ssm_maintenance_window_task_targets = [
    {
      key    = "InstanceIds"
      values = ["aws_instance_id"]
    }
  ]

  tags = map("Env", "stage", "Orchestration", "Terraform")
}
