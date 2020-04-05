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
  description   = "Enable codebuild project usage"
  default       = false
}

variable "codebuild_project_name" {
  description   = "description"
  default       = ""
}

variable "codebuild_project_service_role" {
  description   = "(Required) The Amazon Resource Name (ARN) of the AWS Identity and Access Management (IAM) role that enables AWS CodeBuild to interact with dependent AWS services on behalf of the AWS account."
  default       = null
}

variable "codebuild_project_artifacts_type" {
  description   = "(Required) The build output artifact's type. Valid values for this parameter are: CODEPIPELINE, NO_ARTIFACTS or S3."
  default       = "NO_ARTIFACTS"
}

variable "codebuild_project_artifacts_artifact_identifier" {
  description   = "(Optional) The artifact identifier. Must be the same specified inside AWS CodeBuild buildspec."
  default       = null
}

variable "codebuild_project_artifacts_encryption_disabled" {
  description   = "(Optional) If set to true, output artifacts will not be encrypted. If type is set to NO_ARTIFACTS then this value will be ignored. Defaults to false."
  default       = null
}

variable "codebuild_project_artifacts_override_artifact_name" {
  description   = "(Optional) If set to true, a name specified in the build spec file overrides the artifact name."
  default       = null
}

variable "codebuild_project_artifacts_location" {
  description   = "(Optional) Information about the build output artifact location. If type is set to CODEPIPELINE or NO_ARTIFACTS then this value will be ignored. If type is set to S3, this is the name of the output bucket."
  default       = null
}

variable "codebuild_project_artifacts_name" {
  description   = "(Optional) The name of the project. If type is set to S3, this is the name of the output artifact object"
  default       = null
}

variable "codebuild_project_artifacts_namespace_type" {
  description   = "(Optional) The namespace to use in storing build artifacts. If type is set to S3, then valid values for this parameter are: BUILD_ID or NONE."
  default       = null
}

variable "codebuild_project_artifacts_packaging" {
  description   = "(Optional) The type of build output artifact to create. If type is set to S3, valid values for this parameter are: NONE or ZIP"
  default       = null
}

variable "codebuild_project_artifacts_path" {
  description   = "(Optional) If type is set to S3, this is the path to the output artifact"
  default       = null
}

variable "codebuild_project_source_type" {
  description   = "(Required) The type of repository that contains the source code to be built. Valid values for this parameter are: CODECOMMIT, CODEPIPELINE, GITHUB, GITHUB_ENTERPRISE, BITBUCKET, S3 or NO_SOURCE."
  default       = "CODECOMMIT"
}

variable "codebuild_project_source_auth_type" {
  description   = "(Required) The authorization type to use. The only valid value is OAUTH"
  default       = "OAUTH"
}

variable "codebuild_project_source_auth_resource" {
  description   = "(Optional) The resource value that applies to the specified authorization type."
  default       = null
}

variable "codebuild_project_source_buildspec" {
  description   = "(Optional) The build spec declaration to use for this build project's related builds."
  default       = null
}

variable "codebuild_project_source_git_clone_depth" {
  description   = "(Optional) Truncate git history to this many commits."
  default       = null
}

variable "codebuild_project_source_git_submodules_config_fetch_submodules" {
  description   = "(Required) If set to true, fetches Git submodules for the AWS CodeBuild build project."
  default       = true
}

variable "codebuild_project_source_insecure_ssl" {
  description   = "(Optional) Ignore SSL warnings when connecting to source control."
  default       = null
}

variable "codebuild_project_source_location" {
  description   = "(Optional) The location of the source code from git or s3."
  default       = null
}

variable "codebuild_project_source_report_build_status" {
  description   = "(Optional) Set to true to report the status of a build's start and finish to your source provider. This option is only valid when your source provider is GITHUB, BITBUCKET, or GITHUB_ENTERPRISE."
  default       = null
}

variable "codebuild_project_environment_compute_type" {
  description   = "(Required) Information about the compute resources the build project will use. Available values for this parameter are: BUILD_GENERAL1_SMALL, BUILD_GENERAL1_MEDIUM, BUILD_GENERAL1_LARGE or BUILD_GENERAL1_2XLARGE. BUILD_GENERAL1_SMALL is only valid if type is set to LINUX_CONTAINER. When type is set to LINUX_GPU_CONTAINER, compute_type need to be BUILD_GENERAL1_LARGE."
  default       = "BUILD_GENERAL1_SMALL"
}

variable "codebuild_project_environment_image" {
  description   = "(Required) The Docker image to use for this build project. Valid values include Docker images provided by CodeBuild (e.g aws/codebuild/standard:2.0), Docker Hub images (e.g. hashicorp/terraform:latest), and full Docker repository URIs such as those for ECR (e.g. 137112412989.dkr.ecr.us-west-2.amazonaws.com/amazonlinux:latest)."
  default       = "aws/codebuild/standard:4.0"
}

variable "codebuild_project_environment_type" {
  description   = "(Required) The type of build environment to use for related builds. Available values are: LINUX_CONTAINER, LINUX_GPU_CONTAINER, WINDOWS_CONTAINER or ARM_CONTAINER."
  default       = "LINUX_CONTAINER"
}

