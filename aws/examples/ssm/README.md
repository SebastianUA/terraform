# Work with AWS System Manager via terraform

A terraform module for making AWS System Manager resources.

## Usage
----------------------

Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
    required_version = "~> 0.12.12"
}

provider "aws" {
    region                  = "us-east-1"
    profile                 = "default"
    shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "ssm" {
    source                                          = "../../modules/ssm"

    name                                            = "name"
    region                                          = "us-east-1"
    environment                                     = "stage"

    #enable_ssm_association                          = true
    #ssm_association_name                            = "test-association"

    enable_ssm_maintenance_window                   = true
    ssm_maintenance_window_name                     = ""
    ssm_maintenance_window_schedule                 = "cron(0 16 ? * TUE *)"
    ssm_maintenance_window_duration                 = 3
    ssm_maintenance_window_cutoff                   = 1

    enable_ssm_maintenance_window_task              = true
    ssm_maintenance_window_task_name                = ""
    ssm_maintenance_window_task_service_role_arn    = "arn:aws:iam::167127734783:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"
    ssm_maintenance_window_task_task_arn            = "AWS-RestartEC2Instance"
    
}
```

Module Input Variables
----------------------

- `name` - Name to be used on all resources as prefix (`default     = "TEST"`).
- `region` - The region where to deploy this code (e.g. us-east-1). (`default     = "us-east-1"`). 
- `environment` - Environment for service (`  default     = "STAGE"`).
- `orchestration` - Type of orchestration (`  default     = "Terraform"`).
- `createdby` - Created by (`  default     = "Vitaliy Natarov"`).    
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default     = {}`).
- `enable_ssm_activation` - Enable ssm activation usage (`default     = false`).
- `ssm_activation_name` - The default name of the registered managed instance. (`default     = ""`).
- `ssm_activation_iam_role` - (Required) The IAM Role to attach to the managed instance. (`default     = ""`).
- `ssm_activation_expiration_date` - (Optional) UTC timestamp in RFC3339 format by which this activation request should expire. The default value is 24 hours from resource creation time. Terraform will only perform drift detection of its value when present in a configuration. (`default     = null`).
- `ssm_activation_description` - (Optional) The description of the resource that you want to register. (`default     = null`).
- `ssm_activation_registration_limit` - (Optional) The maximum number of managed instances you want to register. The default value is 1 instance. (`default     = 1`).
- `enable_ssm_association` - Enable ssm association usage (`default     = false`).
- `ssm_association_name` - The name of the SSM document to apply. (`default     = ""`).
- `ssm_association_association_name` - (Optional) The descriptive name for the association. (`default     = null`).
- `ssm_association_document_version` - (Optional) The document version you want to associate with the target(s). Can be a specific version or the default version. (`default     = null`).
- `ssm_association_instance_id` - (Optional) The instance ID to apply an SSM document to. Use targets with key InstanceIds for document schema versions 2.0 and above. (`default     = null`).
- `ssm_association_parameters` - (Optional) A block of arbitrary string parameters to pass to the SSM document. (`default     = null`).
- `ssm_association_schedule_expression` - (Optional) A cron expression when the association will be applied to the target(s). (`default     = null`).
- `ssm_association_compliance_severity` - (Optional) The compliance severity for the association. Can be one of the following: UNSPECIFIED, LOW, MEDIUM, HIGH or CRITICAL (`default     = "UNSPECIFIED"`).
- `ssm_association_max_concurrency` - (Optional) The maximum number of targets allowed to run the association at the same time. You can specify a number, for example 10, or a percentage of the target set, for example 10%. (`default     = null`).
- `ssm_association_max_errors` - (Optional) The number of errors that are allowed before the system stops sending requests to run the association on additional targets. You can specify a number, for example 10, or a percentage of the target set, for example 10%. (`default     = null`).
- `ssm_association_automation_target_parameter_name` - (Optional) Specify the target for the association. This target is required for associations that use an Automation document and target resources by using rate controls. (`default     = null`).
- `ssm_association_output_location` - (Optional) An output location block. (`default     = []`).
- `ssm_association_targets` - (Optional) A block containing the targets of the SSM association. Targets are documented below. AWS currently supports a maximum of 5 targets. (`default     = []`).
- `enable_ssm_document` - Enable ssm document usage (`default     = false`).
- `ssm_document_name` - The name of the document. (`default     = ""`).
- `ssm_document_document_type` - (Required) The type of the document. Valid document types include: Automation, Command, Package, Policy, and Session (`default     = "Command"`).
- `ssm_document_content` - (Required) The JSON or YAML content of the document. (`default     = ""`).
- `ssm_document_document_format` - (Optional, defaults to JSON) The format of the document. Valid document types include: JSON and YAML (`default     = null`).
- `ssm_document_permissions` - (Optional) Additional Permissions to attach to the document. (`default     = []`).
- `ssm_document_target_type` - (Optional) The target type which defines the kinds of resources the document can run on. For example, /AWS::EC2::Instance. For a list of valid resource types, see AWS Resource Types Reference (http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html) (`default     = null`).
- `ssm_document_attachments_source` - (Optional) One or more configuration blocks describing attachments sources to a version of a document. (`default     = []`).
- `enable_ssm_parameter` - Enable ssm parameter usage (`default     = false`).
- `ssm_parameter_name` - The name of the parameter. If the name contains a path (e.g. any forward slashes (/)), it must be fully qualified with a leading forward slash (/). For additional requirements and constraints, see the AWS SSM User Guide. (`default     = ""`).
- `ssm_parameter_type` - (Required) The type of the parameter. Valid types are String, StringList and SecureString. (`default     = "SecureString"`).
- `ssm_parameter_value` - (Required) The value of the parameter. (`default     = "I-PASSWORD"`).
- `ssm_parameter_description` - (Optional) The description of the parameter. (`default     = null`).
- `ssm_parameter_tier` - (Optional) The tier of the parameter. If not specified, will default to Standard. Valid tiers are Standard and Advanced. For more information on parameter tiers, see the AWS SSM Parameter tier comparison and guide. (`default     = null`).
- `ssm_parameter_key_id` - (Optional) The KMS key id or arn for encrypting a SecureString. (`default     = null`).
- `ssm_parameter_overwrite` - (Optional) Overwrite an existing parameter. If not specified, will default to false if the resource has not been created by terraform to avoid overwrite of existing resource and will default to true otherwise (terraform lifecycle rules should then be used to manage the update behavior). (`default     = null`).
- `ssm_parameter_allowed_pattern` - (Optional) A regular expression used to validate the parameter value. (`default     = null`).
- `enable_ssm_patch_group` - Enable ssm patch group usage (`default     = false`).
- `ssm_patch_group_patch_group` - (Required) The name of the patch group that should be registered with the patch baseline. (`default     = ""`).
- `ssm_patch_group_baseline_id` - The ID of the patch baseline to register the patch group with. (`default     = ""`).
- `enable_ssm_patch_baseline` - Enable ssm patch baseline usage (`default     = false`).
- `ssm_patch_baseline_name` - The name of the patch baseline. (`default     = ""`).
- `ssm_patch_baseline_description` - (Optional) The description of the patch baseline. (`default     = null`).
- `ssm_patch_baseline_operating_system` - (Optional) Defines the operating system the patch baseline applies to. Supported operating systems include WINDOWS, AMAZON_LINUX, AMAZON_LINUX_2, SUSE, UBUNTU, CENTOS, and REDHAT_ENTERPRISE_LINUX. The Default value is WINDOWS. (`default     = "WINDOWS"`).
- `ssm_patch_baseline_approved_patches` - (Optional) A list of explicitly approved patches for the baseline. (`default     = null`).
- `ssm_patch_baseline_rejected_patches` - (Optional) A list of rejected patches. (`default     = null`).
- `ssm_patch_baseline_approved_patches_compliance_level` - (Optional) Defines the compliance level for approved patches. This means that if an approved patch is reported as missing, this is the severity of the compliance violation. Valid compliance levels include the following: CRITICAL, HIGH, MEDIUM, LOW, INFORMATIONAL, UNSPECIFIED. The default value is UNSPECIFIED. (`default     = "UNSPECIFIED"`).
- `ssm_patch_baseline_global_filter` - (Optional) A set of global filters used to exclude patches from the baseline. Up to 4 global filters can be specified using Key/Value pairs. Valid Keys are PRODUCT | CLASSIFICATION | MSRC_SEVERITY | PATCH_ID. (`default     = []`).
- `ssm_patch_baseline_approval_rule_approve_after_days` - (Required) The number of days after the release date of each patch matched by the rule the patch is marked as approved in the patch baseline. Valid Range: 0 to 100. (`default     = 50`).
- `ssm_patch_baseline_approval_rule_compliance_level` - (Optional) Defines the compliance level for patches approved by this rule. Valid compliance levels include the following: CRITICAL, HIGH, MEDIUM, LOW, INFORMATIONAL, UNSPECIFIED. The default value is UNSPECIFIED. (`default     = "UNSPECIFIED"`).
- `ssm_patch_baseline_approval_rule_enable_non_security` - (Optional) Boolean enabling the application of non-security updates. The default value is 'false'. Valid for Linux instances only. (`default     = null`).
- `ssm_patch_baseline_patch_filter_key` -  (`default     = "PATCH_SET"`).
- `ssm_patch_baseline_patch_filter_values` -  (`default     = ["APPLICATION"]`).
- `enable_ssm_resource_data_sync` - Enable ssm resource data sync usage (`default     = false`).
- `ssm_resource_data_sync_name` - Name for the configuration. (`default     = ""`).
- `s3_destination_bucket_name` - (Required) Name of S3 bucket where the aggregated data is stored. (`default     = ""`).
- `s3_destination_region` - (Required) Region with the bucket targeted by the Resource Data Sync. (`default     = ""`).
- `s3_destination_kms_key_arn` - (Optional) ARN of an encryption key for a destination in Amazon S3. (`default     = null`).
- `s3_destination_prefix` - (Optional) Prefix for the bucket. (`default     = null`).
- `s3_destination_sync_format` - (Optional) A supported sync format. Only JsonSerDe is currently supported. Defaults to JsonSerDe. (`default     = "JsonSerDe"`).
- `enable_ssm_maintenance_window` - Enable ssm maintenance window usage (`default     = false`).
- `ssm_maintenance_window_name` - The name of the maintenance window. (`default     = ""`).
- `ssm_maintenance_window_schedule` - (Required) The schedule of the Maintenance Window in the form of a cron or rate expression. (`default     = "cron(0 16 ? * TUE *)"`).
- `ssm_maintenance_window_duration` - (Required) The duration of the Maintenance Window in hours. (`default     = 3`).
- `ssm_maintenance_window_cutoff` - (Required) The number of hours before the end of the Maintenance Window that Systems Manager stops scheduling new tasks for execution. (`default     = 1`).
- `ssm_maintenance_window_description` - (Optional) A description for the maintenance window. (`default     = null`).
- `ssm_maintenance_window_allow_unassociated_targets` - (Optional) Whether targets must be registered with the Maintenance Window before tasks can be defined for those targets. (`default     = null`).
- `ssm_maintenance_window_enabled` - (Optional) Whether the maintenance window is enabled. Default: true. (`default     = true`).
- `ssm_maintenance_window_end_date` - (Optional) Timestamp in ISO-8601 extended format when to no longer run the maintenance window. (`default     = null`).
- `ssm_maintenance_window_schedule_timezone` - (Optional) Timezone for schedule in Internet Assigned Numbers Authority (IANA) Time Zone Database format. For example: America/Los_Angeles, etc/UTC, or Asia/Seoul. (`default     = null`).
- `ssm_maintenance_window_start_date` - (Optional) Timestamp in ISO-8601 extended format when to begin the maintenance window. (`default     = null`).
- `enable_ssm_maintenance_window_task` - Enable ssm maintenance window task (`default     = false`).
- `ssm_maintenance_window_task_max_concurrency` - (Required) The maximum number of targets this task can be run for in parallel. (`default     = 2`).
- `ssm_maintenance_window_task_max_errors` - (Required) The maximum number of errors allowed before this task stops being scheduled. (`default     = 1`).
- `ssm_maintenance_window_task_priority` - (Optional) The priority of the task in the Maintenance Window, the lower the number the higher the priority. Tasks in a Maintenance Window are scheduled in priority order with tasks that have the same priority scheduled in parallel. (`default     = 1`).
- `ssm_maintenance_window_task_service_role_arn` - (Required) The role that should be assumed when executing the task. (`default     = ""`).
- `ssm_maintenance_window_task_task_arn` - (Required) The ARN of the task to execute. (`default     = ""`).
- `ssm_maintenance_window_task_task_type` - (Required) The type of task being registered. The only allowed value is RUN_COMMAND. (`default     = "RUN_COMMAND"`).
- `ssm_maintenance_window_task_window_id` - The Id of the maintenance window to register the task with. (`default     = ""`).
- `ssm_maintenance_window_task_name` - (Optional) The name of the maintenance window task. (`default     = ""`).
- `ssm_maintenance_window_task_description` - (Optional) The description of the maintenance window task. (`default     = null`).
- `ssm_maintenance_window_task_targets_key` - Key for targets.The targets (either instances or window target ids). Instances are specified using Key=InstanceIds,Values=instanceid1,instanceid2. Window target ids are specified using Key=WindowTargetIds,Values=window target id1, window target id2. (`default     = "InstanceIds"`).
- `ssm_maintenance_window_task_targets_values` - Values for targets.The targets (either instances or window target ids). Instances are specified using Key=InstanceIds,Values=instanceid1,instanceid2. Window target ids are specified using Key=WindowTargetIds,Values=window target id1, window target id2. (`default     = ["instanceid1", "instanceid2"]`).
- `enable_automation_parameters` - Enable automation parameters usage block (`default     = false`).
- `automation_parameters_document_version` - (Optional) The version of an Automation document to use during task execution. (`default     = ""`).
- `automation_parameters_parameter_name` - Param name for automation_parameters block (`default     = ""`).
- `automation_parameters_parameter_values` - Param values for automation_parameters block (`default     = ["instanceid1", "instanceid2"]`).
- `enable_lambda_parameters` - Enable lambda parameters usage block (`default     = false`).
- `lambda_parameters_client_context` - (Optional) Pass client-specific information to the Lambda function that you are invoking. (`default     = null`).
- `lambda_parameters_payload` - (Optional) JSON to provide to your Lambda function as input. (`default     = null`).
- `lambda_parameters_qualifier` - (Optional) Specify a Lambda function version or alias name. (`default     = null`).
- `enable_run_command_parameters` - Enable run command parameters usage block (`default     = false`).
- `run_command_parameters_comment` - (Optional) Information about the command(s) to execute. (`default     = null`).
- `run_command_parameters_document_hash` - (Optional) The SHA-256 or SHA-1 hash created by the system when the document was created. SHA-1 hashes have been deprecated. (`default     = null`).
- `run_command_parameters_document_hash_type` - (Optional) SHA-256 or SHA-1. SHA-1 hashes have been deprecated. Valid values: Sha256 and Sha1 (`default     = null`).
- `run_command_parameters_output_s3_bucket` - (Optional) The name of the Amazon S3 bucket. (`default     = null`).
- `run_command_parameters_output_s3_key_prefix` - (Optional) The Amazon S3 bucket subfolder. (`default     = null`).
- `run_command_parameters_service_role_arn` - (Optional) The IAM service role to assume during task execution. (`default     = null`).
- `run_command_parameters_timeout_seconds` - (Optional) If this time is reached and the command has not already started executing, it doesn't run. (`default     = null`).
- `enable_notification_config` - Enable notification config usage block (`default     = false`).
- `notification_config_notification_arn` - (Optional) An Amazon Resource Name (ARN) for a Simple Notification Service (SNS) topic. Run Command pushes notifications about command status changes to this topic. (`default     = null`).
- `notification_config_notification_events` - (Optional) The different events for which you can receive notifications. Valid values: All, InProgress, Success, TimedOut, Cancelled, and Failed (`default     = null`).
- `notification_config_notification_type` - (Optional) When specified with Command, receive notification when the status of a command changes. When specified with Invocation, for commands sent to multiple instances, receive notification on a per-instance basis when the status of a command changes. Valid values: Command and Invocation (`default     = null`).
- `enable_run_command_parameters_parameter` - Enable parameter usage for run_command_parameters block (`default     = false`).
- `run_command_parameters_parameter_name` - Param name for run_command_parameters block (`default     = ""`).
- `command_parameters_parameter_values` - Param values for run_command_parameters block (`default     = ["instanceid1", "instanceid2"]`).
- `enable_step_functions_parameters` - Enable step functions parameters usage (`default     = false`).
- `step_functions_parameters_input` - (Optional) The inputs for the STEP_FUNCTION task. (`default     = null`).
- `step_functions_parameters_name` - (Optional) The name of the STEP_FUNCTION task. (`default     = null`).
- `enable_ssm_maintenance_window_target` - Enable ssm maintenance window target usage (`default     = false`).
- `ssm_maintenance_window_target_name` - (Optional) The name of the maintenance window target. (`default     = ""`).
- `ssm_maintenance_window_target_description` - (Optional) The description of the maintenance window target. (`default     = null`).
- `ssm_maintenance_window_target_resource_type` - (Required) The type of target being registered with the Maintenance Window. Possible values INSTANCE. (`default     = "INSTANCE"`).
- `ssm_maintenance_window_target_window_id` - The Id of the maintenance window to register the target with. (`default     = ""`).
- `ssm_maintenance_window_target_owner_information` - (Optional) User-provided value that will be included in any CloudWatch events raised while running tasks for these targets in this Maintenance Window. (`default     = null`).
- `ssm_maintenance_window_target_targets` - (Required) The targets (either instances or tags). Instances are specified using Key=InstanceIds,Values=InstanceId1,InstanceId2. Tags are specified using Key=tag name,Values=tag value. (`default     = []`).


Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.
