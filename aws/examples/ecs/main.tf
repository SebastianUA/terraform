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