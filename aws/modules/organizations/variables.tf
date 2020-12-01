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

#---------------------------------------------------
# AWS organizations account
#---------------------------------------------------
variable "enable_organizations_account" {
  description = "Enable organizations account usage"
  default     = false
}

variable "organizations_account_name" {
  description = "A friendly name for the member account."
  default     = ""
}

variable "organizations_account_email" {
  description = "(Required) The email address of the owner to assign to the new member account. This email address must not already be associated with another AWS account."
  default     = null
}

variable "organizations_account_iam_user_access_to_billing" {
  description = "(Optional) If set to ALLOW, the new account enables IAM users to access account billing information if they have the required permissions. If set to DENY, then only the root user of the new account can access account billing information."
  default     = null
}

variable "organizations_account_parent_id" {
  description = "(Optional) Parent Organizational Unit ID or Root ID for the account. Defaults to the Organization default Root ID. A configuration must be present for this argument to perform drift detection."
  default     = null
}

variable "organizations_account_role_name" {
  description = "(Optional) The name of an IAM role that Organizations automatically preconfigures in the new member account. This role trusts the master account, allowing users in the master account to assume the role, as permitted by the master account administrator. The role has administrator permissions in the new member account. The Organizations API provides no method for reading this information after account creation, so Terraform cannot perform drift detection on its value and will always show a difference for a configured value after import unless ignore_changes is used."
  default     = null
}

#---------------------------------------------------
# AWS organizations organizational
#---------------------------------------------------

variable "enable_organizations_organization" {
  description = "Enable organizations organization usage"
  default     = false
}

variable "organizations_organization_aws_service_access_principals" {
  description = "(Optional) List of AWS service principal names for which you want to enable integration with your organization. This is typically in the form of a URL, such as service-abbreviation.amazonaws.com. Organization must have feature_set set to ALL. For additional information, see the AWS Organizations User Guide."
  default     = ["ALL"]
}

variable "organizations_organization_enabled_policy_types" {
  description = "(Optional) List of Organizations policy types to enable in the Organization Root. Organization must have feature_set set to ALL. For additional information about valid policy types (e.g. BACKUP_POLICY, SERVICE_CONTROL_POLICY, and TAG_POLICY), see the AWS Organizations API Reference."
  default     = ["SERVICE_CONTROL_POLICY", "BACKUP_POLICY", ""]
}

variable "organizations_organization_feature_set" {
  description = "(Optional) Specify 'ALL' (default) or 'CONSOLIDATED_BILLING'."
  default     = "ALL"
}

#---------------------------------------------------
# AWS organizations organizational unit
#---------------------------------------------------
variable "enable_organizations_organizational_unit" {
  description = "Enable organizations organizational unit usage"
  default     = false
}

variable "organizations_organizational_unit_name" {
  description = "The name for the organizational unit"
  default     = ""
}

variable "organizations_organizational_unit_parent_id" {
  description = "ID of the parent organizational unit, which may be the root"
  default     = ""
}

#---------------------------------------------------
# AWS organizations policy
#---------------------------------------------------
variable "enable_organizations_policy" {
  description = "Enable organizations policy usage"
  default     = false
}

variable "organizations_policy_name" {
  description = "The friendly name to assign to the policy."
  default     = ""
}

variable "organizations_policy_content" {
  description = "(Required) The policy content to add to the new policy. For example, if you create a service control policy (SCP), this string must be JSON text that specifies the permissions that admins in attached accounts can delegate to their users, groups, and roles. For more information about the SCP syntax, see the Service Control Policy Syntax documentation and for more information on the Tag Policy syntax, see the Tag Policy Syntax documentation."
  default     = null
}

variable "organizations_policy_description" {
  description = "(Optional) A description to assign to the policy."
  default     = null
}

variable "organizations_policy_type" {
  description = "(Optional) The type of policy to create. Valid values are AISERVICES_OPT_OUT_POLICY, BACKUP_POLICY, SERVICE_CONTROL_POLICY (SCP), and TAG_POLICY. Defaults to SERVICE_CONTROL_POLICY."
  default     = "SERVICE_CONTROL_POLICY"
}

#---------------------------------------------------
# AWS organizations policy attachment
#---------------------------------------------------
variable "enable_organizations_policy_attachment" {
  description = "Enable organizations policy attachment"
  default     = false
}

variable "organizations_policy_attachment_policy_id" {
  description = "(Required) The unique identifier (ID) of the policy that you want to attach to the target."
  default     = ""
}

variable "organizations_policy_attachment_target_id" {
  description = "(Required) The unique identifier (ID) of the root, organizational unit, or account number that you want to attach the policy to."
  default     = ""
}
