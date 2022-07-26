# Work with SIMPLEDB via terraform

A terraform module for making SIMPLEDB.


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

module "simpledb" {
  source      = "../../modules/simpledb"
  name        = "TEST"
  environment = "stage"

  enable_simpledb_domain = true
  simpledb_domain_name   = ""
}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `enable_simpledb_domain` - Enable simpledb domain usage (`default = False`)
- `simpledb_domain_name` - The name of the SimpleDB domain (`default = ""`)

## Module Output Variables
----------------------
- `simpledb_domain_id` - The name of the SimpleDB domain


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
