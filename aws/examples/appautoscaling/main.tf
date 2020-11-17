#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.13"
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
  appautoscaling_policy_target_tracking_scaling_policy_configuration_predefined_metric_specification = [{
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
