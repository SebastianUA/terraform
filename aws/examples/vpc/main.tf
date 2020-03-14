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

    tags                                = map("Env", "stage", "Orchestration", "Terraform")
}
