#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST"
}

variable "environment" {
  description = "Environment for service"
  default     = "STAGE"
}

variable "tags" {
  description = "A list of tag blocks. Each element should have keys named key, value, etc."
  type        = map(string)
  default     = {}
}

#---------------------------------------------------
# AWS appautoscaling target
#---------------------------------------------------
variable "enable_appautoscaling_target" {
  description = "Enable appautoscaling target usage"
  default     = false
}

variable "appautoscaling_target_max_capacity" {
  description = "(Required) The max capacity of the scalable target. Ex: 10."
  default     = null
}

variable "appautoscaling_target_min_capacity" {
  description = "(Required) The min capacity of the scalable target. Ex: 1."
  default     = null
}

variable "appautoscaling_target_resource_id" {
  description = "(Required) The resource type and unique identifier string for the resource associated with the scaling policy. Documentation can be found in the ResourceId parameter at: AWS Application Auto Scaling API Reference. Ex: "
  default     = null
}

variable "appautoscaling_target_scalable_dimension" {
  description = "(Required) The scalable dimension of the scalable target. Documentation can be found in the ScalableDimension parameter at: AWS Application Auto Scaling API Reference"
  default     = null
}

variable "appautoscaling_target_service_namespace" {
  description = "(Required) The AWS service namespace of the scalable target. Documentation can be found in the ServiceNamespace parameter at: AWS Application Auto Scaling API Reference"
  default     = null
}

variable "appautoscaling_target_role_arn" {
  description = "(Optional) The ARN of the IAM role that allows Application AutoScaling to modify your scalable target on your behalf."
  default     = null
}

#---------------------------------------------------
# AWS appautoscaling policy
#---------------------------------------------------
variable "enable_appautoscaling_policy" {
  description = "Enable appautoscaling policy usage"
  default     = false
}

variable "appautoscaling_policy_name" {
  description = "The name of the policy."
  default     = ""
}

variable "appautoscaling_policy_policy_type" {
  description = "(Optional) For DynamoDB, only TargetTrackingScaling is supported. For Amazon ECS, Spot Fleet, and Amazon RDS, both StepScaling and TargetTrackingScaling are supported. For any other service, only StepScaling is supported. Defaults to StepScaling"
  default     = "StepScaling"
}

variable "appautoscaling_policy_resource_id" {
  description = "The resource type and unique identifier string for the resource associated with the scaling policy. Documentation can be found in the ResourceId parameter at: AWS Application Auto Scaling API Reference"
  default     = ""
}

variable "appautoscaling_policy_scalable_dimension" {
  description = "(Required) The scalable dimension of the scalable target. Documentation can be found in the ScalableDimension parameter at: AWS Application Auto Scaling API Reference"
  default     = ""
}

variable "appautoscaling_policy_service_namespace" {
  description = "(Required) The AWS service namespace of the scalable target. Documentation can be found in the ServiceNamespace parameter at: AWS Application Auto Scaling API Reference"
  default     = ""
}

variable "appautoscaling_policy_step_scaling_policy_configuration" {
  description = "(Optional) Step scaling policy configuration, requires policy_type = 'StepScaling' (default)."
  default     = []
}

variable "appautoscaling_policy_target_tracking_scaling_policy_configuration" {
  description = " (Optional) A target tracking policy, requires policy_type = 'TargetTrackingScaling'."
  default     = []
}

#---------------------------------------------------
# AWS appautoscaling scheduled action
#---------------------------------------------------
variable "enable_appautoscaling_scheduled_action" {
  description = "description"
  default     = false
}

variable "appautoscaling_scheduled_action_name" {
  description = "The name of the scheduled action."
  default     = ""
}

variable "appautoscaling_scheduled_action_resource_id" {
  description = "The identifier of the resource associated with the scheduled action. Documentation can be found in the parameter at: AWS Application Auto Scaling API Reference"
  default     = ""
}

variable "appautoscaling_scheduled_action_scalable_dimension" {
  description = "The scalable dimension. Documentation can be found in the parameter at: AWS Application Auto Scaling API Reference Example: ecs:service:DesiredCount"
  default     = ""
}

variable "appautoscaling_scheduled_action_service_namespace" {
  description = "The namespace of the AWS service. Documentation can be found in the parameter at: AWS Application Auto Scaling API Reference Example: ecs"
  default     = ""
}

variable "appautoscaling_scheduled_action_schedule" {
  description = "(Optional) The schedule for this action. The following formats are supported: At expressions - at(yyyy-mm-ddThh:mm:ss), Rate expressions - rate(valueunit), Cron expressions - cron(fields). In UTC. Documentation can be found in the parameter at: AWS Application Auto Scaling API Reference"
  default     = null
}

variable "appautoscaling_scheduled_action_start_time" {
  description = "(Optional) The date and time for the scheduled action to start. Specify the following format: 2006-01-02T15:04:05Z"
  default     = null
}

variable "appautoscaling_scheduled_action_end_time" {
  description = "(Optional) The date and time for the scheduled action to end. Specify the following format: 2006-01-02T15:04:05Z"
  default     = null
}

variable "appautoscaling_scheduled_action_scalable_target_action" {
  description = "(Optional) The new minimum and maximum capacity. You can set both values or just one."
  default     = []
}
