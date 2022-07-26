# Work with DATAPIPELINE via terraform

A terraform module for making DATAPIPELINE.


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

module "datapipeline" {
  source      = "../../modules/datapipeline"
  name        = "TEST"
  environment = "dev"

  enable_datapipeline_pipeline      = true
  datapipeline_pipeline_name        = ""
  datapipeline_pipeline_description = null

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
- `enable_datapipeline_pipeline` - Enable datapipeline pipeline usage (`default = False`)
- `datapipeline_pipeline_name` - The name of Pipeline. (`default = ""`)
- `datapipeline_pipeline_description` - (Optional) The description of Pipeline. (`default = null`)

## Module Output Variables
----------------------
- `datapipeline_pipeline_id` - The identifier of the client certificate.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
