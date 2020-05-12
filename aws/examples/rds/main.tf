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

module "rds" {
    source                                  = "../../modules/rds"
    name                                    = "Test"
    region                                  = "us-east-1"
    environment                             = "stage"

    enable_rds_cluster_parameter_group      = false
    rds_cluster_parameter_group_name        = "rds-cluster-parameter-group-name"
    rds_cluster_parameter_group_parameters  = [
        {
            name  = "character_set_server"
            value = "utf8"
        },
        {
            name  = "character_set_client"
            value = "utf8"
        },
    ]

    enable_db_subnet_group              = true
    db_subnet_group_name                = "db_parameter_group_name"
    db_subnet_group_subnet_ids          = ["subnet-01e1e21d1f1c0b1fa", "subnet-09d00c1d07ea7b939", "subnet-0503fc0754cf9460e"]

    ## For rds cluster
    enable_rds_cluster                  = true
    rds_cluster_cluster_identifier      = "rds-mysql"
    rds_cluster_engine                  = "aurora"
    rds_cluster_engine_version          = null #"5.7.12"

    rds_cluster_engine_mode             = "provisioned"

    enable_rds_cluster_instance         = true
    number_rds_cluster_instances        = 1
    rds_cluster_instance_instance_class = "db.t2.small"


    tags                                = map("Env", "stage", "Orchestration", "Terraform")

}
