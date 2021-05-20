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
  description = "A list of tag blocks"
  type        = map(string)
  default     = {}
}

#------------------------------------------------------------------
# AWS ECS cluster
#------------------------------------------------------------------
variable "enable_ecs_cluster" {
  description = "Enable ecs cluster"
  default     = false
}

variable "ecs_cluster_name" {
  description = "The name of the cluster (up to 255 letters, numbers, hyphens, and underscores)"
  default     = ""
}

variable "ecs_cluster_capacity_providers" {
  description = "(Optional) List of short names of one or more capacity providers to associate with the cluster. Valid values also include FARGATE and FARGATE_SPOT."
  default     = null
}

variable "ecs_cluster_default_capacity_provider_strategy" {
  description = "(Optional) The capacity provider strategy to use by default for the cluster. Can be one or more."
  default     = []
}

variable "ecs_cluster_setting" {
  description = "(Optional) Configuration block(s) with cluster settings. For example, this can be used to enable CloudWatch Container Insights for a cluster. The name - (Required) Name of the setting to manage. Valid values: containerInsights. The value - (Required) The value to assign to the setting. Value values are enabled and disabled."
  default     = []
}

#------------------------------------------------------------------
# AWS ECS task definition
#------------------------------------------------------------------
variable "enable_ecs_task_definition" {
  description = "Enable ecs task definition"
  default     = false
}

variable "ecs_task_definition_family" {
  description = "(Required) A unique name for your task definition."
  default     = ""
}

variable "ecs_task_definition_container_definitions" {
  description = "(Required) A list of valid container definitions provided as a single valid JSON document. Please note that you should only provide values that are part of the container definition document. For a detailed description of what parameters are available, see the Task Definition Parameters section from the official Developer Guide."
  default     = ""
}

variable "ecs_task_definition_task_role_arn" {
  description = "(Optional) The ARN of IAM role that allows your Amazon ECS container task to make calls to other AWS services."
  default     = null
}

variable "ecs_task_definition_execution_role_arn" {
  description = "(Optional) The Amazon Resource Name (ARN) of the task execution role that the Amazon ECS container agent and the Docker daemon can assume."
  default     = null
}

variable "ecs_task_definition_network_mode" {
  description = "(Optional) The Docker networking mode to use for the containers in the task. The valid values are none, bridge, awsvpc, and host."
  default     = null
}

variable "ecs_task_definition_ipc_mode" {
  description = "(Optional) The IPC resource namespace to be used for the containers in the task The valid values are host, task, and none."
  default     = null
}

variable "ecs_task_definition_pid_mode" {
  description = "(Optional) The process namespace to use for the containers in the task. The valid values are host and task."
  default     = null
}

variable "ecs_task_definition_cpu" {
  description = "(Optional) The number of cpu units used by the task. If the requires_compatibilities is FARGATE this field is required."
  default     = null
}

variable "ecs_task_definition_memory" {
  description = "(Optional) The amount (in MiB) of memory used by the task. If the requires_compatibilities is FARGATE this field is required."
  default     = null
}

variable "ecs_task_definition_requires_compatibilities" {
  description = "(Optional) A set of launch types required by the task. The valid values are EC2 and FARGATE."
  default     = null
}

variable "ecs_task_definition_volume" {
  description = "(Optional) Configuration block for volumes that containers in your task may use."
  default     = []
}

variable "ecs_task_definition_placement_constraints" {
  description = "(Optional) A set of placement constraints rules that are taken into consideration during task placement. Maximum number of placement_constraints is 10."
  default     = []
}

variable "ecs_task_definition_proxy_configuration" {
  description = "(Optional) The proxy configuration details for the App Mesh proxy."
  default     = []
}

variable "ecs_task_definition_inference_accelerator" {
  description = "(Optional) Configuration block(s) with Inference Accelerators settings."
  default     = []
}

#------------------------------------------------------------------
# AWS ECS service
#------------------------------------------------------------------
variable "enable_ecs_service" {
  description = "Enable ecs service"
  default     = false
}

variable "ecs_service_name" {
  description = "The name of the service (up to 255 letters, numbers, hyphens, and underscores)"
  default     = ""
}

variable "ecs_service_cluster" {
  description = "ARN of an ECS cluster"
  default     = ""
}

variable "ecs_service_task_definition" {
  description = "(Required) The family and revision (family:revision) or full ARN of the task definition that you want to run in your service."
  default     = ""
}

