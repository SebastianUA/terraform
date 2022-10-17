# Work with CLOUDWATCH_LOGS via terraform

A terraform module for making CLOUDWATCH_LOGS.


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
  region  = "us-east-1"
  profile = "default"
}

module "cloudwatch_logs" {
  source      = "../../modules/cloudwatch_logs"
  name        = ""
  environment = "staging"

  # CloudWatch LOG group
  enable_cw_log_group            = true
  cw_log_group_name              = "LogGroup"
  cw_log_group_retention_in_days = 30


  # CloudWatch LOG metric filter
  enable_cw_log_metric_filter  = true
  cw_log_metric_filter_name    = "log-filter"
  cw_log_metric_filter_pattern = ""
  cw_log_metric_filter_metric_transformation = [
    {
      name      = "EventCount"
      namespace = "YourNamespace"
      value     = "1"
    }
  ]

  tags = tomap({
    "Environment" = "dev",
    "Createdby"   = "Vitaliy Natarov"
  })

}
```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - Add additional tags (`default = {}`)
- `enable_cw_log_group` - Enable cw_log_group usage (`default = False`)
- `enable_cw_log_stream` - Enable cw_log_stream usage (`default = False`)
- `enable_cw_log_metric_filter` - Enable cw_log_metric_filter usage (`default = False`)
- `cw_log_group` - Enable cw_log_group usage (`default = False`)
- `cw_log_group_name` - The name of the log group. If omitted, Terraform will assign a random, unique name. (`default = ""`)
- `cw_log_group_retention_in_days` - Specifies the number of days you want to retain log events in the specified log group. (`default = 0`)
- `cw_log_group_kms_key_id` - The ARN of the KMS Key to use when encrypting log data. Please note, after the AWS KMS CMK is disassociated from the log group, AWS CloudWatch Logs stops encrypting newly ingested data for the log group. All previously ingested data remains encrypted, and AWS CloudWatch Logs requires permissions for the CMK whenever the encrypted data is requested. (`default = ""`)
- `cw_log_metric_filter_name` - A name for the metric filter. (`default = metric-filter`)
- `cw_log_metric_filter_pattern` - A valid CloudWatch Logs filter pattern for extracting metric data out of ingested log events. (`default = ""`)
- `cw_log_metric_filter_metric_transformation` - (Required) A block defining collection of information needed to define how metric data gets emitted. (`default = []`)
- `cloudwatch_log_stream_names` - The names of the log stream. Must not be longer than 512 characters and must not contain : (`default = []`)
- `enable_cw_dashboard` - Enable cw_dashboard (`default = False`)
- `cw_dashboard_name` - The name of the dashboard. (`default = ""`)
- `cw_dashboard_body` - description (`default = ""`)
- `enable_cw_log_subscription_filter` - Enable cw_log subscription filter usage (`default = False`)
- `cw_log_subscription_filter_name` - A name for the subscription filter (`default = ""`)
- `cw_log_subscription_filter_destination_arn` - (Required) The ARN of the destination to deliver matching log events to. Kinesis stream or Lambda function ARN. (`default = null`)
- `cw_log_subscription_filter_filter_pattern` - (Required) A valid CloudWatch Logs filter pattern for subscribing to a filtered stream of log events. Use empty string '' to match everything. For more information, see the Amazon CloudWatch Logs User Guide. (`default = null`)
- `cw_log_subscription_filter_log_group_name` - Required) The name of the log group to associate the subscription filter with (`default = null`)
- `cw_log_subscription_filter_role_arn` - (Optional) The ARN of an IAM role that grants Amazon CloudWatch Logs permissions to deliver ingested log events to the destination. If you use Lambda as a destination, you should skip this argument and use aws_lambda_permission resource for granting access from CloudWatch logs to the destination Lambda function. (`default = null`)
- `cw_log_subscription_filter_distribution` - (Optional) The method used to distribute log data to the destination. By default log data is grouped by log stream, but the grouping can be set to random for a more even distribution. This property is only applicable when the destination is an Amazon Kinesis stream. Valid values are 'Random' and 'ByLogStream'. (`default = null`)

## Module Output Variables
----------------------
- `cw_log_group_id` - The ID specifying the log group
- `cw_log_group_name` - The name specifying the log group
- `cw_log_group_arn` - The Amazon Resource Name (ARN) specifying the log group. Any :* suffix added by the API, denoting all CloudWatch Log Streams under the CloudWatch Log Group, is removed for greater compatibility with other AWS services that do not accept the suffix.
- `cw_log_stream_arns` - The Amazon Resource Name (ARN) specifying the log stream.
- `cw_log_stream_names` - The name specifying the log stream.
- `cw_log_stream_ids` - The ID specifying the log stream.
- `cw_log_metric_filter_id` - The name of the metric filter.
- `cw_log_subscription_filterid` - The name of the log subscription filter.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
