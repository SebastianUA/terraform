#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.12.12"
}

provider "aws" {
    region                  = "us-east-1"
    shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "vpc" {
    source                              = "../../modules/vpc"
    name                                = "mytest"
    environment                         = "stage"

    # VPC
    enable_vpc                          = true
    vpc_name                            = ""

    instance_tenancy                    = "dedicated"
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
    #NAT
    #enable_nat_gateway                  = true
    single_nat_gateway                  = true
    #VPN
    enable_vpn_gateway                  = false
    #DHCP
    enable_dhcp                         = true
    # EIP
    enable_eip                          = false

    # VPC flow log
    enable_flow_log                     = false
    flow_log_name                       = ""
    flow_log_traffic_type               = "ALL"
    flow_log_iam_role_arn               = "arn:aws:iam::167127734783:role/vpc-flow-log"
    flow_log_log_destination            = "arn:aws:logs:us-east-1:167127734783:log-group:vpc-flow-log-test"

    # VPC network ACLs
    enable_network_acl                  = true
    network_acl_name                    = ""
    network_acl_subnet_ids              = []

    network_acl_ingress                 = [{
        from_port       = 0
        to_port         = 0
        rule_no         = 100
        action          = "allow"
        protocol        = -1
        cidr_block      = "0.0.0.0/0"
        ipv6_cidr_block = null
        icmp_type       = 0
        icmp_code       = 0
    }]

    network_acl_egress                  = [{
        from_port       = 0
        to_port         = 0
        rule_no         = 100
        action          = "allow"
        protocol        = -1
        cidr_block      = "0.0.0.0/0"
        ipv6_cidr_block = null
        icmp_type       = 0
        icmp_code       = 0
    }]

    tags                                = map("Env", "stage", "Orchestration", "Terraform")
}
