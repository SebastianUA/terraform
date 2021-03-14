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
# AWS Codebuild project
#---------------------------------------------------
variable "enable_codebuild_project" {
  description = "Enable codebuild project usage"
  default     = false
}

variable "codebuild_project_name" {
  description = "Set name for CodeBuild project"
  default     = ""
}

variable "codebuild_project_service_role" {
  description = "(Required) The Amazon Resource Name (ARN) of the AWS Identity and Access Management (IAM) role that enables AWS CodeBuild to interact with dependent AWS services on behalf of the AWS account."
  default     = null
}

variable "codebuild_project_environment" {
  description = "(Required) Configuration block for environment."
  default     = {}
}

variable "codebuild_project_source" {
  description = "(Required) Configuration block for source."
  default     = {}
}

variable "codebuild_project_artifacts" {
  description = "(Required) Configuration block for artifacts."
  default     = {}
}

variable "codebuild_project_cache" {
  description = "(Optional) Information about the cache storage for the project."
  default     = []
}

variable "codebuild_project_logs_config" {
  description = "(Optional) Configuration for the builds to store log data to S3 or CloudWatch."
  default     = []
}

variable "codebuild_project_vpc_config" {
  description = "(Optional) Configuration for the builds to run inside a VPC."
  default     = []
}

variable "codebuild_project_secondary_artifacts" {
  description = "(Optional) A set of secondary artifacts to be used inside the build."
  default     = []
}

variable "codebuild_project_secondary_sources" {
  description = "(Optional) A set of secondary sources to be used inside the build."
  default     = []
}

variable "codebuild_project_description" {
  description = "(Optional) A short description of the project."
  default     = null
}

variable "codebuild_project_badge_enabled" {
  description = "(Optional) Generates a publicly-accessible URL for the projects build badge. Available as badge_url attribute when enabled."
  default     = null
}

variable "codebuild_project_build_timeout" {
  description = "(Optional) How long in minutes, from 5 to 480 (8 hours), for AWS CodeBuild to wait until timing out any related build that does not get marked as completed. The default is 60 minutes."
  default     = null
}

variable "codebuild_project_queued_timeout" {
  description = "(Optional) How long in minutes, from 5 to 480 (8 hours), a build is allowed to be queued before it times out. The default is 8 hours."
  default     = null
}

variable "codebuild_project_encryption_key" {
  description = "(Optional) The AWS Key Management Service (AWS KMS) customer master key (CMK) to be used for encrypting the build project's build output artifacts."
  default     = null
}

variable "codebuild_project_source_version" {
  description = "(Optional) A version of the build input to be built for this project. If not specified, the latest version is used."
  default     = null
}

#---------------------------------------------------
# AWS Codebuild source credential
#---------------------------------------------------
variable "enable_codebuild_source_credential" {
  description = "Enable codebuild source credential usage"
  default     = false
}

variable "codebuild_source_credential_auth_type" {
  description = "(Required) The type of authentication used to connect to a GitHub, GitHub Enterprise, or Bitbucket repository. An OAUTH connection is not supported by the API. Ex: PERSONAL_ACCESS_TOKEN"
  default     = null
}

variable "codebuild_source_credential_server_type" {
  description = "(Required) The source provider used for this project. Ex: GITHUB"
  default     = null
}

variable "codebuild_source_credential_token" {
  description = "(Required) For GitHub or GitHub Enterprise, this is the personal access token. For Bitbucket, this is the app password."
  default     = null
}

variable "codebuild_source_credential_user_name" {
  description = "(Optional) The Bitbucket username when the authType is BASIC_AUTH. This parameter is not valid for other types of source providers or connections."
  default     = null
}

#---------------------------------------------------
# AWS Codebuild webhook
#---------------------------------------------------
variable "enable_codebuild_webhook" {
  description = "Enable codebuild webhook usage"
  default     = false
}

variable "codebuild_webhook_project_name" {
  description = "The name of the build project."
  default     = ""
}

variable "codebuild_webhook_branch_filter" {
  description = "(Optional) A regular expression used to determine which branches get built. Default is all branches are built. It is recommended to use filter_group over branch_filter."
  default     = null
}

variable "codebuild_webhook_filter_group" {
  description = "(Optional) Information about the webhook's trigger"
  default     = []
}

#---------------------------------------------------
# AWS Codebuild report group
#---------------------------------------------------
variable "enable_codebuild_report_group" {
  description = "Enable codebuild report group usage"
  default     = false
}

variable "codebuild_report_group_stack" {
  description = "Set properties for codebuild report group"
  default     = []
}
