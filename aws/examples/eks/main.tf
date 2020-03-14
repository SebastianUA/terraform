#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.12.2"
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
        "eks.amazonaws.com",
    ]
    aws_iam_policy-actions           = [
        "cloudwatch:GetMetricStatistics",
        "logs:DescribeLogStreams",
        "logs:GetLogEvents",
        "rds:Describe*",
        "rds:ListTagsForResource",
        "eks:*"
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
module "eks" {
    source                              = "../../modules/eks"
    name                                = "TEST-eks"
    environment                         = "NonProd"

    eks_cluster_name                    = ""
    eks_role_arn                        = "${element(module.iam.iam_arn, 0)}" # <---- need verify!
    # enebling aws eks logs
    # eks_enabled_cluster_log_types       = ["api", "audit"]
    eks_version                         ""
    eks_vpc_config_subnet_ids           = ["${element(module.vpc.vpc-privatesubnet-ids)}"]
    # eks_vpc_config_subnet_ids           = ["${element(module.vpc.vpc-publicsubnet-ids, 0)}"]
    # eks_vpc_config_subnet_ids           = ["${element(module.vpc.vpc-privatesubnet-ids, 0)}"]
    # SG
    # eks_vpc_config_security_group_ids = []



}
