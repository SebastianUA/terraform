#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST"
}

variable "region" {
  description = "The region where to deploy this code (e.g. us-east-1)."
  default     = "us-east-1"
} 

variable "environment" {
  description = "Environment for service"
  default     = "STAGE"
}

variable "orchestration" {
  description = "Type of orchestration"
  default     = "Terraform"
}

variable "createdby" {
  description = "Created by"
  default     = "Vitaliy Natarov"
}

variable "tags" {
  description = "A list of tag blocks. Each element should have keys named key, value, and propagate_at_launch."
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

variable "setting" {
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

variable "family" {
  description = "(Required) A unique name for your task definition."
  default     = ""
}

variable "container_definitions" {
  description = "(Required) A list of valid container definitions provided as a single valid JSON document. Please note that you should only provide values that are part of the container definition document. For a detailed description of what parameters are available, see the Task Definition Parameters section from the official Developer Guide."
  default     = ""
}

variable "task_role_arn" {
  description = "(Optional) The ARN of IAM role that allows your Amazon ECS container task to make calls to other AWS services."
  default     = ""
}

variable "execution_role_arn" {
  description = "(Optional) The Amazon Resource Name (ARN) of the task execution role that the Amazon ECS container agent and the Docker daemon can assume."
  default     = ""
}

variable "network_mode" {
  description = "(Optional) The Docker networking mode to use for the containers in the task. The valid values are none, bridge, awsvpc, and host."
  default     = "none"
}

variable "ipc_mode" {
  description = "(Optional) The IPC resource namespace to be used for the containers in the task The valid values are host, task, and none."
  default     = "none"
}

variable "pid_mode" {
  description = "(Optional) The process namespace to use for the containers in the task. The valid values are host and task."
  default     = "task"
}

variable "volume" {
  description = "(Optional) A set of volume blocks that containers in your task may use."
  default     = []
}

variable "placement_constraints" {
  description = "(Optional) A set of placement constraints rules that are taken into consideration during task placement. Maximum number of placement_constraints is 10."
  default     = []
}

variable "proxy_configuration_type" {
  description = "(Optional) The proxy type. The default value is APPMESH. The only supported value is APPMESH."
  default     = null
}

variable "proxy_configuration_container_name" {
  description = "(Required) The name of the container that will serve as the App Mesh proxy."
  default     = ""
}

variable "proxy_configuration_properties_appports" {
  description = "For ex: 8080"
  default     = null
}

variable "proxy_configuration_properties_egressignoredips" {
  description = "For ex: '169.254.170.2,169.254.169.254'"
  default     = null
}

variable "proxy_configuration_properties_ignoreduid" {
  description = "For ex: 1339"
  default     = null
}

variable "proxy_configuration_properties_proxyegressport" {
  description = "For ex: 15001"
  default     = null
}

variable "proxy_configuration_properties_proxyingressport" {
  description = "For ex: 15000"
  default     = null
}

variable "enable_appmesh_proxy" {
  description = "Enable ecs task definition"
  default     = false
}

#------------------------------------------------------------------
# AWS ECS service
#------------------------------------------------------------------
variable "enable_ecs_service" {
  description = "Enable ecs service"
  default     = false
}

variable "enable_ecs_service_daemon" {
  description = "Enable ecs service as deamon"
  default     = false
}

variable "ecs_service_name" {
  description = "The name of the service (up to 255 letters, numbers, hyphens, and underscores)"
  default     = ""
}

variable "ecs_cluster_id" {
  description = "ARN of an ECS cluster"
  default     = ""
}

variable "task_definition" {
  description = "(Required) The family and revision (family:revision) or full ARN of the task definition that you want to run in your service."
  default = ""
}

variable "desired_count" {
  description = "(Optional) The number of instances of the task definition to place and keep running. Defaults to 0. Do not specify if using the DAEMON scheduling strategy."
  default     = 3
}

variable "iam_role" {
  description = "(Optional) ARN of the IAM role that allows Amazon ECS to make calls to your load balancer on your behalf. This parameter is required if you are using a load balancer with your service, but only if your task definition does not use the awsvpc network mode. If using awsvpc network mode, do not specify this role. If your account has already created the Amazon ECS service-linked role, that role is used by default for your service unless you specify a role here."
  default     = ""
}

variable "launch_type" {
  description = "(Optional) The launch type on which to run your service. The valid values are EC2 and FARGATE. Defaults to EC2."
  default     = "EC2"
}

variable "platform_version" {
  description = "(Optional) The platform version on which to run your service. Only applicable for launch_type set to FARGATE. Defaults to LATEST."
  default     = "LATEST"
}

variable "scheduling_strategy" {
  description = "(Optional) The scheduling strategy to use for the service. The valid values are REPLICA and DAEMON. Defaults to REPLICA."
  default     = "REPLICA"
}

variable "propagate_tags" {
  description = "(Optional) Specifies whether to propagate the tags from the task definition or the service to the tasks. The valid values are SERVICE and TASK_DEFINITION."
  default     = "SERVICE"
}

variable "deployment_maximum_percent" {
  description = "(Optional) The upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment. Not valid when using the DAEMON scheduling strategy."
  default     = ""
}

variable "deployment_minimum_healthy_percent" {
  description = "(Optional) The lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment."
  default     = 2
}

variable "enable_ecs_managed_tags" {
  description = "(Optional) Specifies whether to enable Amazon ECS managed tags for the tasks within the service."
  default     = true
}

variable "health_check_grace_period_seconds" {
  description = "(Optional) Seconds to ignore failing load balancer health checks on newly instantiated tasks to prevent premature shutdown, up to 2147483647. Only valid for services configured to use load balancers."
  default     = 2147483647
}

variable "network_configuration" {
  description = "(Optional) The network configuration for the service. This parameter is required for task definitions that use the awsvpc network mode to receive their own Elastic Network Interface, and it is not supported for other network modes."
  default     = []
}

variable "service_registries" {
  description = "(Optional) The service discovery registries for the service. The maximum number of service_registries blocks is 1."
  default     = []
}

variable "service_registries_container_name" {
  description = "(Optional) The container name value, already specified in the task definition, to be used for your service discovery service."
  default     = ""
}

variable "deployment_controller" {
  description = "(Optional) Configuration block containing deployment controller configuration."
  default     = []
}

variable "load_balancer" {
  description = "(Optional) A load balancer block."
  default     = []
}

variable "load_balancer_container_name" {
  description = "(Required) The name of the container to associate with the load balancer (as it appears in a container definition)."
  default     = ""
}

variable "ordered_placement_strategy" {
  description = "(Optional) Service level strategy rules that are taken into consideration during task placement. List from top to bottom in order of precedence. The maximum number of ordered_placement_strategy blocks is 5. Defined below."
  default     = []
}

#variable "placement_constraints" {
#  description = "(Optional) rules that are taken into consideration during task placement. Maximum number of placement_constraints is 10. Defined below."
#  default     = []
#}