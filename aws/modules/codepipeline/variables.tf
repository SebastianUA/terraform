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
# AWS codepipeline
#---------------------------------------------------
variable "enable_codepipeline" {
  description   = "Enable codepipeline usage"
  default       = false
}

variable "codepipeline_name" {
  description   = " The name of the pipeline."
  default       = ""
}

variable "codepipeline_role_arn" {
  description   = "(Required) A service role Amazon Resource Name (ARN) that grants AWS CodePipeline permission to make calls to AWS services on your behalf."
  default       = ""
}

variable "codepipeline_artifact_store_location" {
  description   = "(Required) The location where AWS CodePipeline stores artifacts for a pipeline; currently only S3 is supported."
  default       = ""
}

variable "codepipeline_artifact_store_type" {
  description   = "(Required) The type of the artifact store, such as Amazon S3"
  default       = "S3"
}

variable "codepipeline_artifact_store_region" {
  description   = "(Optional) The region where the artifact store is located. Required for a cross-region CodePipeline, do not provide for a single-region CodePipeline."
  default       = null
}

variable "codepipeline_artifact_store_encryption_key" {
  description   = "(Optional) The encryption key block AWS CodePipeline uses to encrypt the data in the artifact store, such as an AWS Key Management Service (AWS KMS) key. If you don't specify a key, AWS CodePipeline uses the default key for Amazon Simple Storage Service (Amazon S3)."
  default       = []
}

#--------- state 1
variable "codepipeline_stage1_name" {
  description = "The name of the stage."
  default     = "Source"
}

variable "codepipeline_stage1_action_name" {
  description = "The action declaration's name."
  default     = "Source"
}

variable "codepipeline_stage1_action_category" {
  description = "(Required) A category defines what kind of action can be taken in the stage, and constrains the provider type for the action. Possible values are Approval, Build, Deploy, Invoke, Source and Test"
  default     = "Source"
}

variable "codepipeline_stage1_action_owner" {
  description = "(Required) The creator of the action being called. Possible values are AWS, Custom and ThirdParty."
  default     = "AWS"
}

variable "codepipeline_stage1_action_provider" {
  description = "(Required) The provider of the service being called by the action. Valid providers are determined by the action category. For example, an action in the Deploy category type might have a provider of AWS CodeDeploy, which would be specified as CodeDeploy."
  default     = "CodeCommit"
}

variable "codepipeline_stage1_action_version" {
  description = "(Required) A string that identifies the action type."
  default     = "1"
}

variable "codepipeline_stage1_action_configuration" {
  description = "(Optional) A Map of the action declaration's configuration. Find out more about configuring action configurations in the Reference Pipeline Structure documentation."
  default     = null
}

variable "codepipeline_stage1_action_input_artifacts" {
  description = "(Optional) A list of artifact names to be worked on."
  default     = null
}

variable "codepipeline_stage1_action_output_artifacts" {
  description = "(Optional) A list of artifact names to output. Output artifact names must be unique within a pipeline."
  default     = null
}

variable "codepipeline_stage1_action_role_arn" {
  description = "(Optional) The ARN of the IAM service role that will perform the declared action. This is assumed through the roleArn for the pipeline."
  default     = null
}

variable "codepipeline_stage1_action_run_order" {
  description = "(Optional) The order in which actions are run."
  default     = null
}

variable "codepipeline_stage1_action_region" {
  description = "(Optional) The region in which to run the action."
  default     = null
}

#--------- state 2
variable "codepipeline_stage2_name" {
  description = "The name of the stage."
  default     = "Build"
}

variable "codepipeline_stage2_action_name" {
  description = "The action declaration's name."
  default     = "Build"
}

variable "codepipeline_stage2_action_category" {
  description = "(Required) A category defines what kind of action can be taken in the stage, and constrains the provider type for the action. Possible values are Approval, Build, Deploy, Invoke, Source and Test"
  default     = "Build"
}

variable "codepipeline_stage2_action_owner" {
  description = "(Required) The creator of the action being called. Possible values are AWS, Custom and ThirdParty."
  default     = "AWS"
}

variable "codepipeline_stage2_action_provider" {
  description = "(Required) The provider of the service being called by the action. Valid providers are determined by the action category. For example, an action in the Deploy category type might have a provider of AWS CodeDeploy, which would be specified as CodeDeploy."
  default     = "CodeBuild"
}

