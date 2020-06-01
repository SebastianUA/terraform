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

module "glue" {
    source                                                  = "../../modules/glue"
    name                                                    = "TEST"
    environment                                             = "stage"

    # AWS Glue catalog DB
    enable_glue_catalog_database                            = true
    glue_catalog_database_name                              = "test-glue-db-test"
    glue_catalog_database_parameters                        = null

    # AWS Glue catalog table
    enable_glue_catalog_table                               = true
    glue_catalog_table_name                                 = "test-glue-table-test"
    glue_catalog_table_description                          = "Those resources are managed by Terraform. Created by Vitaliy Natarov"
    glue_catalog_table_table_type                           = "EXTERNAL_TABLE"
    glue_catalog_table_parameters                           = {
        "sizeKey"                           = 493378
        "tmp"                               = "none"
        "test"                              = "yes"
        "classification"                    = "csv"
    }


    storage_descriptor_location      = "s3://my-test-bucket/test/"
    storage_descriptor_input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    storage_descriptor_output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    storage_descriptor_columns       = [
        {
            columns_name    = "oid"
            columns_type    = "double"
            columns_comment = "oid"
        },
        {
            columns_name    = "oid2"
            columns_type    = "double"
            columns_comment = "oid2"
        },
        {
            columns_name    = "oid3"
            columns_type    = "double"
            columns_comment = "oid3"
        },

    ]


    storage_descriptor_ser_de_info  = []
    storage_descriptor_sort_columns = []
    storage_descriptor_skewed_info  = [
        {
            ser_de_info_name                  = "org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe"
            ser_de_info_serialization_library = "org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe"
            ser_de_info_parameters            = map("field.delim", ",")
        }

    ]


    # AWS Glue connection
    enable_glue_connection                                  = true
    glue_connection_connection_properties                   = {
        JDBC_CONNECTION_URL = "jdbc:mysql://aws_rds_cluster.example.endpoint/exampledatabase"
        PASSWORD            = "examplepassword"
        USERNAME            = "exampleusername"
    }

    enable_glue_crawler                                     = true
    glue_crawler_name                                       = ""
    glue_crawler_role                                       = "arn:aws:iam::167127734783:role/emr-service-role"

    #glue_crawler_catalog_target                            = map("database_name", "")
    #glue_crawler_schema_change_policy                      = map("delete_behavior", "LOG", "update_behavior", "LOG")

    enable_glue_security_configuration                      = true
    glue_security_configuration_name                        = ""


    enable_glue_trigger                                     = true
    glue_trigger_name                                       = ""


    tags = map(
        "Env", "stage",
        "Orchestration", "Terraform",
        "Createdby", "Vitalii Natarov"
    )
}
