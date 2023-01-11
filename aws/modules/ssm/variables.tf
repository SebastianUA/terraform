#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST"
}

variable "environment" {
  description = "Environment for service"
  default     = "STAGE"
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

variable "ssm_association_apply_only_at_cron_interval" {
  description = "(Optional) By default, when you create a new or update associations, the system runs it immediately and then according to the schedule you specified. Enable this option if you do not want an association to run immediately after you create or update it. This parameter is not supported for rate expressions. Default: false."
  default     = null
}

variable "ssm_association_wait_for_success_timeout_seconds" {
  description = "(Optional) The number of seconds to wait for the association status to be Success. If Success status is not reached within the given time, create opration will fail."
  default     = null
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

variable "ssm_patch_baseline_approval_rule" {
  description = "(Optional) A set of rules used to include patches in the baseline. up to 10 approval rules can be specified."
  default     = []
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

variable "ssm_resource_data_sync_s3_destination" {
  description = "(Required) Amazon S3 configuration details for the sync."
  default     = []
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

variable "ssm_maintenance_window_task_targets" {
  description = "(Required) The targets (either instances or window target ids). Instances are specified using Key=InstanceIds,Values=instanceid1,instanceid2. Window target ids are specified using Key=WindowTargetIds,Values=window target id1, window target id2."
  default     = []
}

variable "ssm_maintenance_window_task_task_invocation_parameters" {
  description = "(Optional) Configuration block with parameters for task execution."
  default     = []
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
