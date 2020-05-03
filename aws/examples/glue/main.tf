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
    glue_catalog_database_name                              = ""
    glue_catalog_database_parameters                        = null

    # AWS Glue catalog table
    enable_glue_catalog_table                               = true
    glue_catalog_table_name                                 = ""
    glue_catalog_table_description                          = "Creates for test this resource by Terraform"
    glue_catalog_table_table_type                           = "EXTERNAL_TABLE"
    glue_catalog_table_parameters                           = {
        "EXTERNAL"                  = "TRUE"
        "parquet.compression"       = "SNAPPY"
    }

    glue_catalog_table_storage_descriptor_columns           = [{
        location                            = "s3://my-bucket/event-streams/my-stream"
        input_format                        = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat"
        output_format                       = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat"

        columns_name                        = "STR"
        columns_type                        = "string"
    }]

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


}
