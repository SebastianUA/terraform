#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
    required_version = "> 0.12.12"
}

provider "aws" {
    region  = "us-west-2"
    profile = "default"
}
<<<<<<< HEAD

module "iam" {
    source                          = "../../modules/iam"
    name                            = "TEST-AIM"
    environment                     = "PROD"

    enable_iam_role                 = true
    # if you would like to set custom name for role, use iam_role_name;
    iam_role_name                   = "test_assume_role2"
    assume_role_policy_file         = "additional_files/policies/test_policy_principal.json"

    enable_iam_instance_profile     = false

    enable_iam_policy               = true
    iam_policy_file                 = "additional_files/policies/test_policy.json"
    enable_iam_policy_attachment    = true

    enable_crossaccount_role        = false
    cross_acc_principal_arns        = ["222222222222222","arn:aws:iam::333333333333:user/test"]
    cross_acc_policy_arns           = ["arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser", "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"]

    enable_iam_server_certificate   = false
    certificate_body_file           = "additional_files/certs/example.crt.pem"
    private_key_file                = "additional_files/certs/example.key.pem"
}

module "vpc" {
    source                              = "../../modules/vpc"
    name                                = "TEST-VPC"
    environment                         = "PROD"
    # VPC
    instance_tenancy                    = "default"
    enable_dns_support                  = "true"
    enable_dns_hostnames                = "true"
    assign_generated_ipv6_cidr_block    = "false"
    enable_classiclink                  = "false"
    vpc_cidr                            = "172.31.0.0/16"
    private_subnet_cidrs                = ["172.31.64.0/20"]
    public_subnet_cidrs                 = ["172.31.0.0/20"]
    availability_zones                  = ["us-east-1a", "us-east-1b"]
    enable_all_egress_ports             = "true"
    allowed_ports                       = ["8080", "3306", "80", "443"]

    map_public_ip_on_launch             = "true"
=======
>>>>>>> dev

module "ec2" {
    source                              = "../../modules/ec2"
    name                                = "TEST-Machine"    
    region                              = "us-west-2"

    enable_instance                     = true
    environment                         = "dev"
    instance_type                   = "t2.micro"
    enable_associate_public_ip_address  = true
    disk_size                           = 8
    tenancy                             = "default"
    iam_instance_profile                = ""
    subnet_id                           = ""
    vpc_security_group_ids              = []

    monitoring                          = true
}