# Work with FMS via terraform

A terraform module for making FMS.


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

module "fms" {
  source = "../../modules/fms"

  enable_fms_admin_account = true
  fms_admin_account_id     = null
}

```

## Module Input Variables
----------------------
- `enable_fms_admin_account` - Enable fms admin account usage (`default = False`)
- `fms_admin_account_id` - (Optional) The AWS account ID to associate with AWS Firewall Manager as the AWS Firewall Manager administrator account. This can be an AWS Organizations master account or a member account. Defaults to the current account. Must be configured to perform drift detection. (`default = null`)

## Module Output Variables
----------------------
- `fms_admin_account_id` - The AWS account ID of the AWS Firewall Manager administrator account.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
