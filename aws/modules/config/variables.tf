#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST"
}

variable "region" {
  description = "The region where to deploy this code (e.g. us-east-1)."
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment for service"
  default     = "STAGE"
}

variable "tags" {
  description = "A list of tag blocks. Each element should have keys named key, value"
  default     = {}
}

#---------------------------------------------------
# AWS config aggregate authorization
#---------------------------------------------------
variable "enable_config_aggregate_authorization" {
  description = "Enable config aggregate authorization usage"
  default     = false
}

variable "config_aggregate_authorization_account_id" {
  description = "(Required) Account ID"
  default     = ""
}

variable "config_aggregate_authorization_name" {
  description = "Set name for config aggregate authorization"
  default     = ""
}

#---------------------------------------------------
# AWS config delivery channel
#---------------------------------------------------
variable "enable_config_delivery_channel" {
  description = "Enable config delivery channel usage"
  default     = false
}

variable "config_delivery_channel_name" {
  description = "(Optional) The name of the delivery channel. Defaults to default. Changing it recreates the resource."
  default     = "default"
}

variable "config_delivery_channel_s3_bucket_name" {
  description = "(Required) The name of the S3 bucket used to store the configuration history."
  default     = ""
}

variable "config_delivery_channel_s3_key_prefix" {
  description = "(Optional) The prefix for the specified S3 bucket."
  default     = null
}

variable "config_delivery_channel_sns_topic_arn" {
  description = "(Optional) The ARN of the SNS topic that AWS Config delivers notifications to."
  default     = null
}

variable "config_delivery_channel_snapshot_delivery_properties" {
  description = "(Optional) Options for how AWS Config delivers configuration snapshots. See below"
  default     = []
}


#---------------------------------------------------
# AWS config organization
#---------------------------------------------------
variable "enable_organizations_organization" {
  description = "Enable organizations organization usage"
  default     = false
}

variable "organizations_organization_aws_service_access_principals" {
  description = "Set aws_service_access_principals."
  default     = ["config-multiaccountsetup.amazonaws.com"]
}

variable "organizations_organization_feature_set" {
  description = "Set feature_set"
  default     = "ALL"
}

#---------------------------------------------------
# AWS config organization managed rule
#---------------------------------------------------
variable "enable_config_organization_managed_rule" {
  description = "Enable config org named rule usage"
  default     = false
}

variable "config_organization_managed_rule_name" {
  description = "The name of the rule"
  default     = ""
}

variable "config_organization_managed_rule_identifier" {
  description = "(Required) Identifier of an available AWS Config Managed Rule to call. For available values, see the List of AWS Config Managed Rules documentation"
  default     = "IAM_PASSWORD_POLICY"
}

variable "config_organization_managed_rule_description" {
  description = "(Optional) Description of the rule"
  default     = null
}

variable "config_organization_managed_rule_excluded_accounts" {
  description = "(Optional) List of AWS account identifiers to exclude from the rule"
  default     = null
}

variable "config_organization_managed_rule_input_parameters" {
  description = "(Optional) A string in JSON format that is passed to the AWS Config Rule Lambda Function"
  default     = null
}

variable "config_organization_managed_rule_maximum_execution_frequency" {
  description = "(Optional) The maximum frequency with which AWS Config runs evaluations for a rule, if the rule is triggered at a periodic frequency. Defaults to TwentyFour_Hours for periodic frequency triggered rules. Valid values: One_Hour, Three_Hours, Six_Hours, Twelve_Hours, or TwentyFour_Hours."
  default     = null
}

variable "config_organization_managed_rule_resource_id_scope" {
  description = "(Optional) Identifier of the AWS resource to evaluate"
  default     = null
}

variable "config_organization_managed_rule_resource_types_scope" {
  description = "(Optional) List of types of AWS resources to evaluate"
  default     = null
}

variable "config_organization_managed_rule_tag_key_scope" {
  description = "(Optional, Required if tag_value_scope is configured) Tag key of AWS resources to evaluate"
  default     = null
}

variable "config_organization_managed_rule_tag_value_scope" {
  description = "(Optional) Tag value of AWS resources to evaluate"
  default     = null
}

variable "config_organization_managed_rule_timeouts" {
  description = "Set timeouts for config organization managed rule"
  default     = {}
}

