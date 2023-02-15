#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}


module "rds_proxy" {
  source = "../../modules/rds_proxy"

  name        = "Test"
  environment = "stage"

  // db proxy
  enable_db_proxy         = true
  db_proxy_name           = ""
  db_proxy_engine_family  = ""
  db_proxy_role_arn       = ""
  db_proxy_vpc_subnet_ids = []
  db_proxy_auth = [
    {
      description = null
      username    = null
      auth_scheme = null
      iam_auth    = null
      secret_arn  = null
    }
  ]

  // db proxy default target group
  enable_db_proxy_default_target_group = true
  db_proxy_default_target_group_connection_pool_config = {
    connection_borrow_timeout    = null
    init_query                   = null
    max_connections_percent      = null
    max_idle_connections_percent = null
    session_pinning_filters      = null
  }

  // db proxy target
  enable_db_proxy_target                 = true
  db_proxy_target_db_instance_identifier = null
  db_proxy_target_db_cluster_identifier  = null

  // db proxy endpoint
  enable_db_proxy_endpoint                 = true
  db_proxy_endpoint_db_proxy_endpoint_name = ""
  db_proxy_endpoint_vpc_subnet_ids         = []
  db_proxy_endpoint_vpc_security_group_ids = []
  db_proxy_endpoint_target_role            = null

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}