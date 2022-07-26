# Work with CONFIG via terraform

A terraform module for making CONFIG.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
  required_version = "~> 1.0"

  required_providers {
    aws = "~> 2.70"
  }
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

  enable_s3_bucket    = true
  s3_bucket_name      = "aws-config-bucket-dev"
  s3_bucket_acl       = "private"
  s3_bucket_cors_rule = []

  s3_bucket_versioning  = []
  enable_lifecycle_rule = true

  # Add policy to the bucket
  enable_s3_bucket_policy = false

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

}

module "config" {
  source = "../../modules/config"

  region      = "us-east-1"
  name        = "testme"
  environment = "dev"


  enable_config_delivery_channel         = true
  config_delivery_channel_name           = ""
  config_delivery_channel_s3_bucket_name = module.s3.s3_bucket_id

  enable_organizations_organization           = true
  enable_config_organization_managed_rule     = true
  config_organization_managed_rule_name       = ""
  config_organization_managed_rule_identifier = "IAM_PASSWORD_POLICY"

  enable_config_configuration_recorder          = true
  config_configuration_recorder_name            = ""
  config_configuration_recorder_role_arn        = "arn:aws:iam::167127734783:role/aws-service-role/organizations.amazonaws.com/AWSServiceRoleForOrganizations"
  config_configuration_recorder_recording_group = []

  enable_config_configuration_recorder_status     = true
  config_configuration_recorder_status_is_enabled = true

