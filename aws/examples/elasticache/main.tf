#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.5.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "default"
}

module "elasticache_single_redis" {
  source = "../../modules/elasticache"

  name        = "single"
  environment = "stage"

  # elasticache security group
  enable_elasticache_security_group               = true
  elasticache_security_group_name                 = ""
  elasticache_security_group_security_group_names = []

  # elasticache subnet group
  enable_elasticache_subnet_group     = true
  elasticache_subnet_group_name       = ""
  elasticache_subnet_group_subnet_ids = []

  # elasticache parameter group
  enable_elasticache_parameter_group = false
  elasticache_parameter_group_name   = "param-group"
  elasticache_parameter_group_parameter = [
    {
      name  = "activerehashing"
      value = "yes"
    }
  ]


  # The single cluster
  enable_elasticache_cluster          = true
  elasticache_cluster_num_cache_nodes = 1
  elasticache_cluster_node_type       = "cache.m3.medium"

  elasticache_replication_group_cluster_mode = []

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}


module "elasticache_single_memcached" {
  source = "../../modules/elasticache"

  name        = "single"
  environment = "stage"

  # elasticache security group
  enable_elasticache_security_group               = false
  elasticache_security_group_name                 = ""
  elasticache_security_group_security_group_names = []

  # elasticache subnet group
  enable_elasticache_subnet_group     = false
  elasticache_subnet_group_name       = ""
  elasticache_subnet_group_subnet_ids = []

  # elasticache parameter group
  enable_elasticache_parameter_group    = false
  elasticache_parameter_group_name      = "param-group"
  elasticache_parameter_group_parameter = []

  # The single cluster
  enable_elasticache_cluster          = true
  elasticache_cluster_num_cache_nodes = 1
  default_engine                      = "memcached"
  elasticache_cluster_engine          = "memcached"
  elasticache_cluster_port            = 11211
  elasticache_cluster_node_type       = "cache.m3.medium"

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}
