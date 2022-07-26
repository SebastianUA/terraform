# Work with ECS via terraform

A terraform module for making ECS.


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
  profile                 = "default"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

##############################################################
## ECS Cluster
##############################################################
module "ecs_cluster" {
  source      = "../../modules/ecs"
  environment = "nonprod"

  enable_ecs_cluster = true
  ecs_cluster_name   = "jenkins-slave-nonprod"
  ecs_cluster_setting = [
    {
      name  = "containerInsights",
      value = "enabled"
    }
  ]

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}

##############################################################
## ECS task definition
##############################################################
module "ecs_task_definition" {
  source      = "../../modules/ecs"
  environment = "nonprod"
  name        = "jenkins-slave"

  enable_ecs_task_definition                = true
  ecs_task_definition_family                = "jenkins-slave-service-nonprod"
  ecs_task_definition_container_definitions = file("./additional_files/ecs/container_definitions.json")

  ecs_task_definition_task_role_arn      = "arn:aws:iam::666666666666:role/jenkins-master-nonprod"
  ecs_task_definition_execution_role_arn = "arn:aws:iam::666666666666:role/jenkins-slave-nonprod"
  ecs_task_definition_network_mode       = "bridge"
  ecs_task_definition_ipc_mode           = "host"
  ecs_task_definition_pid_mode           = "task"

  ecs_task_definition_volume = [{
    name      = "jenkins-slave-volume-nonprod"
    host_path = "/ecs/jenkins-slave-volume-nonprod"

    docker_volume_configuration = {
      scope         = "shared"
      autoprovision = true
      driver        = "local"

      driver_opts = {
        "type"   = "nfs"
        "device" = "aws_efs_file_system_dns_name:/"
        "o"      = "addr=aws_efs_file_system_dns_name,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport"
      }
    }

    efs_volume_configuration = {
      file_system_id          = "aws_efs_file_system_id"
      root_directory          = "/opt/data"
      transit_encryption      = "ENABLED"
      transit_encryption_port = 2999

      access_point_id = "aws_efs_access_point_id"
      iam             = "ENABLED"
    }
  }]

  ecs_task_definition_placement_constraints = [
    {
      type       = "memberOf"
      expression = "attribute:ecs.availability-zone in [us-east-2a, us-east-2b, us-east-2c]"
    },
  ]

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}

##############################################################
## ECS service
##############################################################
module "ecs_service" {
  source      = "../../modules/ecs"
  environment = "nonprod"

  enable_ecs_service = true
  ecs_service_name   = "jenkins-slave-service-nonprod"

  ecs_service_cluster         = module.ecs_cluster.ecs_cluster_id
  ecs_service_task_definition = module.ecs_task_definition.ecs_task_definition_arn
  ecs_service_desired_count   = 3
  ecs_service_iam_role        = ""

  ecs_service_launch_type         = "EC2"
  ecs_service_platform_version    = "LATEST"
  ecs_service_scheduling_strategy = "REPLICA"

  ecs_service_deployment_controller = [
    {
      type = "ECS"
    }
  ]

  #ecs_service_load_balancer                       = [
  #    {
  #        target_group_arn    = "alb"
  #        container_port      = 8080
  #    },
  #]

  ecs_service_ordered_placement_strategy = [
    {
      type  = "binpack"
      field = "cpu"
    },
  ]

