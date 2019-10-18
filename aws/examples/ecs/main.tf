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

module "ecs_cluster" {
    source                      = "../../modules/ecs"

    enable_ecs_cluster			= "true"
    ecs_cluster_name			= "jenkins-slave-cluster-nonprod"                  
}

module "ecs_task_definition" {
	source                      						= "../../modules/ecs"

    enable_ecs_task_definition							= "true"
    family 												= "service"
    container_definitions								= "./additional_files/container_definitions.json"

    task_role_arn										= ""
    execution_role_arn									= ""
    network_mode										= "none"
    ipc_mode											= "none"
    pid_mode											= "task"

    volume_name											= "jenkins-slave-volume-nonprod"
    volume_host_path									= "/ecs/jenkins-slave-volume-nonprod"
    docker_volume_configuration_scope					= "shared"
    docker_volume_configuration_autoprovision			= "true"

    task_definition_placement_constraints_type			= "memberOf"
    task_definition_placement_constraints_expression	= "attribute:ecs.availability-zone in [us-east-2a, us-east-2b]"

	
}

module "ecs_service" {
    source                      		= "../../modules/ecs"

    enable_ecs_service					= "true"
    ecs_service_name					= "jenkins-slave-service-nonprod"

    ecs_cluster_id						= "${element(module.ecs_cluster.ecs_cluster_id, 0)}"
    task_definition						= "${element(module.ecs_task_definition.ecs_task_definition_arn, 0)}"       
    desired_count						= "3"
    iam_role							= ""
    
    launch_type							= "EC2"
    platform_version					= "LATEST"
    scheduling_strategy					= "REPLICA"
    deployment_controller_type			= "ECS"

    load_balancer_target_group_arn		= ""
    load_balancer_container_name		= "jenkins-slave-alb-nonprod"
    load_balancer_container_port		= "8080"

    ordered_placement_strategy_type		= "binpack"
    ordered_placement_strategy_field	= "cpu"

    placement_constraints_type			= "memberOf"
    placement_constraints_expression	= "attribute:ecs.availability-zone in [us-east-2a, us-east-2b]"
}