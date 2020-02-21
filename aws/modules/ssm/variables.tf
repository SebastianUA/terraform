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

variable "orchestration" {
    description = "Type of orchestration"
    default     = "Terraform"
}

variable "createdby" {
    description = "Created by"
    default     = "Vitaliy Natarov"
}    

variable "tags" {
    description = "A list of tag blocks. Each element should have keys named key, value, etc."
    type        = map(string)
    default     = {}
}

#-----------------------------------------------------------
# AWS SSM activation
#-----------------------------------------------------------
variable "enable_ssm_activation" {
  description = "Enable ssm activation usage"
  default     = false
}

variable "ssm_activation_name" {
  description = "The default name of the registered managed instance."
  default     = ""
}

variable "ssm_activation_iam_role" {
  description = "(Required) The IAM Role to attach to the managed instance."
  default     = ""
}

variable "ssm_activation_expiration_date" {
  description = "(Optional) UTC timestamp in RFC3339 format by which this activation request should expire. The default value is 24 hours from resource creation time. Terraform will only perform drift detection of its value when present in a configuration."
  default     = null
}

variable "ssm_activation_description" {
  description = "(Optional) The description of the resource that you want to register."
  default     = null
}

variable "ssm_activation_registration_limit" {
  description = "(Optional) The maximum number of managed instances you want to register. The default value is 1 instance."
  default     = 1
}

#-----------------------------------------------------------
# AWS SSM association
#-----------------------------------------------------------
variable "enable_ssm_association" {
  description = "Enable ssm association usage"
  default     = false
}

variable "ssm_association_name" {
  description = "The name of the SSM document to apply."
  default     = ""
}

variable "ssm_association_association_name" {
  description = "(Optional) The descriptive name for the association."
  default     = null
}

variable "ssm_association_document_version" {
  description = "(Optional) The document version you want to associate with the target(s). Can be a specific version or the default version."
  default     = null
}

variable "ssm_association_instance_id" {
  description = "(Optional) The instance ID to apply an SSM document to. Use targets with key InstanceIds for document schema versions 2.0 and above."
  default     = null
}

variable "ssm_association_parameters" {
  description = "(Optional) A block of arbitrary string parameters to pass to the SSM document."
  default     = null
}

variable "ssm_association_schedule_expression" {
  description = "(Optional) A cron expression when the association will be applied to the target(s)."
  default     = null
}

variable "ssm_association_compliance_severity" {
  description = "(Optional) The compliance severity for the association. Can be one of the following: UNSPECIFIED, LOW, MEDIUM, HIGH or CRITICAL"
  default     = "UNSPECIFIED"
}

variable "ssm_association_max_concurrency" {
  description = "(Optional) The maximum number of targets allowed to run the association at the same time. You can specify a number, for example 10, or a percentage of the target set, for example 10%."
  default     = null
}

variable "ssm_association_max_errors" {
  description = "(Optional) The number of errors that are allowed before the system stops sending requests to run the association on additional targets. You can specify a number, for example 10, or a percentage of the target set, for example 10%."
  default     = null
}

variable "ssm_association_automation_target_parameter_name" {
  description = "(Optional) Specify the target for the association. This target is required for associations that use an Automation document and target resources by using rate controls."
  default     = null
}

variable "ssm_association_output_location" {
  description = "(Optional) An output location block."
  default     = []
}

variable "ssm_association_targets" {
  description = "(Optional) A block containing the targets of the SSM association. Targets are documented below. AWS currently supports a maximum of 5 targets."
  default     = []
}

#-----------------------------------------------------------
# AWS SSM document
#-----------------------------------------------------------
variable "enable_ssm_document" {
  description = "Enable ssm document usage"
  default     = false
}

variable "ssm_document_name" {
  description = "The name of the document."
  default     = ""
}

variable "ssm_document_document_type" {
  description = "(Required) The type of the document. Valid document types include: Automation, Command, Package, Policy, and Session"
  default     = "Command"
}

variable "ssm_document_content" {
  description = "(Required) The JSON or YAML content of the document."
  default     = ""
}

variable "ssm_document_document_format" {
  description = "(Optional, defaults to JSON) The format of the document. Valid document types include: JSON and YAML"
  default     = null
}

