# Work with IAM_SERVICE via terraform

A terraform module for making IAM_SERVICE.


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
  region  = "us-east-1"
  profile = "default"
}

module "iam_service" {
  source      = "../../modules/iam_service"
  name        = "TEST-iam-service"
  environment = "stage"

  enable_iam_service_linked_role           = true
  iam_service_linked_role_aws_service_name = "elasticbeanstalk.amazonaws.com"
  iam_service_linked_role_custom_suffix    = "custom-suffix-"
  iam_service_linked_role_description      = "Just test iam_service"
}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `enable_iam_service_linked_role` - Enable IAM service linked role (`default = False`)
- `iam_service_linked_role_aws_service_name` - (Required, Forces new resource) The AWS service to which this role is attached. You use a string similar to a URL but without the http:// in front. For example: elasticbeanstalk.amazonaws.com. To find the full list of services that support service-linked roles, check the docs. (`default = ""`)
- `iam_service_linked_role_custom_suffix` - (Optional, forces new resource) Additional string appended to the role name. Not all AWS services support custom suffixes. (`default = null`)
- `iam_service_linked_role_description` - (Optional) The description of the role. (`default = null`)

## Module Output Variables
----------------------
- `iam_service_linked_role_id` - The Amazon Resource Name (ARN) of the role.
- `iam_service_linked_role_arn` - The Amazon Resource Name (ARN) specifying the role.
- `iam_service_linked_role_create_date` - The creation date of the IAM role.
- `iam_service_linked_role_name` - The name of the role.
- `iam_service_linked_role_path` - The path of the role.
- `iam_service_linked_role_unique_id` - The stable and unique string identifying the role.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
