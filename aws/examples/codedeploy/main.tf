#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"
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

  # CodeDeploy deployment configs
  enable_codedeploy_deployment_config = true
  codedeploy_deployment_config_stack = [
    {
      compute_platform       = "Server"
      deployment_config_name = "deployment_config-1"

      minimum_healthy_hosts = {
        type  = "HOST_COUNT"
        value = 2
      }

      traffic_routing_config = {
        type = "TimeBasedLinear"

        time_based_linear = {
          interval   = 10
          percentage = 10
        }
      }
    },
    {
      compute_platform       = "Server"
      deployment_config_name = "deployment_config-2"

      minimum_healthy_hosts = {
        type  = "HOST_COUNT"
        value = 2
      }

      traffic_routing_config = {
        type = "TimeBasedCanary"

        time_based_canary = {
          interval   = 10
          percentage = 10
        }
      }
    },
    {
      compute_platform       = "Server"
      deployment_config_name = "deployment_config-3"

      minimum_healthy_hosts = {
        type  = "HOST_COUNT"
        value = 2
      }

      traffic_routing_config = {
        type = "AllAtOnce"
      }
    }
  ]

  enable_codedeploy_deployment_group = true
  codedeploy_deployment_group_stack = [
    {
      deployment_group_name = "deployment-group-1"
      service_role_arn      = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/admin-role"

      auto_rollback_configuration = {
        enabled = true
        events  = ["DEPLOYMENT_STOP_ON_ALARM"]
      }

      ec2_tag_filter = {
        key   = "filterkey"
        type  = "KEY_AND_VALUE"
        value = "filtervalue"
      }

      trigger_configuration = {
        trigger_events     = ["DeploymentFailure"]
        trigger_name       = "foo-trigger"
        trigger_target_arn = "foo-topic-arn"
      }

      alarm_configuration = {
        alarms  = ["my-alarm-name"]
        enabled = true
      }

    }
  ]
}
