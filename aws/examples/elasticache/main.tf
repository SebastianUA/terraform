#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "> 0.9.0"
}
provider "aws" {
    region                  = "us-east-1"
    shared_credentials_file = "${pathexpand("~/.aws/credentials")}"
    profile                 = "default"
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
    public_subnet_cidrs                 = ["172.31.80.0/20"]
    availability_zones                  = ["us-east-1a", "us-east-1b"]
    allowed_ports                       = ["6379", "11211"]

    allow_cidrs_for_allowed_ports       = [{
        "6379"      = ["0.0.0.0/0"]
        "11211"     = ["0.0.0.0/0"]
    }]

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
module "elasticache" {
    source                          = "../../modules/elasticache"
    name                            = "TEST"
    region                          = "us-east-1"
    environment                     = "PROD"
    
    # NOTE: ElastiCache Subnet Groups are only for use when working with an ElastiCache cluster inside of a VPC. If you are on EC2 Classic, see the ElastiCache Security Group resource.
    # NOTE: ElastiCache Security Groups are for use only when working with an ElastiCache cluster outside of a VPC. If you are using a VPC, see the ElastiCache Subnet Group resource.
    # I HAVE GOT ISSUE WHEN USED "ElastiCache Security Groups". SO I PREFERED ElastiCache Subnet Groups
    #aws_elasticache_security_group.elasticache_sg: Error creating CacheSecurityGroup: InvalidParameterValue: Use of cache security groups is not permitted in this API version for your account. 
    security_group_names    = []
    subnet_ids              = ["${module.vpc.vpc-privatesubnet-ids}", "${module.vpc.vpc-publicsubnet-ids}"]
        
    create_custom_elasticache_parameter_group   = true
    parameters_for_parameter_group              = [
    {
        name  = "activerehashing"
        value = "yes"
    },
    {
        name  = "min-slaves-to-write"
        value = "2"
    },
    ]
    engine                                      = "redis" #"memcached"

    # Not single cluster
    #create_single_cluster   = false
    #num_cache_nodes         = 2
    #number_cluster_replicas = 1
    #node_type               = "cache.m3.medium"    

    # cluster with 2 nodes and 2 shards 
    create_single_cluster   = false
    number_cluster_replicas = 2
    num_cache_nodes         = 2
    node_type               = "cache.m3.medium"
    parameter_group_name    = [{
        redis   = "default.redis3.2.cluster.on"
    }]
    
}
