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
    source                              = "../../modules/rds"
    name                                = "Test"
    region                              = "us-east-1"
    environment                         = "stage"

    enable_rds_cluster_parameter_group  = true
    rds_cluster_parameter_group_name    = "rds-cluster-parameter-group-name"
    parameter                           = [
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
    subnet_ids                          = ["subnet-8851dea6", "subnet-c3a5f589", "subnet-1d7df041"]

    ## For cluster
    enable_rds_cluster                  = true
    cluster_identifier                  = ""
    engine                              = "aurora-mysql"
    engine_version                      = "5.7.mysql_aurora.2.03.2"
    instance_class                      = "db.t2.small"

}