variable "ssm_document_permissions" {
  description = "(Optional) Additional Permissions to attach to the document."
  default     = []
}

variable "ssm_document_target_type" {
  description = "(Optional) The target type which defines the kinds of resources the document can run on. For example, /AWS::EC2::Instance. For a list of valid resource types, see AWS Resource Types Reference (http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html)"
  default     = null
}

variable "ssm_document_attachments_source" {
  description = "(Optional) One or more configuration blocks describing attachments sources to a version of a document."
  default     = []
}

#-----------------------------------------------------------
# AWS SSM parameter
#-----------------------------------------------------------
variable "enable_ssm_parameter" {
  description = "Enable ssm parameter usage"
  default     = false
}

variable "ssm_parameter_name" {
  description = "The name of the parameter. If the name contains a path (e.g. any forward slashes (/)), it must be fully qualified with a leading forward slash (/). For additional requirements and constraints, see the AWS SSM User Guide."
  default     = ""
}

variable "ssm_parameter_type" {
  description = "(Required) The type of the parameter. Valid types are String, StringList and SecureString."
  default     = "SecureString"
}

variable "ssm_parameter_value" {
  description = "(Required) The value of the parameter."
  default     = "I-PASSWORD"
}

variable "ssm_parameter_description" {
  description = "(Optional) The description of the parameter."
  default     = null
}

variable "ssm_parameter_tier" {
  description = "(Optional) The tier of the parameter. If not specified, will default to Standard. Valid tiers are Standard and Advanced. For more information on parameter tiers, see the AWS SSM Parameter tier comparison and guide."
  default     = null
}

variable "ssm_parameter_key_id" {
  description = "(Optional) The KMS key id or arn for encrypting a SecureString."
  default     = null
}

variable "ssm_parameter_overwrite" {
  description = "(Optional) Overwrite an existing parameter. If not specified, will default to false if the resource has not been created by terraform to avoid overwrite of existing resource and will default to true otherwise (terraform lifecycle rules should then be used to manage the update behavior)."
  default     = null
}

variable "ssm_parameter_allowed_pattern" {
  description = "(Optional) A regular expression used to validate the parameter value."
  default     = null
}

#-----------------------------------------------------------
# AWS SSM patch group
#-----------------------------------------------------------
variable "enable_ssm_patch_group" {
  description = "Enable ssm patch group usage"
  default     = false
}

variable "ssm_patch_group_patch_group" {
  description = "(Required) The name of the patch group that should be registered with the patch baseline."
  default     = ""
}

variable "ssm_patch_group_baseline_id" {
  description = "The ID of the patch baseline to register the patch group with."
  default     = ""
}

#-----------------------------------------------------------
# AWS SSM patch baseline
#-----------------------------------------------------------
variable "enable_ssm_patch_baseline" {
  description = "Enable ssm patch baseline usage"
  default     = false
}

variable "ssm_patch_baseline_name" {
  description = "The name of the patch baseline."
  default     = ""
}

variable "ssm_patch_baseline_description" {
  description = "(Optional) The description of the patch baseline."
  default     = null
}

variable "ssm_patch_baseline_operating_system" {
  description = "(Optional) Defines the operating system the patch baseline applies to. Supported operating systems include WINDOWS, AMAZON_LINUX, AMAZON_LINUX_2, SUSE, UBUNTU, CENTOS, and REDHAT_ENTERPRISE_LINUX. The Default value is WINDOWS."
  default     = "WINDOWS"
}

variable "ssm_patch_baseline_approved_patches" {
  description = "(Optional) A list of explicitly approved patches for the baseline."
  default     = null
}

variable "ssm_patch_baseline_rejected_patches" {
  description = "(Optional) A list of rejected patches."
  default     = null
}

variable "ssm_patch_baseline_approved_patches_compliance_level" {
  description = "(Optional) Defines the compliance level for approved patches. This means that if an approved patch is reported as missing, this is the severity of the compliance violation. Valid compliance levels include the following: CRITICAL, HIGH, MEDIUM, LOW, INFORMATIONAL, UNSPECIFIED. The default value is UNSPECIFIED."
  default     = "UNSPECIFIED"
}