#---------------------------------------------------
# AWS config organization custom rule
#---------------------------------------------------
variable "enable_config_organization_custom_rule" {
  description = "Enable config org custom rule usage"
  default     = false
}

variable "config_organization_custom_rule_name" {
  description = "The name of the rule"
  default     = ""
}

variable "config_organization_custom_rule_lambda_function_arn" {
  description = "(Required) Amazon Resource Name (ARN) of the rule Lambda Function"
  default     = ""
}

variable "config_organization_custom_rule_trigger_types" {
  description = "(Required) List of notification types that trigger AWS Config to run an evaluation for the rule. Valid values: ConfigurationItemChangeNotification, OversizedConfigurationItemChangeNotification, and ScheduledNotification"
  default     = ["ConfigurationItemChangeNotification"]
}

variable "config_organization_custom_rule_description" {
  description = "(Optional) Description of the rule"
  default     = null
}

variable "config_organization_custom_rule_excluded_accounts" {
  description = "(Optional) List of AWS account identifiers to exclude from the rule"
  default     = null
}

variable "config_organization_custom_rule_input_parameters" {
  description = "(Optional) A string in JSON format that is passed to the AWS Config Rule Lambda Function"
  default     = null
}

variable "config_organization_custom_rule_maximum_execution_frequency" {
  description = "(Optional) The maximum frequency with which AWS Config runs evaluations for a rule, if the rule is triggered at a periodic frequency. Defaults to TwentyFour_Hours for periodic frequency triggered rules. Valid values: One_Hour, Three_Hours, Six_Hours, Twelve_Hours, or TwentyFour_Hours."
  default     = null
}

variable "config_organization_custom_rule_resource_id_scope" {
  description = "(Optional) Identifier of the AWS resource to evaluate"
  default     = null
}

variable "config_organization_custom_rule_resource_types_scope" {
  description = "(Optional) List of types of AWS resources to evaluate"
  default     = null
}

variable "config_organization_custom_rule_tag_key_scope" {
  description = "(Optional, Required if tag_value_scope is configured) Tag key of AWS resources to evaluate"
  default     = null
}

variable "config_organization_custom_rule_tag_value_scope" {
  description = "(Optional) Tag value of AWS resources to evaluate"
  default     = null
}

variable "config_organization_custom_rule_timeouts" {
  description = "Set timeouts for config organization custom rule timeouts"
  default     = {}
}

#---------------------------------------------------
# AWS config configuration recorder
#---------------------------------------------------
variable "enable_config_configuration_recorder" {
  description = "Enable config configuration recoder usage"
  default     = false
}

variable "config_configuration_recorder_name" {
  description = "(Optional) The name of the recorder. Defaults to default. Changing it recreates the resource."
  default     = "default"
}

variable "config_configuration_recorder_role_arn" {
  description = "(Required) Amazon Resource Name (ARN) of the IAM role. used to make read or write requests to the delivery channel and to describe the AWS resources associated with the account. See AWS Docs for more details."
  default     = ""
}

variable "config_configuration_recorder_recording_group" {
  description = "(Optional) Recording group"
  default     = []
}

#---------------------------------------------------
# AWS config configuration recorder status
#---------------------------------------------------
variable "enable_config_configuration_recorder_status" {
  description = "Enable config configuration recoder status usage"
  default     = false
}

variable "config_configuration_recorder_status_name" {
  description = "Set name for config configuration recorder status"
  default     = ""
}

variable "config_configuration_recorder_status_is_enabled" {
  description = "(Required) Whether the configuration recorder should be enabled or disabled."
  default     = true
}

#---------------------------------------------------
# AWS config configuration aggregator
#---------------------------------------------------
variable "enable_config_configuration_aggregator" {
  description = "Enable config configuration aggregator usage"
  default     = false
}

variable "config_configuration_aggregator_name" {
  description = "The name of the configuration aggregator."
  default     = ""
}

variable "config_configuration_aggregator_account_aggregation_source" {
  description = " (Optional) The account(s) to aggregate config data from"
  default     = []
}

variable "config_configuration_aggregator_organization_aggregation_source" {
  description = "(Optional) The organization to aggregate config data from"
  default     = []
}

