# Work with AWS Codepipeline via terraform

A terraform module for making Codepipeline.

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
    profile                 = "default"
}

module "s3" {
    source                                  = "../../modules/s3"
    name                                    = "TEST"
    environment                             = "stage"
    region                                  = "us-east-1"

    enable_s3_bucket                        = true
    s3_bucket_name                          = "codepipeline-artifacts-bucket"
    s3_bucket_acl                           = "private"
    s3_bucket_cors_rule                     = []

    s3_bucket_versioning                    = []
    enable_lifecycle_rule                   = true

    # Add policy to the bucket
    enable_s3_bucket_policy                 = false

    tags                                    = map("Env", "stage", "Orchestration", "Terraform")

}

module "kms" {
    source              = "../../modules/kms"
    name                = "test"
    environment         = "stage"

    enable_kms_key      = true
    kms_key_name        = "codepipeline-kms"
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
    codebuild_project_artifacts_override_artifact_name          = true
    codebuild_project_artifacts_type                            = "S3" #NO_ARTIFACTS or CODEPIPELINE
    codebuild_project_artifacts_location                        = module.s3.s3_bucket_id

    ## source
    codebuild_project_source_type                               = "CODECOMMIT"
    codebuild_project_source_location                           = module.codecommit.codecommit_repository_clone_url_http
    codebuild_project_source_git_clone_depth                    = 1
    codebuild_project_source_version                            = null # will be latest

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

    tags                                                        = map("Env", "stage", "Orchestration", "Terraform")
}

module "codepipeline" {
    source                                                      = "../../modules/codepipeline"
    name                                                        = "TEST"
    environment                                                 = "stage"

    # Pipeline
    enable_codepipeline                                         = true
    codepipeline_name                                           = ""
    codepipeline_role_arn                                       = "arn:aws:iam::167127734783:role/admin-role"

    ## artifact
    codepipeline_artifact_store_type                            = "S3"
    codepipeline_artifact_store_location                        = module.s3.s3_bucket_id
    codepipeline_artifact_store_encryption_key                  = [{
        id   = module.kms.kms_key_arn
        type = "KMS"
    }]

    ## stages & actions
    ### stage 1
    codepipeline_stage1_name                                    = "Source"
    codepipeline_stage1_action_name                             = "Source"
    codepipeline_stage1_action_category                         = "Source"
    codepipeline_stage1_action_owner                            = "AWS"
    codepipeline_stage1_action_provider                         = "CodeCommit"
    codepipeline_stage1_action_version                          = 1
    codepipeline_stage1_action_configuration                    = {
        RepositoryName  = module.codecommit.codecommit_repository_name
        BranchName      = "master"
    }
    codepipeline_stage1_action_output_artifacts                 = ["Source"]

    ### stage 2
    codepipeline_stage2_name                                    = "Build"
    codepipeline_stage2_action_name                             = "Build"
    codepipeline_stage2_action_category                         = "Build"
    codepipeline_stage2_action_owner                            = "AWS"
    codepipeline_stage2_action_provider                         = "CodeBuild"
    codepipeline_stage2_action_version                          = "1"
    codepipeline_stage2_action_configuration                    = {
        ProjectName = module.codebuild.codebuild_project_id
    }
    codepipeline_stage2_action_input_artifacts                  = ["Source"]
    codepipeline_stage2_action_output_artifacts                 = ["Build"]

    ### stage 3
    codepipeline_stage3_name                                    = "Deploy"
    codepipeline_stage3_action_name                             = "Deploy"
    codepipeline_stage3_action_category                         = "Deploy"
    codepipeline_stage3_action_owner                            = "AWS"
    codepipeline_stage3_action_provider                         = "ECS"
    codepipeline_stage3_action_version                          = "1"
    codepipeline_stage3_action_configuration                    = {
        ClusterName = "ecs-cluster-name"
        ServiceName = "ecs-service-name"
    }
    codepipeline_stage3_action_input_artifacts                  = ["Build"]

    # Pipeline webhook
    enable_codepipeline_webhook                                 = false
    codepipeline_webhook_name                                   = ""
    codepipeline_webhook_authentication                         = "GITHUB_HMAC"
    codepipeline_webhook_target_action                          = "Source"
    codepipeline_webhook_authentication_configuration           = [{
        secret_token    = "mysecret_here"
    }]