variable "ssm_patch_baseline_global_filter" {
  description = "(Optional) A set of global filters used to exclude patches from the baseline. Up to 4 global filters can be specified using Key/Value pairs. Valid Keys are PRODUCT | CLASSIFICATION | MSRC_SEVERITY | PATCH_ID."
  default     = []
}

variable "ssm_patch_baseline_approval_rule_approve_after_days" {
  description = "(Required) The number of days after the release date of each patch matched by the rule the patch is marked as approved in the patch baseline. Valid Range: 0 to 100."
  default     = 50
}

variable "ssm_patch_baseline_approval_rule_compliance_level" {
  description = "(Optional) Defines the compliance level for patches approved by this rule. Valid compliance levels include the following: CRITICAL, HIGH, MEDIUM, LOW, INFORMATIONAL, UNSPECIFIED. The default value is UNSPECIFIED."
  default     = "UNSPECIFIED"
}

variable "ssm_patch_baseline_approval_rule_enable_non_security" {
  description = "(Optional) Boolean enabling the application of non-security updates. The default value is 'false'. Valid for Linux instances only."
  default     = null
}

variable "ssm_patch_baseline_patch_filter_key" {
  description = ""
  default     = "PATCH_SET"
}

variable "ssm_patch_baseline_patch_filter_values" {
  description = ""
  default     = ["APPLICATION"]
}

#-----------------------------------------------------------
# AWS SSM resource data sync
#-----------------------------------------------------------
variable "enable_ssm_resource_data_sync" {
  description = "Enable ssm resource data sync usage"
  default     = false
}

variable "ssm_resource_data_sync_name" {
  description = "Name for the configuration."
  default     = ""
}

variable "s3_destination_bucket_name" {
  description = "(Required) Name of S3 bucket where the aggregated data is stored."
  default     = ""
}

variable "s3_destination_region" {
  description = "(Required) Region with the bucket targeted by the Resource Data Sync."
  default     = ""
}

variable "s3_destination_kms_key_arn" {
  description = "(Optional) ARN of an encryption key for a destination in Amazon S3."
  default     = null
}

variable "s3_destination_prefix" {
  description = "(Optional) Prefix for the bucket."
  default     = null
}

variable "s3_destination_sync_format" {
  description = "(Optional) A supported sync format. Only JsonSerDe is currently supported. Defaults to JsonSerDe."
  default     = "JsonSerDe"
}

#-----------------------------------------------------------
# AWS SSM window
#-----------------------------------------------------------
variable "enable_ssm_maintenance_window" {
  description = "Enable ssm maintenance window usage"
  default     = false
}

variable "ssm_maintenance_window_name" {
  description = "The name of the maintenance window."
  default     = ""
}

variable "ssm_maintenance_window_schedule" {
  description = "(Required) The schedule of the Maintenance Window in the form of a cron or rate expression."
  default     = "cron(0 16 ? * TUE *)"
}

variable "ssm_maintenance_window_duration" {
  description = "(Required) The duration of the Maintenance Window in hours."
  default     = 3
}

variable "ssm_maintenance_window_cutoff" {
  description = "(Required) The number of hours before the end of the Maintenance Window that Systems Manager stops scheduling new tasks for execution."
  default     = 1
}

variable "ssm_maintenance_window_description" {
  description = "(Optional) A description for the maintenance window."
  default     = null
}

variable "ssm_maintenance_window_allow_unassociated_targets" {
  description = "(Optional) Whether targets must be registered with the Maintenance Window before tasks can be defined for those targets."
  default     = null
}

variable "ssm_maintenance_window_enabled" {
  description = "(Optional) Whether the maintenance window is enabled. Default: true."
  default     = true
}

variable "ssm_maintenance_window_end_date" {
  description = "(Optional) Timestamp in ISO-8601 extended format when to no longer run the maintenance window."
  default     = null
}

variable "ssm_maintenance_window_schedule_timezone" {
  description = "(Optional) Timezone for schedule in Internet Assigned Numbers Authority (IANA) Time Zone Database format. For example: America/Los_Angeles, etc/UTC, or Asia/Seoul."
  default     = null
}

variable "ssm_maintenance_window_start_date" {
  description = "(Optional) Timestamp in ISO-8601 extended format when to begin the maintenance window."
  default     = null
}

