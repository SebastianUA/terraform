# Work with CODEDEPLOY via terraform

A terraform module for making CODEDEPLOY.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
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

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `region` - The region where to deploy this code (e.g. us-east-1). (`default = us-east-1`)
- `environment` - Environment for service (`default = STAGE`)
- `orchestration` - Type of orchestration (`default = Terraform`)
- `createdby` - Created by (`default = Vitaliy Natarov`)
- `enable_codedeploy_app` - Enable codedeploy app usage (`default = False`)
- `codedeploy_app_name` - The name of the application. (`default = ""`)
- `codedeploy_app_compute_platform` - (Optional) The compute platform can either be ECS, Lambda, or Server. Default is Server. (`default = Server`)
- `enable_codedeploy_deployment_config` - Enable codedeploy deployment config canary usage (`default = False`)
- `codedeploy_deployment_config_stack` - Set properties for codedeploy deployment config (`default = []`)
- `enable_codedeploy_deployment_group` - Enable codedeploy deployment group usage (`default = False`)
- `codedeploy_deployment_group_stack` - Set properties for codedeploy deployment group (`default = []`)

## Module Output Variables
----------------------
- `codedeploy_app_id` - Amazon's assigned ID for the application.
- `codedeploy_app_name` - The application's name.
- `codedeploy_deployment_config_id` - The deployment group's config name.
- `codedeploy_deployment_config_deployment_config_id` - The AWS Assigned deployment config id
- `codedeploy_deployment_group_id` - Application name and deployment group name.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
