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


module "rds_cluster" {
  source = "../../modules/rds"

  name        = "Test"
  region      = "us-east-1"
  environment = "stage"

  enable_rds_cluster_parameter_group = false
  rds_cluster_parameter_group_name   = "rds-cluster-parameter-group-name"
  rds_cluster_parameter_group_parameters = [
    {
      name  = "character_set_server"
      value = "utf8"
    },
    {
      name  = "character_set_client"
      value = "utf8"
    }
  ]

  enable_db_subnet_group     = true
  db_subnet_group_name       = "db_parameter_group_name"
  db_subnet_group_subnet_ids = ["subnet-01e1e21d1f1c0b1fa", "subnet-09d00c1d07ea7b939", "subnet-0503fc0754cf9460e"]

  ## For rds cluster
  enable_rds_cluster             = true
  rds_cluster_cluster_identifier = "rds-mysql"
  rds_cluster_engine             = "aurora"
  rds_cluster_engine_version     = null #"5.7.12"

  rds_cluster_engine_mode = "provisioned"

  enable_rds_cluster_instance         = true
  number_rds_cluster_instances        = 1
  rds_cluster_instance_engine         = "aurora"
  rds_cluster_instance_engine_version = null #"5.7.12" 
  rds_cluster_instance_instance_class = "db.t2.small"


  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

}

# RDS cluster (DB instance - Oracle)
module "db_instance-rds-oracle" {
  source      = "../../modules/rds"
  name        = "rds-oracle"
  environment = "stage"
  region      = "us-east-1"

  # Enable subnet usage
  enable_db_subnet_group     = true
  db_subnet_group_name       = "test-db-instance-rds-oracle-db-subnet-group"
  db_subnet_group_subnet_ids = ["sub-fs432fd", "sub-432dfcxr"]

  # Enable db parameter group
  enable_db_parameter_group     = false
  db_parameter_group_name       = "test-db-instance-rds-oracle-db-param-group"
  db_parameter_group_parameters = []
  db_parameter_group_family     = ""

  # Enable db option group
  enable_db_option_group               = false
  db_option_group_name                 = "test-db-instance-rds-oracle-db-group-name"
  db_option_group_engine_name          = "oracle-ee"
  db_option_group_major_engine_version = "12.1"
  db_option_group_options              = []

  db_instance_multi_az          = false
  db_instance_availability_zone = null

  db_instance_allocated_storage     = 50
  db_instance_max_allocated_storage = null
  db_instance_storage_type          = null #"gp2"
  db_instance_iops                  = null

  db_instance_storage_encrypted = false
  db_instance_kms_key_id        = null


  # Enable db instance
  enable_db_instance     = true
  number_of_instances    = 1
  db_instance_identifier = "test-db-instance-rds-oracle"
  db_instance_engine     = "oracle-se2"
  #db_instance_engine_version                = "12.1"
  db_instance_license_model                = "license-included"
  db_instance_instance_class               = "db.t3.small"
  db_instance_vpc_security_group_ids       = []
  db_instance_performance_insights_enabled = true
  db_instance_skip_final_snapshot          = true


  db_instance_db_name     = "testdb"
  db_instance_db_username = "root"
  db_instance_db_password = "ImPassWorD2020"



  # Enable db instance role association
  enable_db_instance_role_association       = false
  db_instance_role_association_feature_name = ""
  db_instance_role_association_role_arn     = ""

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}
