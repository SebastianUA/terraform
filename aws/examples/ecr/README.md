# Work with ECR via terraform

A terraform module for making ECR.


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

module "ecr" {
  source = "../../modules/ecr"

  name        = "test"
  environment = "dev"

  enable_ecr_repository = true
  ecr_repository_name   = "test-ecr-repo"

  enable_ecr_repository_policy = true
  ecr_repository_policy        = file("additional_files/policy.json")

  enable_ecr_lifecycle_policy = true
  ecr_lifecycle_policy        = file("additional_files/lifecycle_policy.json")

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
- `tags` - A list of tag blocks. Each element should have keys named key, value, and propagate_at_launch. (`default = {}`)
- `enable_ecr_repository` - Enable ecr repo creating (`default = False`)
- `ecr_repository_name` - Name of the repository. (`default = ""`)
- `timeouts_delete` - (Default 20 minutes) How long to wait for a repository to be deleted. (`default = 20m`)
- `enable_ecr_repository_policy` - Enable ecr repo policy usage (`default = False`)
- `ecr_repository_policy_repository` - (Required) Name of the repository to apply the policy. (`default = ""`)
- `ecr_repository_policy` - Json file with policy (`default = ""`)
- `enable_ecr_lifecycle_policy` - Enable ecr lifecycle policy (`default = False`)
- `ecr_lifecycle_policy_repository` - Set repository for lifecycle policy resource (`default = ""`)
- `ecr_lifecycle_policy` - Json file with lifecycle policy (`default = ""`)

## Module Output Variables
----------------------
- `aws_ecr_repository_arn` - Full ARN of the repository.
- `aws_ecr_repository_name` - The name of the repository.
- `aws_ecr_repository_registry_id` - The registry ID where the repository was created.
- `aws_ecr_repository_url` - The URL of the repository (in the form aws_account_id.dkr.ecr.region.amazonaws.com/repositoryName


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
