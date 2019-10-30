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

#------------------------------------------------------------------
# AWS ECS cluster
#------------------------------------------------------------------
variable "enable_ecs_cluster" {
  description = "Enable ecs cluster"
  default     = "false"
}

variable "ecs_cluster_name" {
  description = "The name of the cluster (up to 255 letters, numbers, hyphens, and underscores)"
  default     = ""
}

variable "setting" {
  description = "(Optional) Configuration block(s) with cluster settings. For example, this can be used to enable CloudWatch Container Insights for a cluster. The name - (Required) Name of the setting to manage. Valid values: containerInsights. The value - (Required) The value to assign to the setting. Value values are enabled and disabled."
  type        = "list"
  default     = []
}

#------------------------------------------------------------------
# AWS ECS service
#------------------------------------------------------------------
variable "enable_ecs_service" {
  description = "Enable ecs service"
  default     = "false"
}

variable "enable_ecs_service_daemon" {
  description = "Enable ecs service as deamon"
  default     = "false"
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
  default     = "3"
}

variable "iam_role" {
  description = "(Optional) ARN of the IAM role that allows Amazon ECS to make calls to your load balancer on your behalf. This parameter is required if you are using a load balancer with your service, but only if your task definition does not use the awsvpc network mode. If using awsvpc network mode, do not specify this role. If your account has already created the Amazon ECS service-linked role, that role is used by default for your service unless you specify a role here."
  default     = ""
}

variable "launch_type " {
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
  default     = "2"
}

variable "enable_ecs_managed_tags" {
  description = "(Optional) Specifies whether to enable Amazon ECS managed tags for the tasks within the service."
  default     = "true"
}

variable "health_check_grace_period_seconds" {
  description = "(Optional) Seconds to ignore failing load balancer health checks on newly instantiated tasks to prevent premature shutdown, up to 2147483647. Only valid for services configured to use load balancers."
  default     = "2147483647"
}

variable "network_configuration_subnets" {
  description = "(Required) The subnets associated with the task or service."
  type        = "list"
  default     = []
}

variable "network_configuration_security_groups" {
  description = "(Optional) The security groups associated with the task or service. If you do not specify a security group, the default security group for the VPC is used."
  type        = "list"
  default     = []
}

variable "network_configuration_assign_public_ip" {
  description = "(Optional) Assign a public IP address to the ENI (Fargate launch type only). Valid values are true or false. Default false."
  default     = "false"
}

variable "service_registries_registry_arn" {
  description = "(Required) The ARN of the Service Registry. The currently supported service registry is Amazon Route 53 Auto Naming Service(aws_service_discovery_service)."
  default     = ""
}

variable "service_registries_port" {
  description = "(Optional) The port value used if your Service Discovery service specified an SRV record."
  default     = "9999"
}

variable "service_registries_container_port" {
  description = "(Optional) The port value, already specified in the task definition, to be used for your service discovery service."
  default     = "9999"
}

variable "service_registries_container_name" {
  description = "(Optional) The container name value, already specified in the task definition, to be used for your service discovery service."
  default     = ""
}

variable "deployment_controller_type" {
  description = "(Optional) Type of deployment controller. Valid values: CODE_DEPLOY, ECS. Default: ECS."
  default     = "ECS"
}

variable "load_balancer_elb_name" {
  description = "(Required for ELB Classic) The name of the ELB (Classic) to associate with the service."
  default     = ""
}

variable "load_balancer_target_group_arn" {
  description = "(Required for ALB/NLB) The ARN of the Load Balancer target group to associate with the service."
  default     = ""
}

variable "load_balancer_container_name" {
  description = "(Required) The name of the container to associate with the load balancer (as it appears in a container definition)."
  default     = ""
}

variable "load_balancer_container_port" {
  description = "(Required) The port on the container to associate with the load balancer."
  default     = "8080"
}

variable "ordered_placement_strategy_type" {
  description = "(Required) The type of placement strategy. Must be one of: binpack, random, or spread"
  default     = "binpack"
}

variable "ordered_placement_strategy_field" {
  description = "(Optional) For the spread placement strategy, valid values are instanceId (or host, which has the same effect), or any platform or custom attribute that is applied to a container instance. For the binpack type, valid values are memory and cpu. For the random type, this attribute is not needed."
  default     = "cpu"
}

variable "placement_constraints_type" {
  description = "(Required) The type of constraint. The only valid values at this time are memberOf and distinctInstance."
  default     = "memberOf"
}

variable "placement_constraints_expression" {
  description = "(Optional) Cluster Query Language expression to apply to the constraint. Does not need to be specified for the distinctInstance type."
  default     = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
}

#------------------------------------------------------------------
# AWS ECS task definition
#------------------------------------------------------------------
variable "enable_ecs_task_definition" {
  description = "Enable ecs task definition"
  default     = "false"
}

variable "family" {
  description = "(Required) A unique name for your task definition."
  default     = "service"
}

variable "container_definitions" {
  description = "(Required) A list of valid container definitions provided as a single valid JSON document. Please note that you should only provide values that are part of the container definition document. For a detailed description of what parameters are available, see the Task Definition Parameters section from the official Developer Guide."
  default     = "value"
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

variable "volume_name" {
  description = " (Required) The name of the volume. This name is referenced in the sourceVolume parameter of container definition in the mountPoints section."
  default     = ""
}

variable "volume_host_path" {
  description = "(Optional) The path on the host container instance that is presented to the container. If not set, ECS will create a nonpersistent data volume that starts empty and is deleted after the task has finished."
  default     = "/ecs/service-storage"
}

variable "docker_volume_configuration_scope" {
  description = "(Optional) The scope for the Docker volume, which determines its lifecycle, either task or shared. Docker volumes that are scoped to a task are automatically provisioned when the task starts and destroyed when the task stops. Docker volumes that are scoped as shared persist after the task stops."
  default     = "shared"
}

variable "docker_volume_configuration_autoprovision" {
  description = "(Optional) If this value is true, the Docker volume is created if it does not already exist. Note: This field is only used if the scope is shared."
  default     = "true"
}

variable "task_definition_placement_constraints_type" {
  description = "(Required) The type of constraint. Use memberOf to restrict selection to a group of valid candidates. Note that distinctInstance is not supported in task definitions."
  default     = "memberOf"
}

variable "task_definition_placement_constraints_expression" {
  description = "(Optional) Cluster Query Language expression to apply to the constraint. For more information, see Cluster Query Language in the Amazon EC2 Container Service Developer Guide."
  default     = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
}

variable "proxy_configuration_type" {
  description = "(Optional) The proxy type. The default value is APPMESH. The only supported value is APPMESH."
  default     = "APPMESH"
}

variable "proxy_configuration_container_name" {
  description = "(Required) The name of the container that will serve as the App Mesh proxy."
  default     = ""
}

variable "proxy_configuration_properties_appports" {
  description = ""
  default     = "8080"
}

variable "proxy_configuration_properties_egressignoredips" {
  description = ""
  default     = "169.254.170.2,169.254.169.254"
}

variable "proxy_configuration_properties_ignoreduid" {
  description = ""
  default     = "1339"
}

variable "proxy_configuration_properties_proxyegressport" {
  description = ""
  default     = "15001"
}

variable "proxy_configuration_properties_proxyingressport" {
  description = ""
  default     = "15000"
}