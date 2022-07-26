# Work with CODEBUILD via terraform

A terraform module for making CODEBUILD.


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

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}

module "codebuild" {
  source      = "../../modules/codebuild"
  name        = "TEST"
  environment = "stage"

  # Project
  enable_codebuild_project         = true
  codebuild_project_name           = ""
  codebuild_project_description    = "My first codebuild project"
  codebuild_project_service_role   = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/admin-role"
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
          encryption_key      = "arn:aws:kms:us-east-1:${data.aws_caller_identity.current.account_id}:key/1234abcd-12ab-34cd-56ef-1234567890ab"
          packaging           = "NONE"
          path                = "/some"
        }
      }
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
- `enable_codebuild_project` - Enable codebuild project usage (`default = False`)
- `codebuild_project_name` - Set name for CodeBuild project (`default = ""`)
- `codebuild_project_service_role` - (Required) The Amazon Resource Name (ARN) of the AWS Identity and Access Management (IAM) role that enables AWS CodeBuild to interact with dependent AWS services on behalf of the AWS account. (`default = null`)
- `codebuild_project_environment` - (Required) Configuration block for environment. (`default = {}`)
- `codebuild_project_source` - (Required) Configuration block for source. (`default = {}`)
- `codebuild_project_artifacts` - (Required) Configuration block for artifacts. (`default = {}`)
- `codebuild_project_cache` - (Optional) Information about the cache storage for the project. (`default = []`)
- `codebuild_project_logs_config` - (Optional) Configuration for the builds to store log data to S3 or CloudWatch. (`default = []`)
- `codebuild_project_vpc_config` - (Optional) Configuration for the builds to run inside a VPC. (`default = []`)
- `codebuild_project_secondary_artifacts` - (Optional) A set of secondary artifacts to be used inside the build. (`default = []`)
- `codebuild_project_secondary_sources` - (Optional) A set of secondary sources to be used inside the build. (`default = []`)
- `codebuild_project_description` - (Optional) A short description of the project. (`default = null`)
- `codebuild_project_badge_enabled` - (Optional) Generates a publicly-accessible URL for the projects build badge. Available as badge_url attribute when enabled. (`default = null`)
- `codebuild_project_build_timeout` - (Optional) How long in minutes, from 5 to 480 (8 hours), for AWS CodeBuild to wait until timing out any related build that does not get marked as completed. The default is 60 minutes. (`default = null`)
- `codebuild_project_queued_timeout` - (Optional) How long in minutes, from 5 to 480 (8 hours), a build is allowed to be queued before it times out. The default is 8 hours. (`default = null`)
- `codebuild_project_encryption_key` - (Optional) The AWS Key Management Service (AWS KMS) customer master key (CMK) to be used for encrypting the build project's build output artifacts. (`default = null`)
- `codebuild_project_source_version` - (Optional) A version of the build input to be built for this project. If not specified, the latest version is used. (`default = null`)
- `enable_codebuild_source_credential` - Enable codebuild source credential usage (`default = False`)
- `codebuild_source_credential_auth_type` - (Required) The type of authentication used to connect to a GitHub, GitHub Enterprise, or Bitbucket repository. An OAUTH connection is not supported by the API. Ex: PERSONAL_ACCESS_TOKEN (`default = null`)
- `codebuild_source_credential_server_type` - (Required) The source provider used for this project. Ex: GITHUB (`default = null`)
- `codebuild_source_credential_token` - (Required) For GitHub or GitHub Enterprise, this is the personal access token. For Bitbucket, this is the app password. (`default = null`)
- `codebuild_source_credential_user_name` - (Optional) The Bitbucket username when the authType is BASIC_AUTH. This parameter is not valid for other types of source providers or connections. (`default = null`)
- `enable_codebuild_webhook` - Enable codebuild webhook usage (`default = False`)
- `codebuild_webhook_project_name` - The name of the build project. (`default = ""`)
- `codebuild_webhook_branch_filter` - (Optional) A regular expression used to determine which branches get built. Default is all branches are built. It is recommended to use filter_group over branch_filter. (`default = null`)
- `codebuild_webhook_filter_group` - (Optional) Information about the webhook's trigger (`default = []`)
- `enable_codebuild_report_group` - Enable codebuild report group usage (`default = False`)
- `codebuild_report_group_stack` - Set properties for codebuild report group (`default = []`)

## Module Output Variables
----------------------
- `codebuild_project_id` - The name (if imported via name) or ARN (if created via Terraform or imported via ARN) of the CodeBuild project.
- `codebuild_project_arn` - The ARN of the CodeBuild project.
- `codebuild_project_badge_url` - The URL of the build badge when badge_enabled is enabled.
- `codebuild_source_credential_id` - The ARN of Source Credential.
- `codebuild_source_credential_arn` - The ARN of Source Credential.
- `codebuild_webhook_id` - The name of the build project.
- `codebuild_webhook_payload_url` - The CodeBuild endpoint where webhook events are sent.
- `codebuild_webhook_secret` - The secret token of the associated repository. Not returned by the CodeBuild API for all source types.
- `codebuild_webhook_url` - The URL to the webhook.
- `codebuild_report_group_id` - The ARN of Report Group.
- `codebuild_report_group_arn` - The ARN of Report Group.
- `codebuild_report_group_created` - The date and time this Report Group was created.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
