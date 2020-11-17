#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.13.5"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
  profile                 = "default"
}

module "s3" {
  source      = "../../modules/s3"
  name        = "TEST"
  environment = "stage"

  enable_s3_bucket    = true
  s3_bucket_name      = "codepipeline-artifacts-bucket"
  s3_bucket_acl       = "private"
  s3_bucket_cors_rule = []

  s3_bucket_versioning  = []
  enable_lifecycle_rule = true

  # Add policy to the bucket
  enable_s3_bucket_policy = false

  tags = map("Env", "stage", "Orchestration", "Terraform")

}

module "kms" {
  source      = "../../modules/kms"
  name        = "test"
  environment = "stage"

  enable_kms_key = true
  kms_key_name   = "codepipeline-kms"
}

module "codecommit" {
  source      = "../../modules/codecommit"
  name        = "TEST"
  environment = "stage"

  enable_codecommit_repository = true
  codecommit_repository_name   = "myrepo"

  enable_codecommit_trigger          = false
  codecommit_trigger_name            = ""
  codecommit_trigger_destination_arn = ""
  codecommit_trigger_branches        = []
  codecommit_trigger_events          = ["all"]

  tags = map("Env", "stage", "Orchestration", "Terraform")
}

module "codebuild" {
  source      = "../../modules/codebuild"
  name        = "TEST"
  environment = "stage"

  # Project
  enable_codebuild_project         = true
  codebuild_project_name           = ""
  codebuild_project_description    = "My first codebuild project"
  codebuild_project_service_role   = "arn:aws:iam::167127734783:role/admin-role"
  codebuild_project_build_timeout  = 60
  codebuild_project_queued_timeout = 480

  ## artifacts
  codebuild_project_artifacts_name                   = null
  codebuild_project_artifacts_override_artifact_name = true
  codebuild_project_artifacts_type                   = "S3" #NO_ARTIFACTS or CODEPIPELINE
  codebuild_project_artifacts_location               = module.s3.s3_bucket_id

  ## source
  codebuild_project_source_type            = "CODECOMMIT"
  codebuild_project_source_location        = module.codecommit.codecommit_repository_clone_url_http
  codebuild_project_source_git_clone_depth = 1
  codebuild_project_source_version         = null # will be latest

  ## caches
  codebuild_project_cache = [{
    type  = "LOCAL"
    modes = ["LOCAL_DOCKER_LAYER_CACHE", "LOCAL_SOURCE_CACHE"]
  }]

  ## environment
  codebuild_project_environment_compute_type    = "BUILD_GENERAL1_SMALL"
  codebuild_project_environment_image           = "aws/codebuild/standard:4.0"
  codebuild_project_environment_type            = "LINUX_CONTAINER"
  codebuild_project_environment_privileged_mode = false

  tags = map("Env", "stage", "Orchestration", "Terraform")
}

module "codepipeline" {
  source      = "../../modules/codepipeline"
  name        = "TEST"
  environment = "stage"

  # Pipeline
  enable_codepipeline   = true
  codepipeline_name     = ""
  codepipeline_role_arn = "arn:aws:iam::167127734783:role/admin-role"

  ## artifact
  codepipeline_artifact_store_type     = "S3"
  codepipeline_artifact_store_location = module.s3.s3_bucket_id
  codepipeline_artifact_store_encryption_key = [{
    id   = module.kms.kms_key_arn
    type = "KMS"
  }]

  ## stages & actions
  ### stage 1
  codepipeline_stage1_name            = "Source"
  codepipeline_stage1_action_name     = "Source"
  codepipeline_stage1_action_category = "Source"
  codepipeline_stage1_action_owner    = "AWS"
  codepipeline_stage1_action_provider = "CodeCommit"
  codepipeline_stage1_action_version  = 1
  codepipeline_stage1_action_configuration = {
    RepositoryName = module.codecommit.codecommit_repository_name
    BranchName     = "master"
  }
  codepipeline_stage1_action_output_artifacts = ["Source"]

  ### stage 2
  codepipeline_stage2_name            = "Build"
  codepipeline_stage2_action_name     = "Build"
  codepipeline_stage2_action_category = "Build"
  codepipeline_stage2_action_owner    = "AWS"
  codepipeline_stage2_action_provider = "CodeBuild"
  codepipeline_stage2_action_version  = "1"
  codepipeline_stage2_action_configuration = {
    ProjectName = module.codebuild.codebuild_project_id
  }
  codepipeline_stage2_action_input_artifacts  = ["Source"]
  codepipeline_stage2_action_output_artifacts = ["Build"]

  ### stage 3
  codepipeline_stage3_name            = "Deploy"
  codepipeline_stage3_action_name     = "Deploy"
  codepipeline_stage3_action_category = "Deploy"
  codepipeline_stage3_action_owner    = "AWS"
  codepipeline_stage3_action_provider = "ECS"
  codepipeline_stage3_action_version  = "1"
  codepipeline_stage3_action_configuration = {
    ClusterName = "ecs-cluster-name"
    ServiceName = "ecs-service-name"
  }
  codepipeline_stage3_action_input_artifacts = ["Build"]

  # Pipeline webhook
  enable_codepipeline_webhook         = false
  codepipeline_webhook_name           = ""
  codepipeline_webhook_authentication = "GITHUB_HMAC"
  codepipeline_webhook_target_action  = "Source"
  codepipeline_webhook_authentication_configuration = [{
    secret_token = "mysecret_here"
  }]

  codepipeline_webhook_filter1_json_path    = "$.ref"
  codepipeline_webhook_filter1_match_equals = "refs/heads/{Branch}"

  tags = map("Env", "stage", "Orchestration", "Terraform")
}
