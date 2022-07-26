# Work with DATA via terraform

A terraform module for making DATA.


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

module "external_data" {
  source = "../../modules/data"


  external_program = ["bash", "./additional_files/ssh_key_generator.sh"]
  external_query = {
    customer_name        = "ImCustomer"
    customer_group       = "CustomerGroup"
    customer_environment = "Dev"
  }

  external_working_dir = null
}

```

## Module Input Variables
----------------------
- `external_program` - (Required) A list of strings, whose first element is the program to run and whose subsequent elements are optional command line arguments to the program. Terraform does not execute the program through a shell, so it is not necessary to escape shell metacharacters nor add quotes around arguments containing spaces. (`default = []`)
- `external_query` - (Optional) A map of string values to pass to the external program as the query arguments. If not supplied, the program will receive an empty object as its input. (`default = {}`)
- `external_working_dir` - (Optional) Working directory of the program. If not supplied, the program will run in the current directory. (`default = null`)

## Module Output Variables
----------------------
- `data_external_result` - The result of data external


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
