#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
    required_version = "~> 0.12.12"
}

provider "aws" {
    region  = "us-east-1"
    profile = "default"
}

module "iam_role" {
    source                                          = "../../modules/iam_role"
    name                                            = "TEST"
    environment                                     = "stage"

    # Using IAM role
    enable_iam_role                                 = true
    iam_role_name                                   = "tf-role-for-testing"
    iam_role_description                            = "It's just a simple IAM role to test TF module"
    # Inside additional_files directory I will add additional policies for assume_role_policy usage in the future....
    assume_role_policy                              = file("additional_files/iam/assume_role_policy_with_mfa.json")

    iam_role_force_detach_policies                  = true
    iam_role_path                                   = "/"
    iam_role_max_session_duration                   = 3600

    # Using IAM role policy
    enable_iam_role_policy                          = true
    iam_role_policy_name                            = "my-iam-role-policy-for-testing-terraform"
    iam_role_policy                                 = file("additional_files/iam/policy.json")

    # Using IAM role policy attachment
    enable_iam_role_policy_attachment               = false
    policy_arns                                     = ["test"]

    # Using IAM instance profile
    enable_iam_instance_profile                     = true
    iam_instance_profile_name                       = "tf-role-for-testing"

    tags                                            = map("Env", "stage", "Orchestration", "Terraform")
}

module "vpc" {
    source                              = "../../modules/vpc"
    name                                = "test"
    environment                         = "stage"

    # VPC
    enable_vpc                          = true
    vpc_name                            = ""

    instance_tenancy                    = "default"
    enable_dns_support                  = true
    enable_dns_hostnames                = true
    assign_generated_ipv6_cidr_block    = false
    # Dedicated tenancy VPCs cannot be enabled for ClassicLink by default
    enable_classiclink                  = false

    vpc_cidr                            = "172.32.0.0/16"
    private_subnet_cidrs                = ["172.32.64.0/20"]
    public_subnet_cidrs                 = ["172.32.80.0/20", "172.32.0.0/20"]
    #azs                                 = ["us-east-1a", "us-east-1b"]

    #Internet-GateWay
    enable_internet_gateway             = true
    # NAT GW
    enable_nat_gateway                  = false
    single_nat_gateway                  = true
    # VPN GW
    enable_vpn_gateway                  = false
    # DHCP
    enable_dhcp                         = true
    # EIP
    enable_eip                          = false

    tags                                = map("Env", "stage", "Orchestration", "Terraform")
}

module "eks" {
    source                              = "../../modules/eks"
    name                                = "TEST"
    environment                         = "NonProd"

    eks_cluster_name                    = ""
    eks_role_arn                        = module.iam_role.iam_role_arn
    # enebling aws eks logs
    eks_enabled_cluster_log_types       = ["api", "audit"]
    eks_version                         = null
    eks_vpc_config_subnet_ids           = module.vpc.private_subnets_ids
    # SG
    # eks_vpc_config_security_group_ids = []

    tags                                = map("Env", "NonProd", "Orchestration", "Terraform")
}
