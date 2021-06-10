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
- `codecommit_trigger` - Set codecommit trigger params (`default = []`)

## Module Output Variables
----------------------
- `codecommit_repository_id` - The ID of the repository
- `codecommit_repository_name` - The name of the repository
- `codecommit_repository_arn` - The ARN of the repository
- `codecommit_repository_clone_url_http` - The URL to use for cloning the repository over HTTPS.
- `codecommit_repository_clone_url_ssh` - The URL to use for cloning the repository over SSH.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
