# Work with CODECOMMIT via terraform

A terraform module for making CODECOMMIT.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "codecommit" {
  source = "../../modules/codecommit"

  # Enable codecommit repo
  enable_codecommit_repository = true
  codecommit_repository_name   = "myrepo"

  # Enable codecommit trigger
  enable_codecommit_trigger = false
  codecommit_trigger_triggers = [
    {
      name            = "trigger-name"
      destination_arn = "some_sns_here"
      branches        = ["master", "main", "dev"]
      events          = ["all"]
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
- `enable_codecommit_repository` - Enable codecommit repository usage (`default = False`)
- `codecommit_repository_name` - Set name for codecommit repository. The name for the repository. This needs to be less than 100 characters. (`default = ""`)
- `codecommit_repository_description` - (Optional) The description of the repository. This needs to be less than 1000 characters (`default = null`)
- `codecommit_repository_default_branch` - (Optional) The default branch of the repository. The branch specified here needs to exist. (`default = null`)
- `enable_codecommit_trigger` - Enable codecommit trigger usage (`default = False`)
- `codecommit_trigger_repository_name` - Set repo name for codecommit trigger (`default = ""`)
- `codecommit_trigger_triggers` - Set codecommit triggers params (`default = []`)
- `enable_codecommit_approval_rule_template` - Enable codecommit approval rule template usage (`default = False`)
- `codecommit_approval_rule_template_name` - The name for the approval rule template. Maximum of 100 characters. (`default = ""`)
- `codecommit_approval_rule_template_content` - (Required) The content of the approval rule template. Maximum of 3000 characters. (`default = ""`)
- `codecommit_approval_rule_template_description` - (Optional) The description of the approval rule template. Maximum of 1000 characters. (`default = null`)
- `enable_codecommit_approval_rule_template_association` - Enable codecommit approval rule template association usage (`default = False`)
- `codecommit_approval_rule_template_association_approval_rule_template_name` - The name for the approval rule template. (`default = ""`)
- `codecommit_approval_rule_template_association_repository_name` - The name of the repository that you want to associate with the template. (`default = ""`)

## Module Output Variables
----------------------
- `codecommit_repository_id` - The ID of the repository
- `codecommit_repository_name` - The name of the repository
- `codecommit_repository_arn` - The ARN of the repository
- `codecommit_repository_clone_url_http` - The URL to use for cloning the repository over HTTPS.
- `codecommit_repository_clone_url_ssh` - The URL to use for cloning the repository over SSH.
- `codecommit_repository_tags_all` - A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block.
- `codecommit_approval_rule_template_approval_rule_template_id` - The ID of the approval rule template
- `codecommit_approval_rule_template_creation_date` - The date the approval rule template was created, in RFC3339 format.
- `codecommit_approval_rule_template_last_modified_date` - The date the approval rule template was most recently changed, in RFC3339 format.
- `codecommit_approval_rule_template_last_modified_user` - The Amazon Resource Name (ARN) of the user who made the most recent changes to the approval rule template.
- `codecommit_approval_rule_template_rule_content_sha256` - The SHA-256 hash signature for the content of the approval rule template.
- `codecommit_approval_rule_template_association_id` - The name of the approval rule template and name of the repository, separated by a comma (,).


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