variable "codepipeline_stage2_action_version" {
  description = "(Required) A string that identifies the action type."
  default     = "1"
}

variable "codepipeline_stage2_action_configuration" {
  description = "(Optional) A Map of the action declaration's configuration. Find out more about configuring action configurations in the Reference Pipeline Structure documentation."
  default     = null
}

variable "codepipeline_stage2_action_input_artifacts" {
  description = "(Optional) A list of artifact names to be worked on."
  default     = null
}

variable "codepipeline_stage2_action_output_artifacts" {
  description = "(Optional) A list of artifact names to output. Output artifact names must be unique within a pipeline."
  default     = null
}

variable "codepipeline_stage2_action_role_arn" {
  description = "(Optional) The ARN of the IAM service role that will perform the declared action. This is assumed through the roleArn for the pipeline."
  default     = null
}

variable "codepipeline_stage2_action_run_order" {
  description = "(Optional) The order in which actions are run."
  default     = null
}

variable "codepipeline_stage2_action_region" {
  description = "(Optional) The region in which to run the action."
  default     = null
}

#--------- state 3
variable "codepipeline_stage3_name" {
  description = "The name of the stage."
  default     = "Deploy"
}

variable "codepipeline_stage3_action_name" {
  description = "The action declaration's name."
  default     = "Deploy"
}

variable "codepipeline_stage3_action_category" {
  description = "(Required) A category defines what kind of action can be taken in the stage, and constrains the provider type for the action. Possible values are Approval, Build, Deploy, Invoke, Source and Test"
  default     = "Deploy"
}

variable "codepipeline_stage3_action_owner" {
  description = "(Required) The creator of the action being called. Possible values are AWS, Custom and ThirdParty."
  default     = "AWS"
}

variable "codepipeline_stage3_action_provider" {
  description = "(Required) The provider of the service being called by the action. Valid providers are determined by the action category. For example, an action in the Deploy category type might have a provider of AWS CodeDeploy, which would be specified as CodeDeploy."
  default     = "ECS"
}

variable "codepipeline_stage3_action_version" {
  description = "(Required) A string that identifies the action type."
  default     = "1"
}

variable "codepipeline_stage3_action_configuration" {
  description = "(Optional) A Map of the action declaration's configuration. Find out more about configuring action configurations in the Reference Pipeline Structure documentation."
  default     = null
}

variable "codepipeline_stage3_action_input_artifacts" {
  description = "(Optional) A list of artifact names to be worked on."
  default     = null
}

variable "codepipeline_stage3_action_output_artifacts" {
  description = "(Optional) A list of artifact names to output. Output artifact names must be unique within a pipeline."
  default     = null
}

variable "codepipeline_stage3_action_role_arn" {
  description = "(Optional) The ARN of the IAM service role that will perform the declared action. This is assumed through the roleArn for the pipeline."
  default     = null
}

variable "codepipeline_stage3_action_run_order" {
  description = "(Optional) The order in which actions are run."
  default     = null
}

variable "codepipeline_stage3_action_region" {
  description = "(Optional) The region in which to run the action."
  default     = null
}

#---------------------------------------------------
# AWS codepipeline webhook
#---------------------------------------------------
variable "enable_codepipeline_webhook" {
  description   = "Enable codepipeline webhook usage"
  default       = false
}

variable "codepipeline_webhook_name" {
  description   = "The name of the webhook."
  default       = ""
}

variable "codepipeline_webhook_authentication" {
  description   = "(Required) The type of authentication to use. One of IP, GITHUB_HMAC, or UNAUTHENTICATED."
  default       = "GITHUB_HMAC"
}

variable "codepipeline_webhook_target_action" {
  description   = "(Required) The name of the action in a pipeline you want to connect to the webhook. The action must be from the source (first) stage of the pipeline."
  default       = ""
}

variable "codepipeline_webhook_target_pipeline" {
  description   = "The name of the pipeline."
  default       = ""
}

variable "codepipeline_webhook_authentication_configuration" {
  description   = "(Optional) An auth block. Required for IP and GITHUB_HMAC."
  default       = []
}

variable "codepipeline_webhook_filter1_json_path" {
  description = "(Required) The JSON path to filter on."
  default     = "$.ref"
}

variable "codepipeline_webhook_filter1_match_equals" {
  description = "(Required) The value to match on (e.g. refs/heads/{Branch}). See AWS docs for details."
  default     = "refs/heads/{Branch}"
}