    codepipeline_webhook_filter1_json_path                      = "$.ref"
    codepipeline_webhook_filter1_match_equals                   = "refs/heads/{Branch}"

    tags                                                        = map("Env", "stage", "Orchestration", "Terraform")
}
```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = ""`)
- `enable_codepipeline` - Enable codepipeline usage (`default = ""`)
- `codepipeline_name` -  The name of the pipeline. (`default = ""`)
- `codepipeline_role_arn` - (Required) A service role Amazon Resource Name (ARN) that grants AWS CodePipeline permission to make calls to AWS services on your behalf. (`default = ""`)
- `codepipeline_artifact_store_location` - (Required) The location where AWS CodePipeline stores artifacts for a pipeline; currently only S3 is supported. (`default = ""`)
- `codepipeline_artifact_store_type` - (Required) The type of the artifact store, such as Amazon S3 (`default = S3`)
- `codepipeline_artifact_store_region` - (Optional) The region where the artifact store is located. Required for a cross-region CodePipeline, do not provide for a single-region CodePipeline. (`default = ""`)
- `codepipeline_artifact_store_encryption_key` - (Optional) The encryption key block AWS CodePipeline uses to encrypt the data in the artifact store, such as an AWS Key Management Service (AWS KMS) key. If you don't specify a key, AWS CodePipeline uses the default key for Amazon Simple Storage Service (Amazon S3). (`default = ""`)
- `codepipeline_stage1_name` - The name of the stage. (`default = Source`)
- `codepipeline_stage1_action_name` - The action declaration's name. (`default = Source`)
- `codepipeline_stage1_action_category` - (Required) A category defines what kind of action can be taken in the stage, and constrains the provider type for the action. Possible values are Approval, Build, Deploy, Invoke, Source and Test (`default = Source`)
- `codepipeline_stage1_action_owner` - (Required) The creator of the action being called. Possible values are AWS, Custom and ThirdParty. (`default = AWS`)
- `codepipeline_stage1_action_provider` - (Required) The provider of the service being called by the action. Valid providers are determined by the action category. For example, an action in the Deploy category type might have a provider of AWS CodeDeploy, which would be specified as CodeDeploy. (`default = CodeCommit`)
- `codepipeline_stage1_action_version` - (Required) A string that identifies the action type. (`default = 1`)
- `codepipeline_stage1_action_configuration` - (Optional) A Map of the action declaration's configuration. Find out more about configuring action configurations in the Reference Pipeline Structure documentation. (`default = ""`)
- `codepipeline_stage1_action_input_artifacts` - (Optional) A list of artifact names to be worked on. (`default = ""`)
- `codepipeline_stage1_action_output_artifacts` - (Optional) A list of artifact names to output. Output artifact names must be unique within a pipeline. (`default = ""`)
- `codepipeline_stage1_action_role_arn` - (Optional) The ARN of the IAM service role that will perform the declared action. This is assumed through the roleArn for the pipeline. (`default = ""`)
- `codepipeline_stage1_action_run_order` - (Optional) The order in which actions are run. (`default = ""`)
- `codepipeline_stage1_action_region` - (Optional) The region in which to run the action. (`default = ""`)
- `codepipeline_stage2_name` - The name of the stage. (`default = Build`)
- `codepipeline_stage2_action_name` - The action declaration's name. (`default = Build`)
- `codepipeline_stage2_action_category` - (Required) A category defines what kind of action can be taken in the stage, and constrains the provider type for the action. Possible values are Approval, Build, Deploy, Invoke, Source and Test (`default = Build`)
- `codepipeline_stage2_action_owner` - (Required) The creator of the action being called. Possible values are AWS, Custom and ThirdParty. (`default = AWS`)
- `codepipeline_stage2_action_provider` - (Required) The provider of the service being called by the action. Valid providers are determined by the action category. For example, an action in the Deploy category type might have a provider of AWS CodeDeploy, which would be specified as CodeDeploy. (`default = CodeBuild`)
- `codepipeline_stage2_action_version` - (Required) A string that identifies the action type. (`default = 1`)
- `codepipeline_stage2_action_configuration` - (Optional) A Map of the action declaration's configuration. Find out more about configuring action configurations in the Reference Pipeline Structure documentation. (`default = ""`)
- `codepipeline_stage2_action_input_artifacts` - (Optional) A list of artifact names to be worked on. (`default = ""`)
- `codepipeline_stage2_action_output_artifacts` - (Optional) A list of artifact names to output. Output artifact names must be unique within a pipeline. (`default = ""`)
- `codepipeline_stage2_action_role_arn` - (Optional) The ARN of the IAM service role that will perform the declared action. This is assumed through the roleArn for the pipeline. (`default = ""`)
- `codepipeline_stage2_action_run_order` - (Optional) The order in which actions are run. (`default = ""`)
- `codepipeline_stage2_action_region` - (Optional) The region in which to run the action. (`default = ""`)
- `codepipeline_stage3_name` - The name of the stage. (`default = Deploy`)
- `codepipeline_stage3_action_name` - The action declaration's name. (`default = Deploy`)
- `codepipeline_stage3_action_category` - (Required) A category defines what kind of action can be taken in the stage, and constrains the provider type for the action. Possible values are Approval, Build, Deploy, Invoke, Source and Test (`default = Deploy`)
- `codepipeline_stage3_action_owner` - (Required) The creator of the action being called. Possible values are AWS, Custom and ThirdParty. (`default = AWS`)
- `codepipeline_stage3_action_provider` - (Required) The provider of the service being called by the action. Valid providers are determined by the action category. For example, an action in the Deploy category type might have a provider of AWS CodeDeploy, which would be specified as CodeDeploy. (`default = ECS`)
- `codepipeline_stage3_action_version` - (Required) A string that identifies the action type. (`default = 1`)
- `codepipeline_stage3_action_configuration` - (Optional) A Map of the action declaration's configuration. Find out more about configuring action configurations in the Reference Pipeline Structure documentation. (`default = ""`)
- `codepipeline_stage3_action_input_artifacts` - (Optional) A list of artifact names to be worked on. (`default = ""`)
- `codepipeline_stage3_action_output_artifacts` - (Optional) A list of artifact names to output. Output artifact names must be unique within a pipeline. (`default = ""`)
- `codepipeline_stage3_action_role_arn` - (Optional) The ARN of the IAM service role that will perform the declared action. This is assumed through the roleArn for the pipeline. (`default = ""`)
- `codepipeline_stage3_action_run_order` - (Optional) The order in which actions are run. (`default = ""`)
- `codepipeline_stage3_action_region` - (Optional) The region in which to run the action. (`default = ""`)
- `enable_codepipeline_webhook` - Enable codepipeline webhook usage (`default = ""`)
- `codepipeline_webhook_name` - The name of the webhook. (`default = ""`)
- `codepipeline_webhook_authentication` - (Required) The type of authentication to use. One of IP, GITHUB_HMAC, or UNAUTHENTICATED. (`default = GITHUB_HMAC`)
- `codepipeline_webhook_target_action` - (Required) The name of the action in a pipeline you want to connect to the webhook. The action must be from the source (first) stage of the pipeline. (`default = ""`)
- `codepipeline_webhook_target_pipeline` - The name of the pipeline. (`default = ""`)
- `codepipeline_webhook_authentication_configuration` - (Optional) An auth block. Required for IP and GITHUB_HMAC. (`default = ""`)
- `codepipeline_webhook_filter1_json_path` - (Required) The JSON path to filter on. (`default = $.ref`)
- `codepipeline_webhook_filter1_match_equals` - (Required) The value to match on (e.g. refs/heads/{Branch}). See AWS docs for details. (`default = refs/heads/{Branch}`)

## Module Output Variables
----------------------
- `codepipeline_id` - The codepipeline ID.
- `codepipeline_arn` - The codepipeline ARN.
- `codepipeline_webhook_id` - The CodePipeline webhook's ARN.
- `codepipeline_webhook_url` - The CodePipeline webhook's URL. POST events to this endpoint to trigger the target.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
