#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.13"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
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
  codebuild_project_artifacts_name = null
  codebuild_project_artifacts_type = "NO_ARTIFACTS" #CODEPIPELINE

  ## source
  codebuild_project_source_type            = "CODECOMMIT"
  codebuild_project_source_location        = module.codecommit.codecommit_repository_clone_url_http #https://git-codecommit.us-east-1.amazonaws.com/v1/repos/myrepo.git
  codebuild_project_source_git_clone_depth = 1
  codebuild_project_source_version         = "master"

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

  # Creds
  enable_codebuild_source_credential      = false
  codebuild_source_credential_auth_type   = "PERSONAL_ACCESS_TOKEN"
  codebuild_source_credential_server_type = "GITHUB" #GITHUB BITBUCKET GITHUB_ENTERPRISE
  codebuild_source_credential_token       = "token_here"

  # Webhook
  enable_codebuild_webhook = false
  codebuild_webhook_filter_group = [
    {
      type                    = "EVENT"
      pattern                 = "PUSH"
      exclude_matched_pattern = false
    },
    {
      type                    = "HEAD_REF"
      pattern                 = "master"
      exclude_matched_pattern = false
    }
  ]

  tags = map("Env", "stage", "Orchestration", "Terraform")
}
