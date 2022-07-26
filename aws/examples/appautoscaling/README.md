# Work with APPAUTOSCALING via terraform

A terraform module for making APPAUTOSCALING.


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
}

module "dynamodb" {
  source      = "../../modules/dynamodb"
  name        = "TEST"
  environment = "stage"

  enable_dynamodb_table           = true
  dynamodb_table_name             = "tf-locker"
  dynamodb_table_hash_key         = "LockID"
  dynamodb_table_billing_mode     = "PROVISIONED"
  dynamodb_table_read_capacity    = 1
  dynamodb_table_write_capacity   = 1
  dynamodb_table_stream_enabled   = true
  dynamodb_table_stream_view_type = "NEW_AND_OLD_IMAGES"
  dynamodb_table_range_key        = "Locker"

  dynamodb_table_ttl = [{
    attribute_name = "TimeToExist"
    enabled        = false
  }]

  dynamodb_table_attribute = [
    {
      name = "LockID"
      type = "S"
    },
    {
      name = "Locker"
      type = "S"
    }
  ]

}

module "appautoscaling" {
  source      = "../../modules/appautoscaling"
  name        = "TEST"
  environment = "stage"

  # Appautoscalling target
  enable_appautoscaling_target             = true
  appautoscaling_target_max_capacity       = 3
  appautoscaling_target_min_capacity       = 1
  appautoscaling_target_resource_id        = "table/${module.dynamodb.dynamodb_table_id}"
  appautoscaling_target_scalable_dimension = "dynamodb:table:ReadCapacityUnits"
  appautoscaling_target_service_namespace  = "dynamodb"
  appautoscaling_target_role_arn           = null

  # Appautoscalling policy
  enable_appautoscaling_policy      = true
  appautoscaling_policy_name        = "DynamoDBReadCapacityUtilization:${module.appautoscaling.appautoscaling_target_id}"
  appautoscaling_policy_policy_type = "TargetTrackingScaling"
  appautoscaling_policy_target_tracking_scaling_policy_configuration = [{
    predefined_metric_type = "DynamoDBReadCapacityUtilization"

    target_value       = 75
    disable_scale_in   = false
    scale_in_cooldown  = 300
    scale_out_cooldown = 300
  }]

  # Appautoscalling scheduled action
  enable_appautoscaling_scheduled_action   = true
  appautoscaling_scheduled_action_name     = ""
  appautoscaling_scheduled_action_schedule = "at(2020-04-18T15:04:05)"
  appautoscaling_scheduled_action_scalable_target_action = [{
    min_capacity = 1
    max_capacity = 3
  }]
}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_appautoscaling_target` - Enable appautoscaling target usage (`default = False`)
- `appautoscaling_target_max_capacity` - (Required) The max capacity of the scalable target. Ex: 10. (`default = null`)
- `appautoscaling_target_min_capacity` - (Required) The min capacity of the scalable target. Ex: 1. (`default = null`)
- `appautoscaling_target_resource_id` - (Required) The resource type and unique identifier string for the resource associated with the scaling policy. Documentation can be found in the ResourceId parameter at: AWS Application Auto Scaling API Reference. Ex:  (`default = null`)
- `appautoscaling_target_scalable_dimension` - (Required) The scalable dimension of the scalable target. Documentation can be found in the ScalableDimension parameter at: AWS Application Auto Scaling API Reference (`default = null`)
- `appautoscaling_target_service_namespace` - (Required) The AWS service namespace of the scalable target. Documentation can be found in the ServiceNamespace parameter at: AWS Application Auto Scaling API Reference (`default = null`)
- `appautoscaling_target_role_arn` - (Optional) The ARN of the IAM role that allows Application AutoScaling to modify your scalable target on your behalf. (`default = null`)
- `enable_appautoscaling_policy` - Enable appautoscaling policy usage (`default = False`)
- `appautoscaling_policy_name` - The name of the policy. (`default = ""`)
- `appautoscaling_policy_policy_type` - (Optional) For DynamoDB, only TargetTrackingScaling is supported. For Amazon ECS, Spot Fleet, and Amazon RDS, both StepScaling and TargetTrackingScaling are supported. For any other service, only StepScaling is supported. Defaults to StepScaling (`default = StepScaling`)
- `appautoscaling_policy_resource_id` - The resource type and unique identifier string for the resource associated with the scaling policy. Documentation can be found in the ResourceId parameter at: AWS Application Auto Scaling API Reference (`default = ""`)
- `appautoscaling_policy_scalable_dimension` - (Required) The scalable dimension of the scalable target. Documentation can be found in the ScalableDimension parameter at: AWS Application Auto Scaling API Reference (`default = ""`)
- `appautoscaling_policy_service_namespace` - (Required) The AWS service namespace of the scalable target. Documentation can be found in the ServiceNamespace parameter at: AWS Application Auto Scaling API Reference (`default = ""`)
- `appautoscaling_policy_step_scaling_policy_configuration` - (Optional) Step scaling policy configuration, requires policy_type = 'StepScaling' (default). (`default = []`)
- `appautoscaling_policy_target_tracking_scaling_policy_configuration` -  (Optional) A target tracking policy, requires policy_type = 'TargetTrackingScaling'. (`default = []`)
- `enable_appautoscaling_scheduled_action` - description (`default = False`)
- `appautoscaling_scheduled_action_name` - The name of the scheduled action. (`default = ""`)
- `appautoscaling_scheduled_action_resource_id` - The identifier of the resource associated with the scheduled action. Documentation can be found in the parameter at: AWS Application Auto Scaling API Reference (`default = ""`)
- `appautoscaling_scheduled_action_scalable_dimension` - The scalable dimension. Documentation can be found in the parameter at: AWS Application Auto Scaling API Reference Example: ecs:service:DesiredCount (`default = ""`)
- `appautoscaling_scheduled_action_service_namespace` - The namespace of the AWS service. Documentation can be found in the parameter at: AWS Application Auto Scaling API Reference Example: ecs (`default = ""`)
- `appautoscaling_scheduled_action_schedule` - (Optional) The schedule for this action. The following formats are supported: At expressions - at(yyyy-mm-ddThh:mm:ss), Rate expressions - rate(valueunit), Cron expressions - cron(fields). In UTC. Documentation can be found in the parameter at: AWS Application Auto Scaling API Reference (`default = null`)
- `appautoscaling_scheduled_action_start_time` - (Optional) The date and time for the scheduled action to start. Specify the following format: 2006-01-02T15:04:05Z (`default = null`)
- `appautoscaling_scheduled_action_end_time` - (Optional) The date and time for the scheduled action to end. Specify the following format: 2006-01-02T15:04:05Z (`default = null`)
- `appautoscaling_scheduled_action_scalable_target_action` - (Optional) The new minimum and maximum capacity. You can set both values or just one. (`default = []`)

## Module Output Variables
----------------------
- `appautoscaling_target_id` - The ID for appautoscaling target
- `appautoscaling_policy_id` - The ID for appautoscaling policy
- `appautoscaling_policy_arn` - The ARN assigned by AWS to the scaling policy.
- `appautoscaling_policy_name` - The scaling policy's name.
- `appautoscaling_policy_policy_type` - The scaling policy's type.
- `appautoscaling_scheduled_action_id` - The ID for appautoscaling scheduled action
- `appautoscaling_scheduled_action_arn` - The Amazon Resource Name (ARN) of the scheduled action.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
