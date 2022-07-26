# Work with DEVICEFARM via terraform

A terraform module for making DEVICEFARM.


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

module "devicefarm" {
  source      = "../../modules/devicefarm"
  name        = "TEST"
  environment = "dev"

  enable_devicefarm_project = true
  devicefarm_project_name   = ""
}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `enable_devicefarm_project` - Enable devicefarm project usage (`default = False`)
- `devicefarm_project_name` - The name of the project (`default = ""`)

## Module Output Variables
----------------------
- `devicefarm_project_id` - The ID of this project
- `devicefarm_project_arn` - The Amazon Resource Name of this project


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
