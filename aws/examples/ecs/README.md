# Work with AWS ECS via terraform

A terraform module for making AWS ECS resources.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
    required_version = "~> 0.12.12"
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
    source                      = "../../modules/ecs"
    environment                 = "nonprod"

    enable_ecs_cluster          = true
    ecs_cluster_name            = "jenkins-slave-nonprod"
    setting                     = [
        {
            name    = "containerInsights",
            value   = "enabled"
        }
    ]

    tags                        = map("Env", "stage", "Orchestration", "Terraform")
}

##############################################################
## ECS task definition
##############################################################
module "ecs_task_definition" {
    source                                              = "../../modules/ecs"
    environment                                         = "nonprod"
    name                                                = "jenkins-slave"

    enable_ecs_task_definition                          = true
    family                                              = "jenkins-slave-service-nonprod"
    container_definitions                               = file("./additional_files/ecs/container_definitions.json")

    task_role_arn                                       = "arn:aws:iam::666666666666:role/jenkins-master-nonprod"
    execution_role_arn                                  = "arn:aws:iam::666666666666:role/jenkins-slave-nonprod"
    network_mode                                        = "bridge"
    ipc_mode                                            = "host"
    pid_mode                                            = "task"

    volume  = [
        {
            name        = "jenkins-slave-volume-nonprod"
            host_path   = "/ecs/jenkins-slave-volume-nonprod"
        },
    ]

    placement_constraints = [
        {
            type         = "memberOf"
            expression   = "attribute:ecs.availability-zone in [us-east-2a, us-east-2b, us-east-2c]"
        },
    ]

    tags                        = map("Env", "stage", "Orchestration", "Terraform")
}

##############################################################
## ECS service
##############################################################
module "ecs_service" {
    source                              = "../../modules/ecs"
    environment                         = "nonprod"

    enable_ecs_service                  = true
    ecs_service_name                    = "jenkins-slave-service-nonprod"

    ecs_cluster_id                      = module.ecs_cluster.ecs_cluster_id
    task_definition                     = module.ecs_task_definition.ecs_task_definition_arn
    desired_count                       = 3
    iam_role                            = ""

    launch_type                         = "EC2"
    platform_version                    = "LATEST"
    scheduling_strategy                 = "REPLICA"

    deployment_controller               = [
        {
            type         = "ECS"
        },
    ]

    #load_balancer                       = [
    #    {
    #        target_group_arn    = "alb"
    #        container_port      = 8080
    #    },
    #]

    ordered_placement_strategy          = [
        {
            type    = "binpack"
            field   = "cpu"
        },
    ]

    placement_constraints               = [
        {
            type         = "memberOf"
            expression   = "attribute:ecs.availability-zone in [us-east-2a, us-east-2b]"
        },
    ]

