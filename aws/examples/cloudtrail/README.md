# Work with AWS CloudTrail via terraform

A terraform module for making AWS CloudTrail.

## Usage
----------------------

Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
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
```

Module Input Variables
----------------------
- `name` - "Name to be used on all resources as prefix" (`default     = "TEST`).
- `environment` - "Environment for service" (`default     = "STAGE`).
- `orchestration` - "Type of orchestration" (`default     = "Terraform`).
- `createdby` - "Created by" (`default     = "Vitaliy Natarov`).    
- `enable_cloudtrail` - "Enable cloudtrail usage" (`default     = "false`).
- `cloudtrail_name` - "Specifies the name of the trail" (`default     = "").
- `s3_bucket_name` - "(Required) Specifies the name of the S3 bucket designated for publishing log files." (`default     = "`).
- `s3_key_prefix` - "(Optional) Specifies the S3 key prefix that follows the name of the bucket you have designated for log file delivery." (`default     = "prefix`).
- `cloud_watch_logs_role_arn` - "(Optional) Specifies the role for the CloudWatch Logs endpoint to assume to write to a user’s log group." (`default     = "`).
- `cloud_watch_logs_group_arn` - "(Optional) Specifies a log group name using an Amazon Resource Name (ARN), that represents the log group to which CloudTrail logs will be delivered." (`default     = "`).
- `enable_logging` - "(Optional) Enables logging for the trail. Defaults to true. Setting this to false will pause logging." (`default     = "true`).
- `include_global_service_events` - "(Optional) Specifies whether the trail is publishing events from global services such as IAM to the log files. Defaults to true." (`default     = "true`).
- `is_multi_region_trail` - "(Optional) Specifies whether the trail is created in the current region or in all regions. Defaults to false." (`default     = "false`).
- `is_organization_trail` - "(Optional) Specifies whether the trail is an AWS Organizations trail. Organization trails log events for the master account and all member accounts. Can only be created in the organization master account. Defaults to false." (`default     = "false`).
- `sns_topic_name` - "(Optional) Specifies the name of the Amazon SNS topic defined for notification of log file delivery." (`default     = "`).
- `enable_log_file_validation` - "(Optional) Specifies whether log file integrity validation is enabled. Defaults to false." (`default     = "false`).
- `kms_key_id` - "(Optional) Specifies the KMS key ARN to use to encrypt the logs delivered by CloudTrail." (`default     = "`).
- `enable_cloudtrail_event_selector` - "Enable cloudtrail with event_selector" (`default     = "false`).
- `event_selector_read_write_type` - "(Optional) - Specify if you want your trail to log read-only events, write-only events, or all. By default, the value is All. You can specify only the following value: 'ReadOnly', 'WriteOnly', 'All'. Defaults to All" (`default     = "All`).
- `event_selector_include_management_events` - "(Optional) - Specify if you want your event selector to include management events for your trail." (`default     = "true`).
- `event_selector_data_resource_type` - "(Required) - The resource type in which you want to log data events. You can specify only the follwing value: 'AWS::S3::Object', 'AWS::Lambda::Function'" (`default     = "`).
- `event_selector_data_resource_values` - "(Required) - A list of ARN for the specified S3 buckets and object prefixes" (`type        = "list (`default     = []`).


Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.
