# Work with SSM via terraform

A terraform module for making SSM.


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

module "ssm" {
  source = "../../modules/ssm"

  name        = "name"
  environment = "stage"

  #enable_ssm_association                          = true
  #ssm_association_name                            = "test-association"

  enable_ssm_maintenance_window   = true
  ssm_maintenance_window_name     = ""
  ssm_maintenance_window_schedule = "cron(0 16 ? * TUE *)"
  ssm_maintenance_window_duration = 3
  ssm_maintenance_window_cutoff   = 1

  enable_ssm_maintenance_window_task           = true
  ssm_maintenance_window_task_name             = ""
  ssm_maintenance_window_task_service_role_arn = "arn:aws:iam::167127734783:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"
  ssm_maintenance_window_task_task_arn         = "AWS-RestartEC2Instance"
  ssm_maintenance_window_task_targets = [
    {
      key    = "InstanceIds"
      values = ["aws_instance_id"]
    }
  ]

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
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_ssm_activation` - Enable ssm activation usage (`default = False`)
- `ssm_activation_name` - The default name of the registered managed instance. (`default = ""`)
- `ssm_activation_iam_role` - (Required) The IAM Role to attach to the managed instance. (`default = ""`)
- `ssm_activation_expiration_date` - (Optional) UTC timestamp in RFC3339 format by which this activation request should expire. The default value is 24 hours from resource creation time. Terraform will only perform drift detection of its value when present in a configuration. (`default = null`)
- `ssm_activation_description` - (Optional) The description of the resource that you want to register. (`default = null`)
- `ssm_activation_registration_limit` - (Optional) The maximum number of managed instances you want to register. The default value is 1 instance. (`default = 1`)
- `enable_ssm_association` - Enable ssm association usage (`default = False`)
- `ssm_association_name` - The name of the SSM document to apply. (`default = ""`)
- `ssm_association_association_name` - (Optional) The descriptive name for the association. (`default = null`)
- `ssm_association_document_version` - (Optional) The document version you want to associate with the target(s). Can be a specific version or the default version. (`default = null`)
- `ssm_association_parameters` - (Optional) A block of arbitrary string parameters to pass to the SSM document. (`default = null`)
- `ssm_association_schedule_expression` - (Optional) A cron expression when the association will be applied to the target(s). (`default = null`)
- `ssm_association_compliance_severity` - (Optional) The compliance severity for the association. Can be one of the following: UNSPECIFIED, LOW, MEDIUM, HIGH or CRITICAL (`default = UNSPECIFIED`)
- `ssm_association_max_concurrency` - (Optional) The maximum number of targets allowed to run the association at the same time. You can specify a number, for example 10, or a percentage of the target set, for example 10%. (`default = null`)
- `ssm_association_max_errors` - (Optional) The number of errors that are allowed before the system stops sending requests to run the association on additional targets. You can specify a number, for example 10, or a percentage of the target set, for example 10%. (`default = null`)
- `ssm_association_automation_target_parameter_name` - (Optional) Specify the target for the association. This target is required for associations that use an Automation document and target resources by using rate controls. (`default = null`)
- `ssm_association_output_location` - (Optional) An output location block. (`default = []`)
- `ssm_association_targets` - (Optional) A block containing the targets of the SSM association. Targets are documented below. AWS currently supports a maximum of 5 targets. (`default = []`)
- `ssm_association_apply_only_at_cron_interval` - (Optional) By default, when you create a new or update associations, the system runs it immediately and then according to the schedule you specified. Enable this option if you do not want an association to run immediately after you create or update it. This parameter is not supported for rate expressions. Default: false. (`default = null`)
- `ssm_association_wait_for_success_timeout_seconds` - (Optional) The number of seconds to wait for the association status to be Success. If Success status is not reached within the given time, create opration will fail. (`default = null`)
- `enable_ssm_document` - Enable ssm document usage (`default = False`)
- `ssm_document_name` - The name of the document. (`default = ""`)
- `ssm_document_document_type` - (Required) The type of the document. Valid document types include: Automation, Command, Package, Policy, and Session (`default = Command`)
- `ssm_document_content` - (Required) The JSON or YAML content of the document. (`default = ""`)
- `ssm_document_document_format` - (Optional, defaults to JSON) The format of the document. Valid document types include: JSON and YAML (`default = null`)
- `ssm_document_permissions` - (Optional) Additional Permissions to attach to the document. (`default = []`)
- `ssm_document_target_type` - (Optional) The target type which defines the kinds of resources the document can run on. For example, /AWS::EC2::Instance. For a list of valid resource types, see AWS Resource Types Reference (http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html) (`default = null`)
- `ssm_document_attachments_source` - (Optional) One or more configuration blocks describing attachments sources to a version of a document. (`default = []`)
- `enable_ssm_parameter` - Enable ssm parameter usage (`default = False`)
- `ssm_parameter_name` - The name of the parameter. If the name contains a path (e.g. any forward slashes (/)), it must be fully qualified with a leading forward slash (/). For additional requirements and constraints, see the AWS SSM User Guide. (`default = ""`)
- `ssm_parameter_type` - (Required) The type of the parameter. Valid types are String, StringList and SecureString. (`default = SecureString`)
- `ssm_parameter_value` - (Required) The value of the parameter. (`default = I-PASSWORD`)
- `ssm_parameter_description` - (Optional) The description of the parameter. (`default = null`)
- `ssm_parameter_tier` - (Optional) The tier of the parameter. If not specified, will default to Standard. Valid tiers are Standard and Advanced. For more information on parameter tiers, see the AWS SSM Parameter tier comparison and guide. (`default = null`)
- `ssm_parameter_key_id` - (Optional) The KMS key id or arn for encrypting a SecureString. (`default = null`)
- `ssm_parameter_overwrite` - (Optional) Overwrite an existing parameter. If not specified, will default to false if the resource has not been created by terraform to avoid overwrite of existing resource and will default to true otherwise (terraform lifecycle rules should then be used to manage the update behavior). (`default = null`)
- `ssm_parameter_allowed_pattern` - (Optional) A regular expression used to validate the parameter value. (`default = null`)
- `enable_ssm_patch_group` - Enable ssm patch group usage (`default = False`)
- `ssm_patch_group_patch_group` - (Required) The name of the patch group that should be registered with the patch baseline. (`default = ""`)
- `ssm_patch_group_baseline_id` - The ID of the patch baseline to register the patch group with. (`default = ""`)
- `enable_ssm_patch_baseline` - Enable ssm patch baseline usage (`default = False`)
- `ssm_patch_baseline_name` - The name of the patch baseline. (`default = ""`)
- `ssm_patch_baseline_description` - (Optional) The description of the patch baseline. (`default = null`)
- `ssm_patch_baseline_operating_system` - (Optional) Defines the operating system the patch baseline applies to. Supported operating systems include WINDOWS, AMAZON_LINUX, AMAZON_LINUX_2, SUSE, UBUNTU, CENTOS, and REDHAT_ENTERPRISE_LINUX. The Default value is WINDOWS. (`default = WINDOWS`)
- `ssm_patch_baseline_approved_patches` - (Optional) A list of explicitly approved patches for the baseline. (`default = null`)
- `ssm_patch_baseline_rejected_patches` - (Optional) A list of rejected patches. (`default = null`)
- `ssm_patch_baseline_approved_patches_compliance_level` - (Optional) Defines the compliance level for approved patches. This means that if an approved patch is reported as missing, this is the severity of the compliance violation. Valid compliance levels include the following: CRITICAL, HIGH, MEDIUM, LOW, INFORMATIONAL, UNSPECIFIED. The default value is UNSPECIFIED. (`default = UNSPECIFIED`)
- `ssm_patch_baseline_global_filter` - (Optional) A set of global filters used to exclude patches from the baseline. Up to 4 global filters can be specified using Key/Value pairs. Valid Keys are PRODUCT | CLASSIFICATION | MSRC_SEVERITY | PATCH_ID. (`default = []`)
- `ssm_patch_baseline_approval_rule` - (Optional) A set of rules used to include patches in the baseline. up to 10 approval rules can be specified. (`default = []`)
- `enable_ssm_resource_data_sync` - Enable ssm resource data sync usage (`default = False`)
- `ssm_resource_data_sync_name` - Name for the configuration. (`default = ""`)
- `ssm_resource_data_sync_s3_destination` - (Required) Amazon S3 configuration details for the sync. (`default = []`)
- `enable_ssm_maintenance_window` - Enable ssm maintenance window usage (`default = False`)
- `ssm_maintenance_window_name` - The name of the maintenance window. (`default = ""`)
- `ssm_maintenance_window_schedule` - (Required) The schedule of the Maintenance Window in the form of a cron or rate expression. (`default = cron(0 16 ? * TUE *)`)
- `ssm_maintenance_window_duration` - (Required) The duration of the Maintenance Window in hours. (`default = 3`)
- `ssm_maintenance_window_cutoff` - (Required) The number of hours before the end of the Maintenance Window that Systems Manager stops scheduling new tasks for execution. (`default = 1`)
- `ssm_maintenance_window_description` - (Optional) A description for the maintenance window. (`default = null`)
- `ssm_maintenance_window_allow_unassociated_targets` - (Optional) Whether targets must be registered with the Maintenance Window before tasks can be defined for those targets. (`default = null`)
- `ssm_maintenance_window_enabled` - (Optional) Whether the maintenance window is enabled. Default: true. (`default = True`)
- `ssm_maintenance_window_end_date` - (Optional) Timestamp in ISO-8601 extended format when to no longer run the maintenance window. (`default = null`)
- `ssm_maintenance_window_schedule_timezone` - (Optional) Timezone for schedule in Internet Assigned Numbers Authority (IANA) Time Zone Database format. For example: America/Los_Angeles, etc/UTC, or Asia/Seoul. (`default = null`)
- `ssm_maintenance_window_start_date` - (Optional) Timestamp in ISO-8601 extended format when to begin the maintenance window. (`default = null`)
- `enable_ssm_maintenance_window_task` - Enable ssm maintenance window task (`default = False`)
- `ssm_maintenance_window_task_max_concurrency` - (Required) The maximum number of targets this task can be run for in parallel. (`default = 2`)
- `ssm_maintenance_window_task_max_errors` - (Required) The maximum number of errors allowed before this task stops being scheduled. (`default = 1`)
- `ssm_maintenance_window_task_priority` - (Optional) The priority of the task in the Maintenance Window, the lower the number the higher the priority. Tasks in a Maintenance Window are scheduled in priority order with tasks that have the same priority scheduled in parallel. (`default = 1`)
- `ssm_maintenance_window_task_service_role_arn` - (Required) The role that should be assumed when executing the task. (`default = ""`)
- `ssm_maintenance_window_task_task_arn` - (Required) The ARN of the task to execute. (`default = ""`)
- `ssm_maintenance_window_task_task_type` - (Required) The type of task being registered. The only allowed value is RUN_COMMAND. (`default = RUN_COMMAND`)
- `ssm_maintenance_window_task_window_id` - The Id of the maintenance window to register the task with. (`default = ""`)
- `ssm_maintenance_window_task_name` - (Optional) The name of the maintenance window task. (`default = ""`)
- `ssm_maintenance_window_task_description` - (Optional) The description of the maintenance window task. (`default = null`)
- `ssm_maintenance_window_task_targets` - (Required) The targets (either instances or window target ids). Instances are specified using Key=InstanceIds,Values=instanceid1,instanceid2. Window target ids are specified using Key=WindowTargetIds,Values=window target id1, window target id2. (`default = []`)
- `ssm_maintenance_window_task_task_invocation_parameters` - (Optional) Configuration block with parameters for task execution. (`default = []`)
- `enable_ssm_maintenance_window_target` - Enable ssm maintenance window target usage (`default = False`)
- `ssm_maintenance_window_target_name` - (Optional) The name of the maintenance window target. (`default = ""`)
- `ssm_maintenance_window_target_description` - (Optional) The description of the maintenance window target. (`default = null`)
- `ssm_maintenance_window_target_resource_type` - (Required) The type of target being registered with the Maintenance Window. Possible values INSTANCE. (`default = INSTANCE`)
- `ssm_maintenance_window_target_window_id` - The Id of the maintenance window to register the target with. (`default = ""`)
- `ssm_maintenance_window_target_owner_information` - (Optional) User-provided value that will be included in any CloudWatch events raised while running tasks for these targets in this Maintenance Window. (`default = null`)
- `ssm_maintenance_window_target_targets` - (Required) The targets (either instances or tags). Instances are specified using Key=InstanceIds,Values=InstanceId1,InstanceId2. Tags are specified using Key=tag name,Values=tag value. (`default = []`)

## Module Output Variables
----------------------
- `ssm_activation_id` - The activation ID.
- `ssm_activation_activation_code` - The code the system generates when it processes the activation.
- `ssm_activation_name` - The default name of the registered managed instance.
- `ssm_activation_description` - The description of the resource that was registered.
- `ssm_activation_expired` - If the current activation has expired.
- `ssm_activation_expiration_date` - The date by which this activation request should expire. The default value is 24 hours.
- `ssm_activation_iam_role` - The IAM Role attached to the managed instance.
- `ssm_activation_registration_limit` - The maximum number of managed instances you want to be registered. The default value is 1 instance.
- `ssm_activation_registration_count` - The number of managed instances that are currently registered using this activation.
- `ssm_association_association_id` - The ID of the SSM association.
- `ssm_association_instance_id` - The instance id that the SSM document was applied to.
- `ssm_association_name` - The name of the SSM document to apply.
- `ssm_association_parameters` - Additional parameters passed to the SSM document.
- `aws_ssm_document_created_date` - The date the document was created.
- `aws_ssm_document_description` - The description of the document.
- `aws_ssm_document_schema_version` - The schema version of the document.
- `aws_ssm_document_default_version` - The default version of the document.
- `aws_ssm_document_hash` - The sha1 or sha256 of the document content
- `aws_ssm_document_hash_type` - 'Sha1' 'Sha256'. The hashing algorithm used when hashing the content.
- `aws_ssm_document_latest_version` - The latest version of the document.
- `aws_ssm_document_owner` - The AWS user account of the person who created the document.
- `aws_ssm_document_status` - 'Creating', 'Active' or 'Deleting'. The current status of the document.
- `aws_ssm_document_parameter` - The parameters that are available to this document.
- `aws_ssm_document_platform_types` - A list of OS platforms compatible with this SSM document, either 'Windows' or 'Linux'.
- `aws_ssm_parameter_arn` - The ARN of the parameter.
- `aws_ssm_parameter_name` - (Required) The name of the parameter.
- `aws_ssm_parameter_description` - (Required) The description of the parameter.
- `aws_ssm_parameter_type` - (Required) The type of the parameter. Valid types are String, StringList and SecureString.
- `aws_ssm_parameter_value` - (Required) The value of the parameter.
- `aws_ssm_parameter_version` - The version of the parameter.
- `ssm_patch_group_id` - The ID of the patch baseline.
- `ssm_patch_baseline_id` - The ID of the patch baseline.
- `ssm_resource_data_sync_id` - The ID of the ssm resource data sync
- `ssm_maintenance_window_id` - The ID of the maintenance window.
- `ssm_maintenance_window_task_id` - The ID of the maintenance window task.
- `ssm_maintenance_window_target_id` - The ID of the maintenance window target.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