#---------------------------------------------------
# AWS config config rule
#---------------------------------------------------
variable "enable_config_config_rule" {
  description = "Enable config config rule usage"
  default     = false
}

variable "config_config_rule_name" {
  description = "The name of the rule"
  default     = ""
}

variable "config_config_rule_description" {
  description = "(Optional) Description of the rule"
  default     = ""
}

variable "config_config_rule_input_parameters" {
  description = "(Optional) A string in JSON format that is passed to the AWS Config rule Lambda function."
  default     = null
}

variable "config_config_rule_maximum_execution_frequency" {
  description = "(Optional) The maximum frequency with which AWS Config runs evaluations for a rule."
  default     = null
}

variable "config_config_rule_source" {
  description = "(Required) Source specifies the rule owner, the rule identifier, and the notifications that cause the function to evaluate your AWS resources"
  default     = []
}

variable "config_config_rule_scope" {
  description = "(Optional) Scope defines which resources can trigger an evaluation for the rule"
  default     = []
}

// #---------------------------------------------------
// # AWS config conformance pack
// #---------------------------------------------------
// variable "enable_config_conformance_pack" {
//   description = "Enable config conformance pack usage"
//   default     = false
// }

// variable "config_conformance_pack_name" {
//   description = "The name of the conformance pack. Must begin with a letter and contain from 1 to 256 alphanumeric characters and hyphens."
//   default     = ""
// }

// variable "config_conformance_pack_delivery_s3_bucket" {
//   description = "(Optional) Amazon S3 bucket where AWS Config stores conformance pack templates. Maximum length of 63."
//   default     = null
// }

// variable "config_conformance_pack_delivery_s3_key_prefix" {
//   description = "(Optional) The prefix for the Amazon S3 bucket. Maximum length of 1024."
//   default     = null
// }

// variable "config_conformance_pack_template_body" {
//   description = "(Optional, required if template_s3_uri is not provided) A string containing full conformance pack template body. Maximum length of 51200. Drift detection is not possible with this argument."
//   default     = null
// }

// variable "config_conformance_pack_template_s3_uri" {
//   description = "(Optional, required if template_body is not provided) Location of file, e.g. s3://bucketname/prefix, containing the template body. The uri must point to the conformance pack template that is located in an Amazon S3 bucket in the same region as the conformance pack. Maximum length of 1024. Drift detection is not possible with this argument."
//   default     = null
// }

// variable "config_conformance_pack_input_parameter" {
//   description = "(Optional) Set of configuration blocks describing input parameters passed to the conformance pack template. Documented below. When configured, the parameters must also be included in the template_body or in the template stored in Amazon S3 if using template_s3_uri."
//   default     = []
// }

#---------------------------------------------------
# AWS config remediation configuration
#---------------------------------------------------
variable "enable_config_remediation_configuration" {
  description = "Enable config remediation configuration usage"
  default     = false
}

variable "config_remediation_configuration_config_rule_name" {
  description = "The name of the AWS Config rule"
  default     = ""
}

variable "config_remediation_configuration_target_id" {
  description = "(Required) Target ID is the name of the public document"
  default     = null
}

variable "config_remediation_configuration_target_type" {
  description = "(Required) The type of the target. Target executes remediation. For example, SSM document"
  default     = null
}

variable "config_remediation_configuration_resource_type" {
  description = "(Optional) The type of a resource"
  default     = null
}

variable "config_remediation_configuration_target_version" {
  description = "(Optional) Version of the target. For example, version of the SSM document"
  default     = null
}

variable "config_remediation_configuration_parameter" {
  description = "(Optional) Can be specified multiple times for each parameter."
  default     = []
}

variable "config_remediation_configuration_automatic" {
  description = "(Optional) Remediation is triggered automatically if true"
  default     = null
}

variable "config_remediation_configuration_maximum_automatic_attempts" {
  description = "(Optional) Maximum number of failed attempts for auto-remediation. If you do not select a number, the default is 5"
  default     = null
}

variable "config_remediation_configuration_retry_attempt_seconds" {
  description = "(Optional) Maximum time in seconds that AWS Config runs auto-remediation. If you do not select a number, the default is 60 seconds."
  default     = null
}

variable "config_remediation_configuration_execution_controls" {
  description = "(Optional) Configuration block for execution controls."
  default     = {}
}
