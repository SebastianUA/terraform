#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
  profile                 = "default"
}

module "elasticache_single_redis" {
  source      = "../../modules/elasticache"
  name        = "single"
  environment = "stage"

  enable_elasticache_security_group = false
  elasticache_security_group_name   = ""
  security_group_names              = []
  enable_elasticache_subnet_group   = false
  elasticache_subnet_group_name     = ""
  subnet_ids                        = []

  #
  enable_elasticache_parameter_group = false
  parameter = [
    {
      name  = "activerehashing"
      value = "yes"
    },
  ]
  # Or, use already created parameter_group
  #parameter_group_name                    = {
  #        memcached   = "default.memcached1.4",
  #        redis       = "default.redis4.0"
  #    }
  engine = "redis"

  # The single cluster
  enable_elasticache_cluster = true
  num_cache_nodes            = 1
  node_type                  = "cache.m3.medium"

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}

module "elasticache_single_memcached" {
  source      = "../../modules/elasticache"
  name        = "single"
  environment = "stage"

  enable_elasticache_security_group = false
  elasticache_security_group_name   = ""
  security_group_names              = []
  enable_elasticache_subnet_group   = false
  elasticache_subnet_group_name     = ""
  subnet_ids                        = []

  #
  enable_elasticache_parameter_group = false
  parameter = [
    {
      name  = "disable_flush_all"
      value = 0
    },
    {
      name  = "idle_timeout"
      value = 0
    },
  ]
  engine = "memcached"

  # The single cluster
  enable_elasticache_cluster = true
  num_cache_nodes            = 1
  node_type                  = "cache.m3.medium"

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}