  ecs_service_placement_constraints = [
    {
      type       = "memberOf"
      expression = "attribute:ecs.availability-zone in [us-east-2a, us-east-2b]"
    },
  ]

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks (`default = {}`)
- `enable_ecs_cluster` - Enable ecs cluster (`default = False`)
- `ecs_cluster_name` - The name of the cluster (up to 255 letters, numbers, hyphens, and underscores) (`default = ""`)
- `ecs_cluster_capacity_providers` - (Optional) List of short names of one or more capacity providers to associate with the cluster. Valid values also include FARGATE and FARGATE_SPOT. (`default = null`)
- `ecs_cluster_default_capacity_provider_strategy` - (Optional) The capacity provider strategy to use by default for the cluster. Can be one or more. (`default = []`)
- `ecs_cluster_setting` - (Optional) Configuration block(s) with cluster settings. For example, this can be used to enable CloudWatch Container Insights for a cluster. The name - (Required) Name of the setting to manage. Valid values: containerInsights. The value - (Required) The value to assign to the setting. Value values are enabled and disabled. (`default = []`)
- `enable_ecs_task_definition` - Enable ecs task definition (`default = False`)
- `ecs_task_definition_family` - (Required) A unique name for your task definition. (`default = ""`)
- `ecs_task_definition_container_definitions` - (Required) A list of valid container definitions provided as a single valid JSON document. Please note that you should only provide values that are part of the container definition document. For a detailed description of what parameters are available, see the Task Definition Parameters section from the official Developer Guide. (`default = ""`)
- `ecs_task_definition_task_role_arn` - (Optional) The ARN of IAM role that allows your Amazon ECS container task to make calls to other AWS services. (`default = null`)
- `ecs_task_definition_execution_role_arn` - (Optional) The Amazon Resource Name (ARN) of the task execution role that the Amazon ECS container agent and the Docker daemon can assume. (`default = null`)
- `ecs_task_definition_network_mode` - (Optional) The Docker networking mode to use for the containers in the task. The valid values are none, bridge, awsvpc, and host. (`default = null`)
- `ecs_task_definition_ipc_mode` - (Optional) The IPC resource namespace to be used for the containers in the task The valid values are host, task, and none. (`default = null`)
- `ecs_task_definition_pid_mode` - (Optional) The process namespace to use for the containers in the task. The valid values are host and task. (`default = null`)
- `ecs_task_definition_cpu` - (Optional) The number of cpu units used by the task. If the requires_compatibilities is FARGATE this field is required. (`default = null`)
- `ecs_task_definition_memory` - (Optional) The amount (in MiB) of memory used by the task. If the requires_compatibilities is FARGATE this field is required. (`default = null`)
- `ecs_task_definition_requires_compatibilities` - (Optional) A set of launch types required by the task. The valid values are EC2 and FARGATE. (`default = null`)
- `ecs_task_definition_volume` - (Optional) Configuration block for volumes that containers in your task may use. (`default = []`)
- `ecs_task_definition_placement_constraints` - (Optional) A set of placement constraints rules that are taken into consideration during task placement. Maximum number of placement_constraints is 10. (`default = []`)
- `ecs_task_definition_proxy_configuration` - (Optional) The proxy configuration details for the App Mesh proxy. (`default = []`)
- `ecs_task_definition_inference_accelerator` - (Optional) Configuration block(s) with Inference Accelerators settings. (`default = []`)
- `enable_ecs_service` - Enable ecs service (`default = False`)
- `ecs_service_name` - The name of the service (up to 255 letters, numbers, hyphens, and underscores) (`default = ""`)
- `ecs_service_cluster` - ARN of an ECS cluster (`default = ""`)
- `ecs_service_task_definition` - (Required) The family and revision (family:revision) or full ARN of the task definition that you want to run in your service. (`default = ""`)
- `ecs_service_desired_count` - (Optional) The number of instances of the task definition to place and keep running. Defaults to 0. Do not specify if using the DAEMON scheduling strategy. (`default = 3`)
- `ecs_service_iam_role` - (Optional) ARN of the IAM role that allows Amazon ECS to make calls to your load balancer on your behalf. This parameter is required if you are using a load balancer with your service, but only if your task definition does not use the awsvpc network mode. If using awsvpc network mode, do not specify this role. If your account has already created the Amazon ECS service-linked role, that role is used by default for your service unless you specify a role here. (`default = null`)
- `ecs_service_launch_type` - (Optional) The launch type on which to run your service. The valid values are EC2 and FARGATE. Defaults to EC2. (`default = null`)
- `ecs_service_platform_version` - (Optional) The platform version on which to run your service. Only applicable for launch_type set to FARGATE. Defaults to LATEST. (`default = null`)
- `ecs_service_scheduling_strategy` - (Optional) The scheduling strategy to use for the service. The valid values are REPLICA and DAEMON. Defaults to REPLICA. (`default = null`)
- `ecs_service_propagate_tags` - (Optional) Specifies whether to propagate the tags from the task definition or the service to the tasks. The valid values are SERVICE and TASK_DEFINITION. (`default = null`)
- `ecs_service_deployment_maximum_percent` - (Optional) The upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment. Not valid when using the DAEMON scheduling strategy. (`default = null`)
- `ecs_service_deployment_minimum_healthy_percent` - (Optional) The lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment. (`default = null`)
- `ecs_service_enable_ecs_managed_tags` - (Optional) Specifies whether to enable Amazon ECS managed tags for the tasks within the service. (`default = null`)
- `ecs_service_health_check_grace_period_seconds` - (Optional) Seconds to ignore failing load balancer health checks on newly instantiated tasks to prevent premature shutdown, up to 2147483647. Only valid for services configured to use load balancers. (`default = null`)
- `ecs_service_force_new_deployment` - (Optional) Enable to force a new task deployment of the service. This can be used to update tasks to use a newer Docker image with same image/tag combination (e.g. myimage:latest), roll Fargate tasks onto a newer platform version, or immediately deploy ordered_placement_strategy and placement_constraints updates. (`default = null`)
- `ecs_service_wait_for_steady_state` - (Optional) If true, Terraform will wait for the service to reach a steady state (like aws ecs wait services-stable) before continuing. Default false. (`default = null`)
- `ecs_service_capacity_provider_strategy` - (Optional) The capacity provider strategy to use for the service. Can be one or more. (`default = []`)
- `ecs_service_network_configuration` - (Optional) The network configuration for the service. This parameter is required for task definitions that use the awsvpc network mode to receive their own Elastic Network Interface, and it is not supported for other network modes. (`default = []`)
- `ecs_service_service_registries` - (Optional) The service discovery registries for the service. The maximum number of service_registries blocks is 1. (`default = []`)
- `ecs_service_deployment_controller` - (Optional) Configuration block containing deployment controller configuration. (`default = []`)
- `ecs_service_load_balancer` - (Optional) A load balancer block. (`default = []`)
- `ecs_service_ordered_placement_strategy` - (Optional) Service level strategy rules that are taken into consideration during task placement. List from top to bottom in order of precedence. The maximum number of ordered_placement_strategy blocks is 5. Defined below. (`default = []`)
- `ecs_service_placement_constraints` - (Optional) rules that are taken into consideration during task placement. Maximum number of placement_constraints is 10. Defined below. (`default = []`)
- `enable_ecs_capacity_provider` - Enable ecs capacity provider usage (`default = False`)
- `ecs_capacity_provider_name` - The name of the capacity provider. (`default = ""`)
- `ecs_capacity_provider_auto_scaling_group_provider` - (Required) Configuration block for the provider for the ECS auto scaling group. (`default = []`)

## Module Output Variables
----------------------
- `ecs_cluster_id` - The Amazon Resource Name (ARN) that identifies the cluster
- `ecs_cluster_arn` - The Amazon Resource Name (ARN) that identifies the cluster
- `ecs_service_id` - The Amazon Resource Name (ARN) that identifies the service
- `ecs_service_name` - The name of the service
- `ecs_service_cluster` - The Amazon Resource Name (ARN) of cluster which the service runs on
- `ecs_service_iam_role` - The ARN of IAM role used for ELB
- `ecs_service_desired_count` - The number of instances of the task definition
- `ecs_task_definition_arn` - Full ARN of the Task Definition (including both family and revision).
- `ecs_task_definition_family` - The family of the Task Definition.
- `ecs_task_definition_revision` - The revision of the task in a particular family.
- `ecs_capacity_provider_id` - The Amazon Resource Name (ID) that identifies the capacity provider.
- `ecs_capacity_provider_arn` - The Amazon Resource Name (ARN) that identifies the capacity provider.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
