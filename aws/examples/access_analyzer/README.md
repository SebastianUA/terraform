# Work with ACCESS_ANALYZER via terraform

A terraform module for making ACCESS_ANALYZER.


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

module "access_analyzer" {
  source      = "../../modules/access_analyzer"
  name        = "TEST"
  environment = "dev"

  enable_accessanalyzer_analyzer = true
  accessanalyzer_analyzer_name   = ""

  tags = tomap({
    "Environment" = "dev",
    "Createdby"   = "Vitalii Natarov"
  })
}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_accessanalyzer_analyzer` - Enable accessanalyzer analyzer usage (`default = False`)
- `accessanalyzer_analyzer_name` - Set mame of the Analyzer. (`default = ""`)
- `accessanalyzer_analyzer_type` - (Optional) Type of Analyzer. Valid value is currently only ACCOUNT. Defaults to ACCOUNT. (`default = ACCOUNT`)

## Module Output Variables
----------------------
- `accessanalyzer_analyzer_id` - Analyzer name.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
