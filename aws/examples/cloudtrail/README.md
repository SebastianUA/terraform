# Work with CLOUDTRAIL via terraform

A terraform module for making CLOUDTRAIL.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region                  = "us-east-1"
  profile                 = "default"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "s3" {
  source      = "../../modules/s3"
  name        = "TEST"
  environment = "dev"

  # AWS S3 bucket
  enable_s3_bucket = true
  s3_bucket_name   = "natarov-test-bucket1"
  s3_bucket_acl    = "private"

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}

module "cloudtrail" {
  source = "../../modules/cloudtrail"

  enable_cloudtrail = true
  cloudtrail_name   = "cloudtrail_name"

  cloudtrail_s3_bucket_name = module.s3.s3_bucket_id
  cloudtrail_s3_key_prefix  = "prefix"

  cloudtrail_include_global_service_events = false

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

}

# Logging All Lambda Function Invocations
module "cloudtrail_event_selector_lambda" {
  source = "../../modules/cloudtrail"

  enable_cloudtrail = true
  cloudtrail_name   = "cloudtrail_event_selector_lambda"

  cloudtrail_s3_bucket_name = module.s3.s3_bucket_id
  cloudtrail_s3_key_prefix  = "prefix"

  cloudtrail_include_global_service_events = false

  cloudtrail_event_selector = [{
    read_write_type           = "All"
    include_management_events = true

    data_resource = {
      type   = "AWS::Lambda::Function"
      values = ["arn:aws:lambda"]
    }
  }]

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

}

# Logging All S3 Bucket Object Events
module "cloudtrail_event_selector_s3" {
  source = "../../modules/cloudtrail"


  enable_cloudtrail = true
  cloudtrail_name   = "cloudtrail_event_selector_s3"

  cloudtrail_s3_bucket_name = module.s3.s3_bucket_id
  cloudtrail_s3_key_prefix  = "prefix"

  cloudtrail_include_global_service_events = false

  cloudtrail_event_selector = [{
    read_write_type           = "All"
    include_management_events = true

    data_resource = {
      type   = "AWS::S3::Object"
      values = ["arn:aws:s3:::"]
    }
  }]

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

}
```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value (`default = {}`)
- `enable_cloudtrail` - Enable cloudtrail usage (`default = False`)
- `cloudtrail_name` - Specifies the name of the trail. (`default = ""`)
- `cloudtrail_s3_bucket_name` - (Required) Specifies the name of the S3 bucket designated for publishing log files. (`default = ""`)
- `cloudtrail_s3_key_prefix` - (Optional) Specifies the S3 key prefix that follows the name of the bucket you have designated for log file delivery. (`default = ""`)
- `cloudtrail_cloud_watch_logs_role_arn` - (Optional) Specifies the role for the CloudWatch Logs endpoint to assume to write to a user’s log group. (`default = ""`)
- `cloudtrail_cloud_watch_logs_group_arn` - (Optional) Specifies a log group name using an Amazon Resource Name (ARN), that represents the log group to which CloudTrail logs will be delivered. (`default = ""`)
- `cloudtrail_enable_logging` - (Optional) Enables logging for the trail. Defaults to true. Setting this to false will pause logging. (`default = True`)
- `cloudtrail_include_global_service_events` - (Optional) Specifies whether the trail is publishing events from global services such as IAM to the log files. Defaults to true. (`default = True`)
- `cloudtrail_is_multi_region_trail` - (Optional) Specifies whether the trail is created in the current region or in all regions. Defaults to false. (`default = False`)
- `cloudtrail_is_organization_trail` - (Optional) Specifies whether the trail is an AWS Organizations trail. Organization trails log events for the master account and all member accounts. Can only be created in the organization master account. Defaults to false. (`default = False`)
- `cloudtrail_sns_topic_name` - (Optional) Specifies the name of the Amazon SNS topic defined for notification of log file delivery. (`default = ""`)
- `cloudtrail_enable_log_file_validation` - (Optional) Specifies whether log file integrity validation is enabled. Defaults to false. (`default = False`)
- `cloudtrail_kms_key_id` - (Optional) Specifies the KMS key ARN to use to encrypt the logs delivered by CloudTrail. (`default = ""`)
- `cloudtrail_event_selector` - (Optional) Set cloudtrail event selector (`default = []`)

## Module Output Variables
----------------------
- `cloudtrail_id` - The name of the trail.
- `cloudtrail_arn` - The region in which the trail was created.
- `cloudtrail_home_region` - The region in which the trail was created.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
