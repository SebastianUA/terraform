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
    required_version = "~>0.12.2"
}

provider "aws" {
    region                  = "us-east-1"
    profile                 = "default"
    shared_credentials_file = "${pathexpand("~/.aws/credentials")}"
}

#############################################################
# AWS key pair
#############################################################
module "key_pair" {
    source                              = "../../modules/key_pair"

    enable_key_pair                     = "true"
    key_name                            = "jenkins-master"
    public_key                          = "${file("./additional_files/keys/jenkins.pub")}"
}

#############################################################
# S3 for ECS
#############################################################
#module "s3" {
#    source                                  = "../../modules/s3"
#    name                                    = "hulu-jenkins"
#    environment                             = "NonPROD"
#    region                                  = "us-west-2"
#
#    enable_s3_bucket                        = true
#    enable_s3_bucket_default_encryption     = true
#    bucket_name                             = "hulu-jenkins"
#    s3_acl                                  = "private"
#    cors_rule                               = []
#
#    enable_versioning                       = true
#    enable_lifecycle_rule                   = true
#
#    #add policy to the bucket
#    enable_s3_bucket_policy                 = false
#    policy                                  = ""
#
#    enable_s3_bucket_object                 = true
#    s3_bucket_object_source                 = ["./additional_files/s3/nonprod/ecs.config"]
#    type_of_file                            = "txt"
#
#}

##############################################################
## ECS Cluster
##############################################################
module "ecs_cluster" {
    source                      = "../../modules/ecs"
    environment                 = "nonprod"
    region                      = "us-west-2"

    enable_ecs_cluster			= "true"
    ecs_cluster_name			= "jenkins-slave-nonprod"
    setting                     = [
        {
            "name" = "containerInsights",
            "value" = "enabled"
        }
    ]
}

#############################################################
# AWS ALB Jenkins Slave
#############################################################
#module "alb_slave" {
#    source                              = "../../modules/alb"
#    name                                = "jenkins-slave"
#    region                              = "us-west-2"
#    environment                         = "nonprod"
#
#    enable_alb                          = "true"
#
#    load_balancer_type                  = "application"
#    lb_internal                         = "true"
#    # noname:sg-0e56ad542cbbf4a6a; company_SecurityGroup_NonProd_us-west-2_Web:sg-f8d9f59e;
#    # company_SecurityGroup_NonProd_us-west-2_Public: sg-fad9f59c
#    # company_SecurityGroup_NonProd_us-west-2_App: sg-ffd9f599
#    # efs-sg: sg-0ac5647ed1f7ebf52
#    security_groups                     = ["sg-ffd9f599", "sg-0ac5647ed1f7ebf52"]
#    # company_Subnet_NonProd_us-west-2a_LB, company_Subnet_NonProd_us-west-2b_LB, company_Subnet_NonProd_us-west-2c_LB
#    subnets                             = ["subnet-a4541ac0", "subnet-b71b7dc1", "subnet-69bf1d31"]
#    # company_VPC_NonProd_us-west-2
#    vpc_id                              = "vpc-59d28b3d"
#    enable_deletion_protection          = false
#
#    enable_alb_target_group             = "true"
#    alb_target_group_name               = "jenkins-slave-alb-nonprod"
#    backend_protocol                    = "HTTP"
#    backend_port                        = "8080"
#
#    health_check_port                   = "8080"
#    health_check_path                   = "/login"
#    health_check_matcher                = "200-307"
#
#    certificate_arn                     = "arn:aws:acm:us-west-2:666666666666:certificate/06bassdc9-h121-47fd-9708-8241h78051c7"
#
#}

#############################################################
# AWS ASG Slave
#############################################################
module "asg_slave" {
    source                              = "../../modules/asg"
    name                                = "jenkins-slave"
    region                              = "us-west-2"
    environment                         = "nonprod"

    # company_SecurityGroup_NonProd_us-west-2_App: sg-ffd9f599; efs-sg: sg-0ac5647ed1f7ebf52
    # company_SecurityGroup_NonProd_us-west-2_Web: sg-f8d9f59e
    security_groups                     = ["sg-ffd9f599", "sg-0ac5647ed1f7ebf52"]
    enable_asg_azs                      = false  

