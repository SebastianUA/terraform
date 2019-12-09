#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.12.12"
}

provider "aws" {
    region                  = "us-east-1"
    shared_credentials_file = "${pathexpand("~/.aws/credentials")}"
    profile                 = "default"
}

module "elasticache" {
    source                          = "../../modules/elasticache"
    name                            = "TEST"
    region                          = "us-east-1"
    environment                     = "PROD"
    
    elasticache_security_group      = false
    security_group_names            = []
    enable_elasticache_subnet_group = false
    subnet_ids                      = []
        
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