#-----------------------------------------------------------
# AWS SSM window task
#-----------------------------------------------------------
variable "enable_ssm_maintenance_window_task" {
  description = "Enable ssm maintenance window task"
  default     = false
}

variable "ssm_maintenance_window_task_max_concurrency" {
  description = "(Required) The maximum number of targets this task can be run for in parallel."
  default     = 2
}

variable "ssm_maintenance_window_task_max_errors" {
  description = "(Required) The maximum number of errors allowed before this task stops being scheduled."
  default     = 1
}

variable "ssm_maintenance_window_task_priority" {
  description = "(Optional) The priority of the task in the Maintenance Window, the lower the number the higher the priority. Tasks in a Maintenance Window are scheduled in priority order with tasks that have the same priority scheduled in parallel."
  default     = 1
}

variable "ssm_maintenance_window_task_service_role_arn" {
  description = "(Required) The role that should be assumed when executing the task."
  default     = ""
}

variable "ssm_maintenance_window_task_task_arn" {
  description = "(Required) The ARN of the task to execute."
  default     = ""
}

variable "ssm_maintenance_window_task_task_type" {
  description = "(Required) The type of task being registered. The only allowed value is RUN_COMMAND."
  default     = "RUN_COMMAND"
}

variable "ssm_maintenance_window_task_window_id" {
  description = "The Id of the maintenance window to register the task with."
  default     = ""
}

variable "ssm_maintenance_window_task_name" {
  description = "(Optional) The name of the maintenance window task."
  default     = ""
}

variable "ssm_maintenance_window_task_description" {
  description = "(Optional) The description of the maintenance window task."
  default     = null
}

#variable "ssm_maintenance_window_task_targets" {
#  description = "(Required) The targets (either instances or window target ids). Instances are specified using Key=InstanceIds,Values=instanceid1,instanceid2. Window target ids are specified using Key=WindowTargetIds,Values=window target id1, window target id2."
#  default     = []
#}

variable "ssm_maintenance_window_task_targets_key" {
  description = "Key for targets.The targets (either instances or window target ids). Instances are specified using Key=InstanceIds,Values=instanceid1,instanceid2. Window target ids are specified using Key=WindowTargetIds,Values=window target id1, window target id2."
  default     = "InstanceIds"
}

variable "ssm_maintenance_window_task_targets_values" {
  description = "Values for targets.The targets (either instances or window target ids). Instances are specified using Key=InstanceIds,Values=instanceid1,instanceid2. Window target ids are specified using Key=WindowTargetIds,Values=window target id1, window target id2."
  default     = ["instanceid1", "instanceid2"]
}



#----
# variable "ssm_maintenance_window_task_automation_parameters" {
#   description = "(Optional) The parameters for an AUTOMATION task type"
#   default     = []
# }

# variable "ssm_maintenance_window_task_lambda_parameters" {
#   description = "(Optional) The parameters for a LAMBDA task type."
#   default     = []
# }

# variable "ssm_maintenance_window_task_run_command_parameters" {
#   description = "(Optional) The parameters for a RUN_COMMAND task type."
#   default     = []
# }

# variable "ssm_maintenance_window_task_notification_config" {
#   description = "(Optional) Configurations for sending notifications about command status changes on a per-instance basis."
#   default     = []
# }

# variable "ssm_maintenance_window_task_parameter" {
#   description = "(Optional) The parameters for the RUN_COMMAND task execution."
#   default     = []
# }

# variable "ssm_maintenance_window_task_step_functions_parameters" {
#   description = "(Optional) The parameters for a STEP_FUNCTIONS task type."
#   default     = []
#}

variable "enable_automation_parameters" {
  description = "Enable automation parameters usage block"
  default     = false
}

variable "automation_parameters_document_version" {
  description = "(Optional) The version of an Automation document to use during task execution."
  default     = ""
}

variable "automation_parameters_parameter_name" {
  description = "Param name for automation_parameters block"
  default     = ""
}

variable "automation_parameters_parameter_values" {
  description = "Param values for automation_parameters block"
  default     = ["instanceid1", "instanceid2"]
}

variable "enable_lambda_parameters" {
  description = "Enable lambda parameters usage block"
  default     = false
}

variable "lambda_parameters_client_context" {
  description = "(Optional) Pass client-specific information to the Lambda function that you are invoking."
  default     = null
}