    root_block_device  = [
        {
            volume_size = "500"
            volume_type = "gp2"
        },
    ]
    placement_tenancy        = "default"    

    ami = {
        us-west-2 = "ami-0a994950cc005c703"
    }
    
    # NOTE: If will be used availability_zones than enable_associate_public_ip_address = false!
    enable_associate_public_ip_address  = false

    # Auto scaling group; NOTE: Use vpc_zone_identifier or availability_zones or will be got error!
    # company_Subnet_NonProd_us-west-2a_App, company_Subnet_NonProd_us-west-2b_App, company_Subnet_NonProd_us-west-2c_App
    vpc_zone_identifier                 = ["subnet-da541abe", "subnet-cb1b7dbd", "subnet-76bf1d2e"]
    enable_asg_azs                      = false
    health_check_type                   = "EC2"
    asg_min_size                        = 1
    asg_max_size                        = 5
    desired_capacity                    = 1
    wait_for_capacity_timeout           = 0
    
    monitoring                          = true
    # Set up the autoscaling schedule
    enable_autoscaling_schedule         = false
    asg_recurrence_scale_up             = "0 7 * * MON-FRI"
    asg_recurrence_scale_down           = "0 19 * * MON-FRI"

    # Define SSH key pair for our instances
    key_path                            = "${element(module.key_pair.aws_key_id, 0)}" 
        
    # Set up launch configuration
    ec2_instance_type                   = "t2.2xlarge" #"m5d.16xlarge"
    iam_instance_profile                = "arn:aws:iam::666666666666:instance-profile/jenkins-master-nonprod"
    user_data                           = "${file("./additional_files/ecs_installer.sh")}"

    load_balancer_type                  = "ALB"
    alb_target_group_arn                = ""
    load_balancers                      = []

}

###############################################################
### EFS
###############################################################
module "efs_ecs" {
    source                              = "../../modules/efs"
    efs_name                            = "jenkins-slave-efs-nonprod"
    region                              = "us-west-2"
    environment                         = "nonprod"

    efs_enabled                         = true
    efs_encrypted                       = false
    performance_mode                    = "generalPurpose"
    provisioned_throughput_in_mibps     = 0
    throughput_mode                     = "bursting"
    security_group                      = "sg-0ac5647ed1f7ebf52" #efs-sg
    subnet_ids                          = ["subnet-da541abe", "subnet-cb1b7dbd", "subnet-76bf1d2e"] #company_Subnet_NonProd_us-west-2a_App, company_Subnet_NonProd_us-west-2b_App, company_Subnet_NonProd_us-west-2c_App
}

##############################################################
## ECS task definition
##############################################################
module "ecs_task_definition" {
	source                      						= "../../modules/ecs"
    environment                                         = "nonprod"
    region                                              = "us-west-2"
    name                                                = "jenkins-slave"
   
    enable_ecs_task_definition							= "true"
    family 											    = "jenkins-slave-service-nonprod"
    container_definitions								= "${file("./additional_files/ecs/container_definitions.json")}"

    task_role_arn                                       = "arn:aws:iam::666666666666:role/jenkins-master-nonprod"
    execution_role_arn									= "arn:aws:iam::666666666666:role/jenkins-slave-nonprod"
    network_mode										= "bridge"
    ipc_mode											= "host"
    pid_mode											= "task"

    volume_name										    = ""
    volume_host_path									= "/ecs/jenkins-slave-volume-nonprod"
    docker_volume_configuration_scope					= "shared"
    docker_volume_configuration_autoprovision			= "true"

    task_definition_placement_constraints_type			= "memberOf"
    task_definition_placement_constraints_expression	= "attribute:ecs.availability-zone in [us-east-2a, us-east-2b, us-east-2c]"
}