variable "codebuild_project_environment_image_pull_credentials_type" {
  description   = "(Optional) The type of credentials AWS CodeBuild uses to pull images in your build. Available values for this parameter are CODEBUILD or SERVICE_ROLE. When you use a cross-account or private registry image, you must use SERVICE_ROLE credentials. When you use an AWS CodeBuild curated image, you must use CODEBUILD credentials. Default to CODEBUILD"
  default       = "CODEBUILD"
}

variable "codebuild_project_environment_privileged_mode" {
  description   = "(Optional) If set to true, enables running the Docker daemon inside a Docker container. Defaults to false."
  default       = false
}

variable "codebuild_project_environment_certificate" {
  description   = "(Optional) The ARN of the S3 bucket, path prefix and object key that contains the PEM-encoded certificate."
  default       = null
}

variable "codebuild_project_environment_registry_credential" {
  description   = "(Optional) Information about credentials for access to a private Docker registry."
  default       = []
}

variable "codebuild_project_environment_variable" {
  description   = "(Optional) A set of environment variables to make available to builds for this build project."
  default       = []
}

variable "codebuild_project_description" {
  description   = "(Optional) A short description of the project."
  default       = null
}

variable "codebuild_project_badge_enabled" {
  description   = "(Optional) Generates a publicly-accessible URL for the projects build badge. Available as badge_url attribute when enabled."
  default       = null
}

variable "codebuild_project_build_timeout" {
  description   = "(Optional) How long in minutes, from 5 to 480 (8 hours), for AWS CodeBuild to wait until timing out any related build that does not get marked as completed. The default is 60 minutes."
  default       = 60
}

variable "codebuild_project_queued_timeout" {
  description   = "(Optional) How long in minutes, from 5 to 480 (8 hours), a build is allowed to be queued before it times out. The default is 8 hours."
  default       = 480
}

variable "codebuild_project_cache" {
  description   = "(Optional) Information about the cache storage for the project."
  default       = []
}

variable "codebuild_project_encryption_key" {
  description   = "(Optional) The AWS Key Management Service (AWS KMS) customer master key (CMK) to be used for encrypting the build project's build output artifacts."
  default       = null
}

variable "codebuild_project_s3_logs_config" {
  description   = "(Optional) Configuration for the builds to store log data to S3."
  default       = []
}

variable "codebuild_project_cw_logs_config" {
  description   = "(Optional) Configuration for the builds to store log data to CloudWatch."
  default       = []
}

variable "codebuild_project_source_version" {
  description   = "(Optional) A version of the build input to be built for this project. If not specified, the latest version is used."
  default       = null
}

variable "codebuild_project_vpc_config" {
  description   = "(Optional) Configuration for the builds to run inside a VPC."
  default       = []
}

variable "codebuild_project_secondary_artifacts" {
  description   = "description"
  default       = []
}

variable "codebuild_project_secondary_sources" {
  description   = "(Optional) A set of secondary sources to be used inside the build."
  default       = []
}

variable "codebuild_project_secondary_sources_auth_type" {
  description   = "(Required) The authorization type to use. The only valid value is OAUTH"
  default       = "OAUTH"
}

variable "codebuild_project_secondary_sources_auth_resource" {
  description   = "(Optional) The resource value that applies to the specified authorization type."
  default       = null
}

variable "codebuild_project_secondary_sources_git_submodules_config_fetch_submodules" {
  description   = "If set to true, fetches Git submodules for the AWS CodeBuild build project."
  default       = true
}

#---------------------------------------------------
# AWS Codebuild source credential
#---------------------------------------------------
variable "enable_codebuild_source_credential" {
  description   = "Enable codebuild source credential usage"
  default       = false
}

variable "codebuild_source_credential_auth_type" {
  description   = "(Required) The type of authentication used to connect to a GitHub, GitHub Enterprise, or Bitbucket repository. An OAUTH connection is not supported by the API. Ex: PERSONAL_ACCESS_TOKEN"
  default       = null
}

variable "codebuild_source_credential_server_type" {
  description   = "(Required) The source provider used for this project. Ex: GITHUB"
  default       = null
}

variable "codebuild_source_credential_token" {
  description   = "(Required) For GitHub or GitHub Enterprise, this is the personal access token. For Bitbucket, this is the app password."
  default       = null
}

variable "codebuild_source_credential_user_name" {
  description   = "(Optional) The Bitbucket username when the authType is BASIC_AUTH. This parameter is not valid for other types of source providers or connections."
  default       = null
}

#---------------------------------------------------
# AWS Codebuild webhook
#---------------------------------------------------
variable "enable_codebuild_webhook" {
  description   = "Enable codebuild webhook usage"
  default       = false
}

variable "codebuild_webhook_project_name" {
  description   = "The name of the build project."
  default       = ""
}

variable "codebuild_webhook_branch_filter" {
  description   = "(Optional) A regular expression used to determine which branches get built. Default is all branches are built. It is recommended to use filter_group over branch_filter."
  default       = null
}

variable "codebuild_webhook_filter_group" {
  description   = "(Optional) Information about the webhook's trigger"
  default       = []
}