variable "ecs_service_desired_count" {
  description = "(Optional) The number of instances of the task definition to place and keep running. Defaults to 0. Do not specify if using the DAEMON scheduling strategy."
  default     = 3
}

variable "ecs_service_iam_role" {
  description = "(Optional) ARN of the IAM role that allows Amazon ECS to make calls to your load balancer on your behalf. This parameter is required if you are using a load balancer with your service, but only if your task definition does not use the awsvpc network mode. If using awsvpc network mode, do not specify this role. If your account has already created the Amazon ECS service-linked role, that role is used by default for your service unless you specify a role here."
  default     = null
}

variable "ecs_service_launch_type" {
  description = "(Optional) The launch type on which to run your service. The valid values are EC2 and FARGATE. Defaults to EC2."
  default     = null
}

variable "ecs_service_platform_version" {
  description = "(Optional) The platform version on which to run your service. Only applicable for launch_type set to FARGATE. Defaults to LATEST."
  default     = null
}

variable "ecs_service_scheduling_strategy" {
  description = "(Optional) The scheduling strategy to use for the service. The valid values are REPLICA and DAEMON. Defaults to REPLICA."
  default     = null
}

variable "ecs_service_propagate_tags" {
  description = "(Optional) Specifies whether to propagate the tags from the task definition or the service to the tasks. The valid values are SERVICE and TASK_DEFINITION."
  default     = null
}

variable "ecs_service_deployment_maximum_percent" {
  description = "(Optional) The upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment. Not valid when using the DAEMON scheduling strategy."
  default     = null
}

variable "ecs_service_deployment_minimum_healthy_percent" {
  description = "(Optional) The lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment."
  default     = null
}

variable "ecs_service_enable_ecs_managed_tags" {
  description = "(Optional) Specifies whether to enable Amazon ECS managed tags for the tasks within the service."
  default     = null
}

variable "ecs_service_health_check_grace_period_seconds" {
  description = "(Optional) Seconds to ignore failing load balancer health checks on newly instantiated tasks to prevent premature shutdown, up to 2147483647. Only valid for services configured to use load balancers."
  default     = null
}

variable "ecs_service_force_new_deployment" {
  description = "(Optional) Enable to force a new task deployment of the service. This can be used to update tasks to use a newer Docker image with same image/tag combination (e.g. myimage:latest), roll Fargate tasks onto a newer platform version, or immediately deploy ordered_placement_strategy and placement_constraints updates."
  default     = null
}

variable "ecs_service_wait_for_steady_state" {
  description = "(Optional) If true, Terraform will wait for the service to reach a steady state (like aws ecs wait services-stable) before continuing. Default false."
  default     = null
}

variable "ecs_service_capacity_provider_strategy" {
  description = "(Optional) The capacity provider strategy to use for the service. Can be one or more."
  default     = []
}

variable "ecs_service_network_configuration" {
  description = "(Optional) The network configuration for the service. This parameter is required for task definitions that use the awsvpc network mode to receive their own Elastic Network Interface, and it is not supported for other network modes."
  default     = []
}

variable "ecs_service_service_registries" {
  description = "(Optional) The service discovery registries for the service. The maximum number of service_registries blocks is 1."
  default     = []
}

variable "ecs_service_deployment_controller" {
  description = "(Optional) Configuration block containing deployment controller configuration."
  default     = []
}

variable "ecs_service_load_balancer" {
  description = "(Optional) A load balancer block."
  default     = []
}

variable "ecs_service_ordered_placement_strategy" {
  description = "(Optional) Service level strategy rules that are taken into consideration during task placement. List from top to bottom in order of precedence. The maximum number of ordered_placement_strategy blocks is 5. Defined below."
  default     = []
}

variable "ecs_service_placement_constraints" {
  description = "(Optional) rules that are taken into consideration during task placement. Maximum number of placement_constraints is 10. Defined below."
  default     = []
}

#---------------------------------------------------
# AWS ECS capacity provider
#---------------------------------------------------
variable "enable_ecs_capacity_provider" {
  description = "Enable ecs capacity provider usage"
  default     = false
}

variable "ecs_capacity_provider_name" {
  description = "The name of the capacity provider."
  default     = ""
}

variable "ecs_capacity_provider_auto_scaling_group_provider" {
  description = "(Required) Configuration block for the provider for the ECS auto scaling group."
  default     = []
}
