#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
  required_version = "~> 0.15"
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

  tags = map("Env", "stage", "Orchestration", "Terraform")
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

  tags = map("Env", "stage", "Orchestration", "Terraform")
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

  tags = map("Env", "stage", "Orchestration", "Terraform")
}
