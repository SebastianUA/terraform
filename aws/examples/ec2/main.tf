#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "> 0.9.0"
}
provider "aws" {
    region  = "us-east-1"
    profile = "default"
}
module "iam" {
    source                          = "../../modules/iam"
    name                            = "TEST-AIM"
    region                          = "us-east-1"
    environment                     = "PROD"

    aws_iam_role-principals         = [
        "ec2.amazonaws.com",
    ]
    aws_iam_policy-actions           = [
        "cloudwatch:GetMetricStatistics",
        "logs:DescribeLogStreams",
        "logs:GetLogEvents",
        "elasticache:Describe*",
        "rds:Describe*",
        "rds:ListTagsForResource",
        "ec2:DescribeAccountAttributes",
        "ec2:DescribeAvailabilityZones",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeVpcs",
        "ec2:Owner",
    ]
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

    #Internet-GateWay
    enable_internet_gateway             = "true"
    #NAT
    enable_nat_gateway                  = "false"
    single_nat_gateway                  = "true"
    #VPN
    enable_vpn_gateway                  = "false"
    #DHCP
    enable_dhcp_options                 = "false"
    # EIP
    enable_eip                          = "false"
}
module "ec2" {
    source                              = "../../modules/ec2"
    name                                = "TEST-Machine"    
    region                              = "us-east-1"
    environment                         = "PROD"
    ec2_instance_type                   = "t2.micro"
    enable_associate_public_ip_address  = "true"
    disk_size                           = "8"
    tenancy                             = "${module.vpc.instance_tenancy}"
    iam_instance_profile                = "${module.iam.instance_profile_id}"
    subnet_id                           = "${element(module.vpc.vpc-publicsubnet-ids, 0)}"
    #subnet_id                           = "${element(module.vpc.vpc-privatesubnet-ids, 0)}"
    #subnet_id                           = ["${element(module.vpc.vpc-privatesubnet-ids)}"]
    vpc_security_group_ids              = ["${module.vpc.security_group_id}"]

    monitoring                          = "true"
}
