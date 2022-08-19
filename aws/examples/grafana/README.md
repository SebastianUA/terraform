# Work with GRAFANA via terraform

A terraform module for making GRAFANA.


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
  shared_credentials_file = pathexpand("/Users/captain/.aws/credentials")
  profile                 = "default"

}

module "grafana" {
  source      = "../../modules/grafana"
  name        = "grafana"
  environment = "staging"

  tags = tomap({
    "Environment" = "dev",
    "Createdby"   = "Vitaliy Natarov"
  })

}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `region` - The region where to deploy this code (e.g. us-east-1). (`default = us-east-1`)
- `ami` - Default AMIs by region (`default = {'us-east-1': 'ami-46c1b650', 'us-west-2': 'ami-50d1d929', 'eu-west-1': 'ami-6e28b517'}`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, and propagate_at_launch. (`default = {}`)

## Module Output Variables
----------------------
