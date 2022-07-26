# Work with SWF via terraform

A terraform module for making SWF.


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

module "swf" {
  source = "../../modules/swf"

  enable_swf_domain                                      = true
  swf_domain_name                                        = "name"
  swf_domain_description                                 = "Managing by Terrafrom"
  swf_domain_workflow_execution_retention_period_in_days = 0

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}

```

## Module Input Variables
----------------------
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_swf_domain` - Enable swf domain usage (`default = False`)
- `swf_domain_name` - (Optional, Forces new resource) The name of the domain. If omitted, Terraform will assign a random, unique name. (`default = ""`)
- `swf_domain_name_prefix` - (Optional, Forces new resource) Creates a unique name beginning with the specified prefix. Conflicts with swf_domain_name. (`default = ""`)
- `swf_domain_description` - (Optional, Forces new resource) The domain description. (`default = null`)
- `swf_domain_workflow_execution_retention_period_in_days` - (Required, Forces new resource) Length of time that SWF will continue to retain information about the workflow execution after the workflow execution is complete, must be between 0 and 90 days. (`default = 0`)

## Module Output Variables
----------------------
- `swf_domain_id` - The name of the domain.
- `swf_domain_arn` - Amazon Resource Name (ARN)


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
