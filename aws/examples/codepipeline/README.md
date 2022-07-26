# Work with CODEPIPELINE via terraform

A terraform module for making CODEPIPELINE.


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
  profile                 = "default"
}

module "s3" {
  source      = "../../modules/s3"
  name        = "TEST"
  environment = "dev"

  # AWS S3 bucket
  enable_s3_bucket = true
  s3_bucket_name   = "codepipeline-artifacts-bucket"
  s3_bucket_acl    = "private"

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
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
      name = "test"
      type = "TEST"

      export_config = {
        type = "S3"

        s3_destination = {
          bucket              = "bucket_id"
          encryption_disabled = false
          encryption_key      = module.kms.kms_key_arn
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

module "codepipeline" {
  source      = "../../modules/codepipeline"
  name        = "TEST"
  environment = "stage"

  # Pipeline
  enable_codepipeline = true
  codepipeline_stack = [
    {
      name     = "pipeline-1"
      role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/admin-role"

      ## artifact
      artifact_store = {
        type     = "S3"
        location = module.s3.s3_bucket_id

        encryption_key = {
          id   = module.kms.kms_key_arn
          type = "KMS"
        }
      }

      ## stages & actions
      stage = [
        {
          name = "Source"

          action = {
            name     = "Source"
            category = "Source"
            owner    = "AWS"
            provider = "CodeCommit"
            version  = 1
            configuration = {
              RepositoryName = module.codecommit.codecommit_repository_name
              BranchName     = "master"
            }
            output_artifacts = ["Source"]
          }
        },
        {
          name = "Build"

          action = {
            name     = "Build"
            category = "Build"
            owner    = "AWS"
            provider = "CodeBuild"
            version  = 1
            configuration = {
              ProjectName = module.codebuild.codebuild_project_id
            }
            input_artifacts  = ["Source"]
            output_artifacts = ["Build"]
          }
        },
        {
          name = "Deploy"

          action = {
            name     = "Deploy"
            category = "Deploy"
            owner    = "AWS"
            provider = "ECS"
            version  = 1
            configuration = {
              ClusterName = "ecs-cluster-name"
              ServiceName = "ecs-service-name"
            }
            input_artifacts = ["Build"]
          }
        }
      ]
    }
  ]


  # Pipeline webhook
  enable_codepipeline_webhook = true
  codepipeline_webhook_stack = [
    {
      name           = ""
      authentication = "GITHUB_HMAC"
      target_action  = "Source"

      filter = {
        json_path    = "$.ref"
        match_equals = "refs/heads/{Branch}"
      }

      authentication_configuration = [
        {
          secret_token = "mysecret_here"
        }
      ]
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
- `enable_codepipeline` - Enable codepipeline usage (`default = False`)
- `codepipeline_stack` - Set properties for Codepipeline. (`default = []`)
- `enable_codepipeline_webhook` - Enable codepipeline webhook usage (`default = False`)
- `codepipeline_webhook_stack` - Set properties for codepipeline webhook (`default = []`)

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
