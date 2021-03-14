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
  environment = "dev"

  enable_codecommit_repository = true
  codecommit_repository_name   = "myrepo"

  enable_codecommit_trigger = false
  codecommit_trigger = [
    {
      name            = ""
      destination_arn = ""
      branches        = []
      events          = ["all"]
    }
  ]

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
  codebuild_project_artifacts = [
    {
      name = null
      type = "NO_ARTIFACTS" #CODEPIPELINE
    }
  ]

  ## source
  codebuild_project_source = {
    type            = "CODECOMMIT"
    location        = module.codecommit.codecommit_repository_clone_url_http #https://git-codecommit.us-east-1.amazonaws.com/v1/repos/myrepo.git
    git_clone_depth = 1
    version         = "master"
  }

  ## caches
  codebuild_project_cache = [{
    type  = "LOCAL"
    modes = ["LOCAL_DOCKER_LAYER_CACHE", "LOCAL_SOURCE_CACHE"]
  }]

  ## environment
  codebuild_project_environment = {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:4.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = false
  }
  

  # Creds
  enable_codebuild_source_credential      = false
  codebuild_source_credential_auth_type   = "PERSONAL_ACCESS_TOKEN"
  codebuild_source_credential_server_type = "GITHUB" #GITHUB BITBUCKET GITHUB_ENTERPRISE
  codebuild_source_credential_token       = "token_here"

  # Webhook
  enable_codebuild_webhook = true
  codebuild_webhook_filter_group = [
    {
      filter = {
        type                    = "EVENT"
        pattern                 = "PUSH"
        exclude_matched_pattern = false
      }
    },
    {
      filter = {
        type                    = "HEAD_REF"
        pattern                 = "master"
        exclude_matched_pattern = false
      }
    }
  ]

  # codebuild report group
  enable_codebuild_report_group = false
  codebuild_report_group_stack = [
    {
      name           = "test"
      type           = "TEST"
      delete_reports = false

      export_config = {
        type = "S3"

        s3_destination = {
          bucket              = "bucket_id"
          encryption_disabled = false
          encryption_key      = "arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab"
          packaging           = "NONE"
          path                = "/some"
        }
      }
    }
  ]

  tags = map("Env", "stage", "Orchestration", "Terraform")
}
