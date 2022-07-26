# Work with CODESTARCONNECTIONS via terraform

A terraform module for making CODESTARCONNECTIONS.


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

module "codestarconnections" {
  source = "../../modules/codestarconnections"

  enable_codestarconnections_connection        = true
  codestarconnections_connection_name          = "github-test-codestarconnections"
  codestarconnections_connection_provider_type = "GitHub"

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
- `enable_codestarconnections_connection` - Enable codestarconnections connection usage (`default = False`)
- `codestarconnections_connection_name` - The name of the connection to be created. The name must be unique in the calling AWS account. Changing name will create a new resource. (`default = ""`)
- `codestarnotifications_notification_rule_resource` - (Required) The name of the external provider where your third-party code repository is configured. Valid values are Bitbucket, GitHub, or GitHubEnterpriseServer. Changing provider_type will create a new resource. (`default = null`)

## Module Output Variables
----------------------
- `aws_codestarconnections_connection_id` - The codestar connection ARN.
- `aws_codestarconnections_connection_arn` - The codestar connection ARN.
- `aws_codestarconnections_connection_connection_status` - The codestar connection status. Possible values are PENDING, AVAILABLE and ERROR.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
