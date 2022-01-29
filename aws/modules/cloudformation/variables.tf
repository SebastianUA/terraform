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
  description = "Add additional tags"
  default     = {}
}

#---------------------------------------------------
# AWS cloudformation
#---------------------------------------------------
variable "enable_cloudformation_stack" {
  description = "Enable cloudformation stack usage"
  default     = false
}

variable "cloudformation_stack_name" {
  description = "Stack name."
  default     = ""
}

variable "cloudformation_stack_template_body" {
  description = "(Optional) Structure containing the template body (max size: 51,200 bytes)."
  default     = null
}

variable "cloudformation_stack_template_url" {
  description = "(Optional) Location of a file containing the template body (max size: 460,800 bytes)."
  default     = null
}

variable "cloudformation_stack_capabilities" {
  description = "(Optional) A list of capabilities. Valid values: CAPABILITY_IAM, CAPABILITY_NAMED_IAM, or CAPABILITY_AUTO_EXPAND"
  default     = null
}

variable "cloudformation_stack_disable_rollback" {
  description = "(Optional) Set to true to disable rollback of the stack if stack creation failed. Conflicts with on_failure."
  default     = null
}

variable "cloudformation_stack_notification_arns" {
  description = "(Optional) A list of SNS topic ARNs to publish stack related events."
  default     = null
}

variable "cloudformation_stack_on_failure" {
  description = "(Optional) Action to be taken if stack creation fails. This must be one of: DO_NOTHING, ROLLBACK, or DELETE. Conflicts with disable_rollback."
  default     = null
}

variable "cloudformation_stack_policy_body" {
  description = "(Optional) Structure containing the stack policy body. Conflicts w/ policy_url."
  default     = null
}

variable "cloudformation_stack_policy_url" {
  description = "(Optional) Location of a file containing the stack policy. Conflicts w/ policy_body."
  default     = null
}

variable "cloudformation_stack_iam_role_arn" {
  description = "(Optional) The ARN of an IAM role that AWS CloudFormation assumes to create the stack. If you don't specify a value, AWS CloudFormation uses the role that was previously associated with the stack. If no role is available, AWS CloudFormation uses a temporary session that is generated from your user credentials."
  default     = null
}

variable "cloudformation_stack_timeout_in_minutes" {
  description = "(Optional) The amount of time that can pass before the stack status becomes CREATE_FAILED."
  default     = null
}

variable "cloudformation_stack_parameters" {
  description = "(Optional) A map of Parameter structures that specify input parameters for the stack."
  default     = null
}

#---------------------------------------------------
# AWS cloudformation stack set
#---------------------------------------------------
variable "enable_cloudformation_stack_set" {
  description = "Enable cloudformation stack set usage"
  default     = false
}

variable "cloudformation_stack_set_name" {
  description = "Name of the Stack Set. The name must be unique in the region where you create your Stack Set. The name can contain only alphanumeric characters (case-sensitive) and hyphens. It must start with an alphabetic character and cannot be longer than 128 characters."
  default     = ""
}

variable "cloudformation_stack_set_administration_role_arn" {
  description = "(Required) Amazon Resource Number (ARN) of the IAM Role in the administrator account."
  default     = ""
}

variable "cloudformation_stack_set_capabilities" {
  description = "(Optional) A list of capabilities. Valid values: CAPABILITY_IAM, CAPABILITY_NAMED_IAM, CAPABILITY_AUTO_EXPAND."
  default     = null
}

variable "cloudformation_stack_set_description" {
  description = "(Optional) Description of the Stack Set."
  default     = null
}

variable "cloudformation_stack_set_execution_role_name" {
  description = "(Optional) Name of the IAM Role in all target accounts for Stack Set operations. Defaults to AWSCloudFormationStackSetExecutionRole."
  default     = null
}

variable "cloudformation_stack_set_parameters" {
  description = "(Optional) Key-value map of input parameters for the Stack Set template. All template parameters, including those with a Default, must be configured or ignored with lifecycle configuration block ignore_changes argument. All NoEcho template parameters must be ignored with the lifecycle configuration block ignore_changes argument."
  default     = null
}

variable "cloudformation_stack_set_template_body" {
  description = "(Optional) String containing the CloudFormation template body. Maximum size: 51,200 bytes. Conflicts with template_url."
  default     = null
}

variable "cloudformation_stack_set_template_url" {
  description = "(Optional) String containing the location of a file containing the CloudFormation template body. The URL must point to a template that is located in an Amazon S3 bucket. Maximum location file size: 460,800 bytes. Conflicts with template_body."
  default     = null
}

variable "cloudformation_stack_set_timeouts" {
  description = "Set timeouts for cloudformation stack set"
  default     = {}
}

#---------------------------------------------------
# AWS cloudformation stack set instance
#---------------------------------------------------
variable "enable_cloudformation_stack_set_instance" {
  description = "Enable cloudformation stack set instance usage"
  default     = false
}

variable "cloudformation_stack_set_instance_stack_set_name" {
  description = "Name of the Stack Set."
  default     = ""
}

variable "cloudformation_stack_set_instance_account_id" {
  description = "(Optional) Target AWS Account ID to create a Stack based on the Stack Set. Defaults to current account."
  default     = null
}

variable "cloudformation_stack_set_instance_parameter_overrides" {
  description = "(Optional) Key-value map of input parameters to override from the Stack Set for this Instance."
  default     = null
}

variable "cloudformation_stack_set_instance_retain_stack" {
  description = "(Optional) During Terraform resource destroy, remove Instance from Stack Set while keeping the Stack and its associated resources. Must be enabled in Terraform state before destroy operation to take effect. You cannot reassociate a retained Stack or add an existing, saved Stack to a new Stack Set. Defaults to false."
  default     = false
}

variable "cloudformation_stack_set_instance_timeouts" {
  description = "Set timeouts for cloudformation stack set instance"
  default     = {}
}