variable "lambda_parameters_payload" {
  description = "(Optional) JSON to provide to your Lambda function as input."
  default     = null
}

variable "lambda_parameters_qualifier" {
  description = "(Optional) Specify a Lambda function version or alias name."
  default     = null
}

variable "enable_run_command_parameters" {
  description = "Enable run command parameters usage block"
  default     = false
}

variable "run_command_parameters_comment" {
  description = "(Optional) Information about the command(s) to execute."
  default     = null
}

variable "run_command_parameters_document_hash" {
  description = "(Optional) The SHA-256 or SHA-1 hash created by the system when the document was created. SHA-1 hashes have been deprecated."
  default     = null
}

variable "run_command_parameters_document_hash_type" {
  description = "(Optional) SHA-256 or SHA-1. SHA-1 hashes have been deprecated. Valid values: Sha256 and Sha1"
  default     = null
}

variable "run_command_parameters_output_s3_bucket" {
  description = "(Optional) The name of the Amazon S3 bucket."
  default     = null
}

variable "run_command_parameters_output_s3_key_prefix" {
  description = "(Optional) The Amazon S3 bucket subfolder."
  default     = null
}

variable "run_command_parameters_service_role_arn" {
  description = "(Optional) The IAM service role to assume during task execution."
  default     = null
}

variable "run_command_parameters_timeout_seconds" {
  description = "(Optional) If this time is reached and the command has not already started executing, it doesn't run."
  default     = null
}

variable "enable_notification_config" {
  description = "Enable notification config usage block"
  default     = false
}

variable "notification_config_notification_arn" {
  description = "(Optional) An Amazon Resource Name (ARN) for a Simple Notification Service (SNS) topic. Run Command pushes notifications about command status changes to this topic."
  default     = null
}

variable "notification_config_notification_events" {
  description = "(Optional) The different events for which you can receive notifications. Valid values: All, InProgress, Success, TimedOut, Cancelled, and Failed"
  default     = null
}

variable "notification_config_notification_type" {
  description = "(Optional) When specified with Command, receive notification when the status of a command changes. When specified with Invocation, for commands sent to multiple instances, receive notification on a per-instance basis when the status of a command changes. Valid values: Command and Invocation"
  default     = null
}

variable "enable_run_command_parameters_parameter" {
  description = "Enable parameter usage for run_command_parameters block"
  default     = false
}

variable "run_command_parameters_parameter_name" {
  description = "Param name for run_command_parameters block"
  default     = ""
}

variable "command_parameters_parameter_values" {
  description = "Param values for run_command_parameters block"
  default     = ["instanceid1", "instanceid2"]
}

variable "enable_step_functions_parameters" {
  description = "Enable step functions parameters usage"
  default     = false
}

variable "step_functions_parameters_input" {
  description = "(Optional) The inputs for the STEP_FUNCTION task."
  default     = null
}

variable "step_functions_parameters_name" {
  description = "(Optional) The name of the STEP_FUNCTION task."
  default     = null
}

#-----------------------------------------------------------
# AWS SSM window target
#-----------------------------------------------------------
variable "enable_ssm_maintenance_window_target" {
  description = "Enable ssm maintenance window target usage"
  default     = false
}

variable "ssm_maintenance_window_target_name" {
  description = "(Optional) The name of the maintenance window target."
  default     = ""
}

variable "ssm_maintenance_window_target_description" {
  description = "(Optional) The description of the maintenance window target."
  default     = null
}

variable "ssm_maintenance_window_target_resource_type" {
  description = "(Required) The type of target being registered with the Maintenance Window. Possible values INSTANCE."
  default     = "INSTANCE"
}

variable "ssm_maintenance_window_target_window_id" {
  description = "The Id of the maintenance window to register the target with."
  default     = ""
}

variable "ssm_maintenance_window_target_owner_information" {
  description = "(Optional) User-provided value that will be included in any CloudWatch events raised while running tasks for these targets in this Maintenance Window."
  default     = null
}

variable "ssm_maintenance_window_target_targets" {
  description = "(Required) The targets (either instances or tags). Instances are specified using Key=InstanceIds,Values=InstanceId1,InstanceId2. Tags are specified using Key=tag name,Values=tag value."
  default     = []
}