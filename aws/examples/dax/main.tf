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

module "dax" {
    source                          = "../../modules/dax"
    name                            = "TEST"
    environment                     = "stage"

    # DAX cluster
    enable_dax_cluster              = true
    dax_cluster_name                = "test-dax-cluster"
    dax_cluster_iam_role_arn        = "arn:aws:iam::167127734783:role/admin-role"
    dax_cluster_node_type           = "dax.r4.large"
    dax_cluster_replication_factor  = 1

    # DAX parameter group
    enable_dax_parameter_group      = true
    dax_parameter_group_name        = "test-dax-param-group"
    dax_parameter_group_parameters  = [
        {
            name    = "query-ttl-millis"
            value   = 100000
        },
        {
            name    = "record-ttl-millis"
            value   = 100000
        }
    ]

    # DAX subnet group
    enable_dax_subnet_group         = false
    dax_subnet_group_name           = "test-dax-subnet-group"
    dax_subnet_group_subnet_ids     = []

    tags                            = map("Env", "stage", "Orchestration", "Terraform")
}
