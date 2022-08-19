# Work with EVENT_BRIDGE via terraform

A terraform module for making EVENT_BRIDGE.


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
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "event_bridge" {
  source      = "../../modules/event_bridge"
  name        = "TEST"
  environment = "stage"
}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - Add additional tags (`default = {}`)
- `enable_cw_metric_alarm` - Enable cw_metric_alarm usage (`default = False`)
- `alarm_name` - The descriptive name for the alarm. This name must be unique within the user's AWS account (`default = ""`)
- `comparison_operator` - The arithmetic operation to use when comparing the specified Statistic and Threshold. The specified Statistic value is used as the first operand. Either of the following is supported: GreaterThanOrEqualToThreshold, GreaterThanThreshold, LessThanThreshold, LessThanOrEqualToThreshold. (`default = GreaterThanOrEqualToThreshold`)
- `evaluation_periods` - The number of periods over which data is compared to the specified threshold. (`default = 2`)
- `metric_name` - The name for the alarm's associated metric (ex: CPUUtilization) (`default = null`)
- `namespace` - The namespace for the alarm's associated metric (ex: AWS/EC2) (`default = null`)
- `period` - The period in seconds over which the specified statistic is applied. (`default = null`)
- `statistic` - The statistic to apply to the alarm's associated metric. Either of the following is supported: SampleCount, Average, Sum, Minimum, Maximum (`default = null`)
- `threshold` - The value against which the specified statistic is compared (`default = 80`)
- `unit` - (Optional) The unit for the alarm's associated metric. (`default = null`)
- `metric_query` - (Optional) Enables you to create an alarm based on a metric math expression. You may specify at most 20. (`default = []`)
- `actions_enabled` - Indicates whether or not actions should be executed during any changes to the alarm's state. Defaults to true. (`default = True`)
- `alarm_actions` - The list of actions to execute when this alarm transitions into an ALARM state from any other state. Each action is specified as an Amazon Resource Number (ARN). (`default = []`)
- `alarm_description` - The description for the alarm. (`default = null`)
- `datapoints_to_alarm` - The number of datapoints that must be breaching to trigger the alarm. (`default = null`)
- `dimensions` - (Optional) The dimensions for the alarm's associated metric. For the list of available dimensions see the AWS documentation (`default = null`)
- `insufficient_data_actions` - The list of actions to execute when this alarm transitions into an INSUFFICIENT_DATA state from any other state. Each action is specified as an Amazon Resource Number (ARN). (`default = []`)
- `ok_actions` - The list of actions to execute when this alarm transitions into an OK state from any other state. Each action is specified as an Amazon Resource Number (ARN). (`default = []`)
- `extended_statistic` - The percentile statistic for the metric associated with the alarm. Specify a value between p0.0 and p100. (`default = null`)
- `treat_missing_data` - Sets how this alarm is to handle missing data points. The following values are supported: missing, ignore, breaching and notBreaching. Defaults to missing. (`default = missing`)
- `evaluate_low_sample_count_percentiles` - Used only for alarms based on percentiles. If you specify ignore, the alarm state will not change during periods with too few data points to be statistically significant. If you specify evaluate or omit this parameter, the alarm will always be evaluated and possibly change state no matter how many data points are available. The following values are supported: ignore, and evaluate. (`default = null`)
- `enable_cw_event_permission` - Enable cw_event_permission usage (`default = False`)
- `cw_event_permission_principal` - The 12-digit AWS account ID that you are permitting to put events to your default event bus. Specify * to permit any account to put events to your default event bus. (`default = ""`)
- `cw_event_permission_statement_id` - An identifier string for the external account that you are granting permissions to. (`default = DevAccountAccess`)
- `cw_event_permission_action` - The action that you are enabling the other account to perform. Defaults to events:PutEvents. (`default = events:PutEvents`)
- `is_enabled_for_event_rule` - Whether the rule should be enabled (defaults to true). (`default = True`)
- `cw_event_rule_event_pattern` - description (`default = ""`)
- `enable_cw_event_rule` - Enable cw_event_rule usage (`default = False`)
- `enbale_cw_event_target` - Enable enbale_cw_event_target usage (`default = False`)
- `cw_event_target_arn` - The Amazon Resource Name (ARN) of the rule. (`default = ""`)
- `cw_event_rule_name` - description (`default = ""`)
- `cw_event_rule_description` - description (`default = ""`)
- `cw_event_target_target_id` - target ID (`default = SendToSNS`)
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
- `cloudwatch_log_stream_name` - The name of the log stream. Must not be longer than 512 characters and must not contain : (`default = ""`)
- `enable_cw_dashboard` - Enable cw_dashboard (`default = False`)
- `cw_dashboard_name` - The name of the dashboard. (`default = ""`)
- `cw_dashboard_body` - description (`default = ""`)

## Module Output Variables
----------------------
- `directory_service_directory_id` - The directory identifier.
- `directory_service_directory_access_url` - The access URL for the directory, such as http://alias.awsapps.com.
- `directory_service_directory_dns_ip_addresses` - A list of IP addresses of the DNS servers for the directory or connector.
- `directory_service_directory_security_group_id` - The ID of the security group created by the directory.
- `directory_service_directory_connect_settings` - connect_settings: The IP addresses of the AD Connector servers.
- `directory_service_log_subscription_id` - The directory identifier for log subscription.
- `directory_service_conditional_forwarder_id` - The directory identifier for conditional forwarder


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
