#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
    required_version = "~>0.12.2"
}

provider "aws" {
    region                  = "us-east-1"
    profile                 = "default"
    shared_credentials_file = "${pathexpand("~/.aws/credentials")}"
}

module "cloudtrail" {
    source                      	= "../../modules/cloudtrail"
    enable_cloudtrail				= "true"
    cloudtrail_name					= "cloudtrail_name"

    s3_bucket_name					= "bucket_name_here"
    s3_key_prefix					= "prefix"

    include_global_service_events	= "false"
                        
}

# Logging All Lambda Function Invocations
module "cloudtrail_event_selector" {
    source                      				= "../../modules/cloudtrail"
    enable_cloudtrail							= "true"
    enable_cloudtrail_event_selector			= "true"
    cloudtrail_name								= "cloudtrail_event_selector_lambda"

    s3_bucket_name								= "bucket_name_here"
    s3_key_prefix								= "prefix"

    include_global_service_events				= "false"

    event_selector_read_write_type				= "All"
    event_selector_include_management_events	= "true"

    event_selector_data_resource_type			= "AWS::Lambda::Function"
    event_selector_data_resource_values			= ["arn:aws:lambda"]
                        
}

# Logging All S3 Bucket Object Events
module "cloudtrail_event_selector" {
    source                      				= "../../modules/cloudtrail"
    enable_cloudtrail							= "true"
    enable_cloudtrail_event_selector			= "true"
    cloudtrail_name								= "cloudtrail_event_selector_s3"

    s3_bucket_name								= "bucket_name_here"
    s3_key_prefix								= "prefix"

    include_global_service_events				= "false"

    event_selector_read_write_type				= "All"
    event_selector_include_management_events	= "true"

    event_selector_data_resource_type			= "AWS::S3::Object"
    event_selector_data_resource_values			= ["arn:aws:s3:::"]
                        
}