  enable_config_aggregate_authorization     = true
  config_aggregate_authorization_account_id = "167127734783"

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
- `region` - The region where to deploy this code (e.g. us-east-1). (`default = us-east-1`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value (`default = {}`)
- `enable_config_aggregate_authorization` - Enable config aggregate authorization usage (`default = False`)
- `config_aggregate_authorization_account_id` - (Required) Account ID (`default = ""`)
- `config_aggregate_authorization_name` - Set name for config aggregate authorization (`default = ""`)
- `enable_config_delivery_channel` - Enable config delivery channel usage (`default = False`)
- `config_delivery_channel_name` - (Optional) The name of the delivery channel. Defaults to default. Changing it recreates the resource. (`default = default`)
- `config_delivery_channel_s3_bucket_name` - (Required) The name of the S3 bucket used to store the configuration history. (`default = ""`)
- `config_delivery_channel_s3_key_prefix` - (Optional) The prefix for the specified S3 bucket. (`default = null`)
- `config_delivery_channel_sns_topic_arn` - (Optional) The ARN of the SNS topic that AWS Config delivers notifications to. (`default = null`)
- `config_delivery_channel_snapshot_delivery_properties` - (Optional) Options for how AWS Config delivers configuration snapshots. See below (`default = []`)
- `enable_organizations_organization` - Enable organizations organization usage (`default = False`)
- `organizations_organization_aws_service_access_principals` - Set aws_service_access_principals. (`default = ['config-multiaccountsetup.amazonaws.com']`)
- `organizations_organization_feature_set` - Set feature_set (`default = ALL`)
- `enable_config_organization_managed_rule` - Enable config org named rule usage (`default = False`)
- `config_organization_managed_rule_name` - The name of the rule (`default = ""`)
- `config_organization_managed_rule_identifier` - (Required) Identifier of an available AWS Config Managed Rule to call. For available values, see the List of AWS Config Managed Rules documentation (`default = IAM_PASSWORD_POLICY`)
- `config_organization_managed_rule_description` - (Optional) Description of the rule (`default = null`)
- `config_organization_managed_rule_excluded_accounts` - (Optional) List of AWS account identifiers to exclude from the rule (`default = null`)
- `config_organization_managed_rule_input_parameters` - (Optional) A string in JSON format that is passed to the AWS Config Rule Lambda Function (`default = null`)
- `config_organization_managed_rule_maximum_execution_frequency` - (Optional) The maximum frequency with which AWS Config runs evaluations for a rule, if the rule is triggered at a periodic frequency. Defaults to TwentyFour_Hours for periodic frequency triggered rules. Valid values: One_Hour, Three_Hours, Six_Hours, Twelve_Hours, or TwentyFour_Hours. (`default = null`)
- `config_organization_managed_rule_resource_id_scope` - (Optional) Identifier of the AWS resource to evaluate (`default = null`)
- `config_organization_managed_rule_resource_types_scope` - (Optional) List of types of AWS resources to evaluate (`default = null`)
- `config_organization_managed_rule_tag_key_scope` - (Optional, Required if tag_value_scope is configured) Tag key of AWS resources to evaluate (`default = null`)
- `config_organization_managed_rule_tag_value_scope` - (Optional) Tag value of AWS resources to evaluate (`default = null`)
- `config_organization_managed_rule_timeouts` - Set timeouts for config organization managed rule (`default = {}`)
- `enable_config_organization_custom_rule` - Enable config org custom rule usage (`default = False`)
- `config_organization_custom_rule_name` - The name of the rule (`default = ""`)
- `config_organization_custom_rule_lambda_function_arn` - (Required) Amazon Resource Name (ARN) of the rule Lambda Function (`default = ""`)
- `config_organization_custom_rule_trigger_types` - (Required) List of notification types that trigger AWS Config to run an evaluation for the rule. Valid values: ConfigurationItemChangeNotification, OversizedConfigurationItemChangeNotification, and ScheduledNotification (`default = ['ConfigurationItemChangeNotification']`)
- `config_organization_custom_rule_description` - (Optional) Description of the rule (`default = null`)
- `config_organization_custom_rule_excluded_accounts` - (Optional) List of AWS account identifiers to exclude from the rule (`default = null`)
- `config_organization_custom_rule_input_parameters` - (Optional) A string in JSON format that is passed to the AWS Config Rule Lambda Function (`default = null`)
- `config_organization_custom_rule_maximum_execution_frequency` - (Optional) The maximum frequency with which AWS Config runs evaluations for a rule, if the rule is triggered at a periodic frequency. Defaults to TwentyFour_Hours for periodic frequency triggered rules. Valid values: One_Hour, Three_Hours, Six_Hours, Twelve_Hours, or TwentyFour_Hours. (`default = null`)
- `config_organization_custom_rule_resource_id_scope` - (Optional) Identifier of the AWS resource to evaluate (`default = null`)
- `config_organization_custom_rule_resource_types_scope` - (Optional) List of types of AWS resources to evaluate (`default = null`)
- `config_organization_custom_rule_tag_key_scope` - (Optional, Required if tag_value_scope is configured) Tag key of AWS resources to evaluate (`default = null`)
- `config_organization_custom_rule_tag_value_scope` - (Optional) Tag value of AWS resources to evaluate (`default = null`)
- `config_organization_custom_rule_timeouts` - Set timeouts for config organization custom rule timeouts (`default = {}`)
- `enable_config_configuration_recorder` - Enable config configuration recoder usage (`default = False`)
- `config_configuration_recorder_name` - (Optional) The name of the recorder. Defaults to default. Changing it recreates the resource. (`default = default`)
- `config_configuration_recorder_role_arn` - (Required) Amazon Resource Name (ARN) of the IAM role. used to make read or write requests to the delivery channel and to describe the AWS resources associated with the account. See AWS Docs for more details. (`default = ""`)
- `config_configuration_recorder_recording_group` - (Optional) Recording group (`default = []`)
- `enable_config_configuration_recorder_status` - Enable config configuration recoder status usage (`default = False`)
- `config_configuration_recorder_status_name` - Set name for config configuration recorder status (`default = ""`)
- `config_configuration_recorder_status_is_enabled` - (Required) Whether the configuration recorder should be enabled or disabled. (`default = True`)
- `enable_config_configuration_aggregator` - Enable config configuration aggregator usage (`default = False`)
- `config_configuration_aggregator_name` - The name of the configuration aggregator. (`default = ""`)
- `config_configuration_aggregator_account_aggregation_source` -  (Optional) The account(s) to aggregate config data from (`default = []`)
- `config_configuration_aggregator_organization_aggregation_source` - (Optional) The organization to aggregate config data from (`default = []`)
- `enable_config_config_rule` - Enable config config rule usage (`default = False`)
- `config_config_rule_name` - The name of the rule (`default = ""`)
- `config_config_rule_description` - (Optional) Description of the rule (`default = ""`)
- `config_config_rule_input_parameters` - (Optional) A string in JSON format that is passed to the AWS Config rule Lambda function. (`default = null`)
- `config_config_rule_maximum_execution_frequency` - (Optional) The maximum frequency with which AWS Config runs evaluations for a rule. (`default = null`)
- `config_config_rule_source` - (Required) Source specifies the rule owner, the rule identifier, and the notifications that cause the function to evaluate your AWS resources (`default = []`)
- `config_config_rule_scope` - (Optional) Scope defines which resources can trigger an evaluation for the rule (`default = []`)

## Module Output Variables
----------------------
- `config_aggregate_authorization_arn` - The ARN of the authorization
- `config_delivery_channel_id` - The name of the delivery channel.
- `config_organization_managed_rule_arn` - Amazon Resource Name (ARN) of the rule
- `config_organization_custom_rule_arn` - Amazon Resource Name (ARN) of the rule
- `config_configuration_recorder_id` - Name of the recorder
- `config_configuration_aggregator_arn` - The ARN of the aggregator
- `config_config_rule_arn` - The ARN of the config rule
- `config_config_rule_id` - The ID of the config rule


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