    tags                        = map("Env", "stage", "Orchestration", "Terraform")
}
```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks (`default = {}`)
- `enable_ecs_cluster` - Enable ecs cluster (`default = False`)
- `ecs_cluster_name` - The name of the cluster (up to 255 letters, numbers, hyphens, and underscores) (`default = ""`)
- `setting` - (Optional) Configuration block(s) with cluster settings. For example, this can be used to enable CloudWatch Container Insights for a cluster. The name - (Required) Name of the setting to manage. Valid values: containerInsights. The value - (Required) The value to assign to the setting. Value values are enabled and disabled. (`default = []`)
- `enable_ecs_task_definition` - Enable ecs task definition (`default = False`)
- `family` - (Required) A unique name for your task definition. (`default = ""`)
- `container_definitions` - (Required) A list of valid container definitions provided as a single valid JSON document. Please note that you should only provide values that are part of the container definition document. For a detailed description of what parameters are available, see the Task Definition Parameters section from the official Developer Guide. (`default = ""`)
- `task_role_arn` - (Optional) The ARN of IAM role that allows your Amazon ECS container task to make calls to other AWS services. (`default = ""`)
- `execution_role_arn` - (Optional) The Amazon Resource Name (ARN) of the task execution role that the Amazon ECS container agent and the Docker daemon can assume. (`default = ""`)
- `network_mode` - (Optional) The Docker networking mode to use for the containers in the task. The valid values are none, bridge, awsvpc, and host. (`default = none`)
- `ipc_mode` - (Optional) The IPC resource namespace to be used for the containers in the task The valid values are host, task, and none. (`default = none`)
- `pid_mode` - (Optional) The process namespace to use for the containers in the task. The valid values are host and task. (`default = task`)
- `volume` - (Optional) A set of volume blocks that containers in your task may use. (`default = []`)
- `placement_constraints` - (Optional) A set of placement constraints rules that are taken into consideration during task placement. Maximum number of placement_constraints is 10. (`default = []`)
- `proxy_configuration_type` - (Optional) The proxy type. The default value is APPMESH. The only supported value is APPMESH. (`default = null`)
- `proxy_configuration_container_name` - (Required) The name of the container that will serve as the App Mesh proxy. (`default = ""`)
- `proxy_configuration_properties_appports` - For ex: 8080 (`default = null`)
- `proxy_configuration_properties_egressignoredips` - For ex: '169.254.170.2,169.254.169.254' (`default = null`)
- `proxy_configuration_properties_ignoreduid` - For ex: 1339 (`default = null`)
- `proxy_configuration_properties_proxyegressport` - For ex: 15001 (`default = null`)
- `proxy_configuration_properties_proxyingressport` - For ex: 15000 (`default = null`)
- `enable_appmesh_proxy` - Enable ecs task definition (`default = False`)
- `enable_ecs_service` - Enable ecs service (`default = False`)
- `enable_ecs_service_daemon` - Enable ecs service as deamon (`default = False`)
- `ecs_service_name` - The name of the service (up to 255 letters, numbers, hyphens, and underscores) (`default = ""`)
- `ecs_cluster_id` - ARN of an ECS cluster (`default = ""`)
- `task_definition` - (Required) The family and revision (family:revision) or full ARN of the task definition that you want to run in your service. (`default = ""`)
- `desired_count` - (Optional) The number of instances of the task definition to place and keep running. Defaults to 0. Do not specify if using the DAEMON scheduling strategy. (`default = 3`)
- `iam_role` - (Optional) ARN of the IAM role that allows Amazon ECS to make calls to your load balancer on your behalf. This parameter is required if you are using a load balancer with your service, but only if your task definition does not use the awsvpc network mode. If using awsvpc network mode, do not specify this role. If your account has already created the Amazon ECS service-linked role, that role is used by default for your service unless you specify a role here. (`default = ""`)
- `launch_type` - (Optional) The launch type on which to run your service. The valid values are EC2 and FARGATE. Defaults to EC2. (`default = EC2`)
- `platform_version` - (Optional) The platform version on which to run your service. Only applicable for launch_type set to FARGATE. Defaults to LATEST. (`default = LATEST`)
- `scheduling_strategy` - (Optional) The scheduling strategy to use for the service. The valid values are REPLICA and DAEMON. Defaults to REPLICA. (`default = REPLICA`)
- `propagate_tags` - (Optional) Specifies whether to propagate the tags from the task definition or the service to the tasks. The valid values are SERVICE and TASK_DEFINITION. (`default = SERVICE`)
- `deployment_maximum_percent` - (Optional) The upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment. Not valid when using the DAEMON scheduling strategy. (`default = ""`)
- `deployment_minimum_healthy_percent` - (Optional) The lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment. (`default = 2`)
- `enable_ecs_managed_tags` - (Optional) Specifies whether to enable Amazon ECS managed tags for the tasks within the service. (`default = True`)
- `health_check_grace_period_seconds` - (Optional) Seconds to ignore failing load balancer health checks on newly instantiated tasks to prevent premature shutdown, up to 2147483647. Only valid for services configured to use load balancers. (`default = 2147483647`)
- `network_configuration` - (Optional) The network configuration for the service. This parameter is required for task definitions that use the awsvpc network mode to receive their own Elastic Network Interface, and it is not supported for other network modes. (`default = []`)
- `service_registries` - (Optional) The service discovery registries for the service. The maximum number of service_registries blocks is 1. (`default = []`)
- `service_registries_container_name` - (Optional) The container name value, already specified in the task definition, to be used for your service discovery service. (`default = ""`)
- `deployment_controller` - (Optional) Configuration block containing deployment controller configuration. (`default = []`)
- `load_balancer` - (Optional) A load balancer block. (`default = []`)
- `load_balancer_container_name` - (Required) The name of the container to associate with the load balancer (as it appears in a container definition). (`default = ""`)
- `ordered_placement_strategy` - (Optional) Service level strategy rules that are taken into consideration during task placement. List from top to bottom in order of precedence. The maximum number of ordered_placement_strategy blocks is 5. Defined below. (`default = []`)

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


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
