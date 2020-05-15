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

module "cur" {
    source                                                  = "../../modules/cur"
    name                                                    = "TEST"
    environment                                             = "dev"

    enable_cur_report_definition                            = true
    cur_report_definition_report_name                       = ""
    cur_report_definition_time_unit                         = "HOURLY"
    cur_report_definition_format                            = "textORcsv"
    cur_report_definition_compression                       = "GZIP"
    cur_report_definition_additional_schema_elements        = ["RESOURCES"]
    cur_report_definition_additional_artifacts              = ["REDSHIFT", "QUICKSIGHT"]

    cur_report_definition_s3_bucket                         = "my-test-bucket"
    cur_report_definition_s3_region                         = "us-east-1"
    cur_report_definition_s3_prefix                         = null
}