##############################################################
## ECS service
##############################################################
#module "ecs_service" {
#    source                      		= "../../modules/ecs"
#    environment                         = "nonprod"
#    region                              = "us-west-2"
#
#    enable_ecs_service					= "true"
#    ecs_service_name					= "jenkins-slave-service-nonprod"
#
#    ecs_cluster_id						= "${element(module.ecs_cluster.ecs_cluster_id, 0)}"
#    task_definition					    = "${element(module.ecs_task_definition.ecs_task_definition_arn, 0)}"       
#    desired_count						= "3"
#    iam_role							= ""
#    
#    launch_type						    = "EC2"
#    platform_version					= "LATEST"
#    scheduling_strategy				    = "REPLICA"
#    deployment_controller_type			= "ECS"
#
#    load_balancer_target_group_arn		= "${element(module.alb_slave.target_group_arn, 0)}"
#    load_balancer_container_name		= "tomcat-webserver"
#    load_balancer_container_port		= "8080"
#
#    ordered_placement_strategy_type	    = "binpack"
#    ordered_placement_strategy_field	= "cpu"
#
#    placement_constraints_type			= "memberOf"
#    placement_constraints_expression	= "attribute:ecs.availability-zone in [us-east-2a, us-east-2b]"
#
#}
#
```

Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default     = "TEST"`)
- `region` - The region where to deploy this code (e.g. us-east-1). (`default     = "us-east-1"`).
- `environment` - Environment for service (`  default     = "STAGE"`).
- `orchestration` - Type of orchestration (`  default     = "Terraform"`).
- `createdby` - Created by (`  default     = "Vitaliy Natarov"`).
- `enable_ecs_cluster` - Enable ecs cluster (`default     = "false"`).
- `ecs_cluster_name` - The name of the cluster (up to 255 letters, numbers, hyphens, and underscores) (`default     = ""`).
- `setting` - (Optional) Configuration block(s) with cluster settings. For example, this can be used to enable CloudWatch Container Insights for a cluster. The name - (Required) Name of the setting to manage. Valid values: containerInsights. The value - (Required) The value to assign to the setting. Value values are enabled and disabled. (`default     = []`).
- `enable_ecs_service` - Enable ecs service (`default     = "false"`).
- `enable_ecs_service_daemon` - Enable ecs service as deamon (`default     = "false"`).
- `ecs_service_name` - The name of the service (up to 255 letters, numbers, hyphens, and underscores) (`default     = ""`).
- `ecs_cluster_id` - ARN of an ECS cluster (`default     = ""`).
- `task_definition` - (Required) The family and revision (family:revision) or full ARN of the task definition that you want to run in your service. (`default = ""`).
- `desired_count` - (Optional) The number of instances of the task definition to place and keep running. Defaults to 0. Do not specify if using the DAEMON scheduling strategy. (`default     = "3"`).
- `iam_role` - (Optional) ARN of the IAM role that allows Amazon ECS to make calls to your load balancer on your behalf. This parameter is required if you are using a load balancer with your service, but only if your task definition does not use the awsvpc network mode. If using awsvpc network mode, do not specify this role. If your account has already created the Amazon ECS service-linked role, that role is used by default for your service unless you specify a role here. (`default     = ""`).
- `launch_type ` - (Optional) The launch type on which to run your service. The valid values are EC2 and FARGATE. Defaults to EC2. (`default     = "EC2"`).
- `platform_version` - (Optional) The platform version on which to run your service. Only applicable for launch_type set to FARGATE. Defaults to LATEST. (`default     = "LATEST"`).
- `scheduling_strategy` - (Optional) The scheduling strategy to use for the service. The valid values are REPLICA and DAEMON. Defaults to REPLICA. (`default     = "REPLICA"`).
- `propagate_tags` - (Optional) Specifies whether to propagate the tags from the task definition or the service to the tasks. The valid values are SERVICE and TASK_DEFINITION. (`default     = "SERVICE"`).
- `deployment_controller_type` - (Optional) Type of deployment controller. Valid values: CODE_DEPLOY, ECS. Default: ECS. (`default     = "ECS"`).
- `load_balancer_elb_name` - (Required for ELB Classic) The name of the ELB (Classic) to associate with the service. (`default     = ""`).
- `load_balancer_target_group_arn` - (Required for ALB/NLB) The ARN of the Load Balancer target group to associate with the service. (`default     = ""`).
- `load_balancer_container_name` - (Required) The name of the container to associate with the load balancer (as it appears in a container definition). (`default     = ""`).
- `load_balancer_container_port` - (Required) The port on the container to associate with the load balancer. (`default     = "8080"`).
- `ordered_placement_strategy_type` - (Required) The type of placement strategy. Must be one of: binpack, random, or spread (`default     = "binpack"`).
- `ordered_placement_strategy_field` - (Optional) For the spread placement strategy, valid values are instanceId (or host, which has the same effect), or any platform or custom attribute that is applied to a container instance. For the binpack type, valid values are memory and cpu. For the random type, this attribute is not needed. (`default     = "cpu"`).
- `placement_constraints_type` - (Required) The type of constraint. The only valid values at this time are memberOf and distinctInstance. (`default     = "memberOf"`).
- `placement_constraints_expression` - (Optional) Cluster Query Language expression to apply to the constraint. Does not need to be specified for the distinctInstance type. (`default     = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"`).
- `enable_ecs_task_definition` - Enable ecs task definition (`default     = "false"`).
- `family` - (Required) A unique name for your task definition. (`default     = "service"`).
- `container_definitions` - (Required) A list of valid container definitions provided as a single valid JSON document. Please note that you should only provide values that are part of the container definition document. For a detailed description of what parameters are available, see the Task Definition Parameters section from the official Developer Guide. (`default     = "value"`).
- `task_role_arn` - (Optional) The ARN of IAM role that allows your Amazon ECS container task to make calls to other AWS services. (`default     = ""`).
- `execution_role_arn` - (Optional) The Amazon Resource Name (ARN) of the task execution role that the Amazon ECS container agent and the Docker daemon can assume. (`default     = ""`).
- `network_mode` - (Optional) The Docker networking mode to use for the containers in the task. The valid values are none, bridge, awsvpc, and host. (`default     = "none"`).
- `ipc_mode` - (Optional) The IPC resource namespace to be used for the containers in the task The valid values are host, task, and none. (`default     = "none"`).
- `pid_mode` - (Optional) The process namespace to use for the containers in the task. The valid values are host and task. (`default     = "task"`).
- `volume_name` -  (Required) The name of the volume. This name is referenced in the sourceVolume parameter of container definition in the mountPoints section. (`default     = ""`).
- `volume_host_path` - (Optional) The path on the host container instance that is presented to the container. If not set, ECS will create a nonpersistent data volume that starts empty and is deleted after the task has finished. (`default     = "/ecs/service-storage"`).
- `docker_volume_configuration_scope` - (Optional) The scope for the Docker volume, which determines its lifecycle, either task or shared. Docker volumes that are scoped to a task are automatically provisioned when the task starts and destroyed when the task stops. Docker volumes that are scoped as shared persist after the task stops. (`default     = "shared"`).
- `docker_volume_configuration_autoprovision` - (Optional) If this value is true, the Docker volume is created if it does not already exist. Note: This field is only used if the scope is shared. (`default     = "true"`).
- `task_definition_placement_constraints_type` - (Required) The type of constraint. Use memberOf to restrict selection to a group of valid candidates. Note that distinctInstance is not supported in task definitions. (`default     = "memberOf"`).
- `task_definition_placement_constraints_expression` - (Optional) Cluster Query Language expression to apply to the constraint. For more information, see Cluster Query Language in the Amazon EC2 Container Service Developer Guide. (`default     = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"`).
- `proxy_configuration_type` - (Optional) The proxy type. The default value is APPMESH. The only supported value is APPMESH. (`default     = "APPMESH"`).
- `proxy_configuration_container_name` - (Required) The name of the container that will serve as the App Mesh proxy. (`default     = ""`).
- `proxy_configuration_properties_appports` -  (`default     = "8080"`).
- `proxy_configuration_properties_egressignoredips` -  (`default     = "169.254.170.2,169.254.169.254"`).
- `proxy_configuration_properties_ignoreduid` -  (`default     = "1339"`).
- `proxy_configuration_properties_proxyegressport` -  (`default     = "15001"`).
- `proxy_configuration_properties_proxyingressport` -  (`default     = "15000"`).
}

Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.
