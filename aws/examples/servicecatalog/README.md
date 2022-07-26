# Work with SERVICECATALOG via terraform

A terraform module for making SERVICECATALOG.


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

module "servicecatalog" {
  source = "../../modules/servicecatalog"

  enable_servicecatalog_portfolio        = true
  servicecatalog_portfolio_name          = "servicecatalog"
  servicecatalog_portfolio_description   = ""
  servicecatalog_portfolio_provider_name = "captain"
}

```

## Module Input Variables
----------------------
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_servicecatalog_portfolio` - Enable servicecatalog portfolio usage (`default = False`)
- `servicecatalog_portfolio_name` - The name of the portfolio. (`default = ""`)
- `servicecatalog_portfolio_description` - (Required) Description of the portfolio (`default = ""`)
- `servicecatalog_portfolio_provider_name` - (Required) Name of the person or organization who owns the portfolio. (`default = null`)

## Module Output Variables
----------------------
- `servicecatalog_portfolio_id` - The ID of the Service Catalog Portfolio.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
