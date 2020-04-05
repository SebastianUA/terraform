# Work with AWS Codebuild via terraform

A terraform module for making Codebuild.

## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
    required_version = "~> 0.12.12"
}

provider "aws" {
    region                  = "us-east-1"
    shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "codecommit" {
    source                              = "../../modules/codecommit"
    name                                = "TEST"
    environment                         = "stage"

    enable_codecommit_repository        = true
    codecommit_repository_name          = "myrepo"

    enable_codecommit_trigger           = false
    codecommit_trigger_name             = ""
    codecommit_trigger_destination_arn  = ""
    codecommit_trigger_branches         = []
    codecommit_trigger_events           = ["all"]

    tags                                = map("Env", "stage", "Orchestration", "Terraform")
}

module "codebuild" {
    source                                                      = "../../modules/codebuild"
    name                                                        = "TEST"
    environment                                                 = "stage"

    # Project
    enable_codebuild_project                                    = true
    codebuild_project_name                                      = ""
    codebuild_project_description                               = "My first codebuild project"
    codebuild_project_service_role                              = "arn:aws:iam::167127734783:role/admin-role"
    codebuild_project_build_timeout                             = 60
    codebuild_project_queued_timeout                            = 480

    ## artifacts
    codebuild_project_artifacts_name                            = null
    codebuild_project_artifacts_type                            = "NO_ARTIFACTS" #CODEPIPELINE

    ## source
    codebuild_project_source_type                               = "CODECOMMIT"
    codebuild_project_source_location                           = module.codecommit.codecommit_repository_clone_url_http #https://git-codecommit.us-east-1.amazonaws.com/v1/repos/myrepo.git
    codebuild_project_source_git_clone_depth                    = 1
    codebuild_project_source_version                            = "master"

    ## caches
    codebuild_project_cache                                     = [{
        type  = "LOCAL"
        modes = ["LOCAL_DOCKER_LAYER_CACHE", "LOCAL_SOURCE_CACHE"]
    }]

    ## environment
    codebuild_project_environment_compute_type                  = "BUILD_GENERAL1_SMALL"
    codebuild_project_environment_image                         = "aws/codebuild/standard:4.0"
    codebuild_project_environment_type                          = "LINUX_CONTAINER"
    codebuild_project_environment_privileged_mode               = false

    # Creds
    enable_codebuild_source_credential                          = false
    codebuild_source_credential_auth_type                       = "PERSONAL_ACCESS_TOKEN"
    codebuild_source_credential_server_type                     = "GITHUB" #GITHUB BITBUCKET GITHUB_ENTERPRISE
    codebuild_source_credential_token                           = "token_here"

    # Webhook
    enable_codebuild_webhook                                    = false
    codebuild_webhook_filter_group                              = [
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

    tags                                                        = map("Env", "stage", "Orchestration", "Terraform")
}
```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = ""`)
- `enable_codebuild_project` - Enable codebuild project usage (`default = ""`)
- `codebuild_project_name` - description (`default = ""`)
- `codebuild_project_service_role` - (Required) The Amazon Resource Name (ARN) of the AWS Identity and Access Management (IAM) role that enables AWS CodeBuild to interact with dependent AWS services on behalf of the AWS account. (`default = ""`)
- `codebuild_project_artifacts_type` - (Required) The build output artifact's type. Valid values for this parameter are: CODEPIPELINE, NO_ARTIFACTS or S3. (`default = NO_ARTIFACTS`)
- `codebuild_project_artifacts_artifact_identifier` - (Optional) The artifact identifier. Must be the same specified inside AWS CodeBuild buildspec. (`default = ""`)
- `codebuild_project_artifacts_encryption_disabled` - (Optional) If set to true, output artifacts will not be encrypted. If type is set to NO_ARTIFACTS then this value will be ignored. Defaults to false. (`default = ""`)
- `codebuild_project_artifacts_override_artifact_name` - (Optional) If set to true, a name specified in the build spec file overrides the artifact name. (`default = ""`)
- `codebuild_project_artifacts_location` - (Optional) Information about the build output artifact location. If type is set to CODEPIPELINE or NO_ARTIFACTS then this value will be ignored. If type is set to S3, this is the name of the output bucket. (`default = ""`)
- `codebuild_project_artifacts_name` - (Optional) The name of the project. If type is set to S3, this is the name of the output artifact object (`default = ""`)
- `codebuild_project_artifacts_namespace_type` - (Optional) The namespace to use in storing build artifacts. If type is set to S3, then valid values for this parameter are: BUILD_ID or NONE. (`default = ""`)
- `codebuild_project_artifacts_packaging` - (Optional) The type of build output artifact to create. If type is set to S3, valid values for this parameter are: NONE or ZIP (`default = ""`)
- `codebuild_project_artifacts_path` - (Optional) If type is set to S3, this is the path to the output artifact (`default = ""`)
- `codebuild_project_source_type` - (Required) The type of repository that contains the source code to be built. Valid values for this parameter are: CODECOMMIT, CODEPIPELINE, GITHUB, GITHUB_ENTERPRISE, BITBUCKET, S3 or NO_SOURCE. (`default = CODECOMMIT`)
- `codebuild_project_source_auth_type` - (Required) The authorization type to use. The only valid value is OAUTH (`default = OAUTH`)
- `codebuild_project_source_auth_resource` - (Optional) The resource value that applies to the specified authorization type. (`default = ""`)
- `codebuild_project_source_buildspec` - (Optional) The build spec declaration to use for this build project's related builds. (`default = ""`)
- `codebuild_project_source_git_clone_depth` - (Optional) Truncate git history to this many commits. (`default = ""`)
- `codebuild_project_source_git_submodules_config_fetch_submodules` - (Required) If set to true, fetches Git submodules for the AWS CodeBuild build project. (`default = True`)
- `codebuild_project_source_insecure_ssl` - (Optional) Ignore SSL warnings when connecting to source control. (`default = ""`)
- `codebuild_project_source_location` - (Optional) The location of the source code from git or s3. (`default = ""`)
- `codebuild_project_source_report_build_status` - (Optional) Set to true to report the status of a build's start and finish to your source provider. This option is only valid when your source provider is GITHUB, BITBUCKET, or GITHUB_ENTERPRISE. (`default = ""`)
- `codebuild_project_environment_compute_type` - (Required) Information about the compute resources the build project will use. Available values for this parameter are: BUILD_GENERAL1_SMALL, BUILD_GENERAL1_MEDIUM, BUILD_GENERAL1_LARGE or BUILD_GENERAL1_2XLARGE. BUILD_GENERAL1_SMALL is only valid if type is set to LINUX_CONTAINER. When type is set to LINUX_GPU_CONTAINER, compute_type need to be BUILD_GENERAL1_LARGE. (`default = BUILD_GENERAL1_SMALL`)
- `codebuild_project_environment_image` - (Required) The Docker image to use for this build project. Valid values include Docker images provided by CodeBuild (e.g aws/codebuild/standard:2.0), Docker Hub images (e.g. hashicorp/terraform:latest), and full Docker repository URIs such as those for ECR (e.g. 137112412989.dkr.ecr.us-west-2.amazonaws.com/amazonlinux:latest). (`default = aws/codebuild/standard:4.0`)
- `codebuild_project_environment_type` - (Required) The type of build environment to use for related builds. Available values are: LINUX_CONTAINER, LINUX_GPU_CONTAINER, WINDOWS_CONTAINER or ARM_CONTAINER. (`default = LINUX_CONTAINER`)
- `codebuild_project_environment_image_pull_credentials_type` - (Optional) The type of credentials AWS CodeBuild uses to pull images in your build. Available values for this parameter are CODEBUILD or SERVICE_ROLE. When you use a cross-account or private registry image, you must use SERVICE_ROLE credentials. When you use an AWS CodeBuild curated image, you must use CODEBUILD credentials. Default to CODEBUILD (`default = CODEBUILD`)
- `codebuild_project_environment_privileged_mode` - (Optional) If set to true, enables running the Docker daemon inside a Docker container. Defaults to false. (`default = ""`)
- `codebuild_project_environment_certificate` - (Optional) The ARN of the S3 bucket, path prefix and object key that contains the PEM-encoded certificate. (`default = ""`)
- `codebuild_project_environment_registry_credential` - (Optional) Information about credentials for access to a private Docker registry. (`default = ""`)
- `codebuild_project_environment_variable` - (Optional) A set of environment variables to make available to builds for this build project. (`default = ""`)
- `codebuild_project_description` - (Optional) A short description of the project. (`default = ""`)
- `codebuild_project_badge_enabled` - (Optional) Generates a publicly-accessible URL for the projects build badge. Available as badge_url attribute when enabled. (`default = ""`)
- `codebuild_project_build_timeout` - (Optional) How long in minutes, from 5 to 480 (8 hours), for AWS CodeBuild to wait until timing out any related build that does not get marked as completed. The default is 60 minutes. (`default = 60`)
- `codebuild_project_queued_timeout` - (Optional) How long in minutes, from 5 to 480 (8 hours), a build is allowed to be queued before it times out. The default is 8 hours. (`default = 480`)
- `codebuild_project_cache` - (Optional) Information about the cache storage for the project. (`default = ""`)
- `codebuild_project_encryption_key` - (Optional) The AWS Key Management Service (AWS KMS) customer master key (CMK) to be used for encrypting the build project's build output artifacts. (`default = ""`)
- `codebuild_project_s3_logs_config` - (Optional) Configuration for the builds to store log data to S3. (`default = ""`)
- `codebuild_project_cw_logs_config` - (Optional) Configuration for the builds to store log data to CloudWatch. (`default = ""`)
- `codebuild_project_source_version` - (Optional) A version of the build input to be built for this project. If not specified, the latest version is used. (`default = ""`)
- `codebuild_project_vpc_config` - (Optional) Configuration for the builds to run inside a VPC. (`default = ""`)
- `codebuild_project_secondary_artifacts` - description (`default = ""`)
- `codebuild_project_secondary_sources` - (Optional) A set of secondary sources to be used inside the build. (`default = ""`)
- `codebuild_project_secondary_sources_auth_type` - (Required) The authorization type to use. The only valid value is OAUTH (`default = OAUTH`)
- `codebuild_project_secondary_sources_auth_resource` - (Optional) The resource value that applies to the specified authorization type. (`default = ""`)
- `codebuild_project_secondary_sources_git_submodules_config_fetch_submodules` - If set to true, fetches Git submodules for the AWS CodeBuild build project. (`default = True`)
- `enable_codebuild_source_credential` - Enable codebuild source credential usage (`default = ""`)
- `codebuild_source_credential_auth_type` - (Required) The type of authentication used to connect to a GitHub, GitHub Enterprise, or Bitbucket repository. An OAUTH connection is not supported by the API. Ex: PERSONAL_ACCESS_TOKEN (`default = ""`)
- `codebuild_source_credential_server_type` - (Required) The source provider used for this project. Ex: GITHUB (`default = ""`)
- `codebuild_source_credential_token` - (Required) For GitHub or GitHub Enterprise, this is the personal access token. For Bitbucket, this is the app password. (`default = ""`)
- `codebuild_source_credential_user_name` - (Optional) The Bitbucket username when the authType is BASIC_AUTH. This parameter is not valid for other types of source providers or connections. (`default = ""`)
- `enable_codebuild_webhook` - Enable codebuild webhook usage (`default = ""`)
- `codebuild_webhook_project_name` - The name of the build project. (`default = ""`)
- `codebuild_webhook_branch_filter` - (Optional) A regular expression used to determine which branches get built. Default is all branches are built. It is recommended to use filter_group over branch_filter. (`default = ""`)
- `codebuild_webhook_filter_group` - (Optional) Information about the webhook's trigger (`default = ""`)

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


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
