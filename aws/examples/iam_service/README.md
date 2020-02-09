# Work with AWS IAM for service using via terraform
=======================

A terraform module for making IAM service.

## Usage
--------

Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = ">= 0.12.12"
}

provider "aws" {
    region  = "us-east-1"
    profile = "default"
}

module "iam_service" {
    source                                      = "../../modules/iam_service"
    name                                        = "TEST"
    environment                                 = "PROD"

    enable_iam_service_linked_role              = true
    iam_service_linked_role_aws_service_name    = "elasticbeanstalk.amazonaws.com"
    iam_service_linked_role_custom_suffix       = "custom-suffix-"
    iam_service_linked_role_description         = "Just test iam_service"
}
```

Module Input Variables
----------------------

- `name` - Name to be used on all resources as prefix (`default     = "TEST"`).
- `environment` - Environment for service (`default     = "STAGE"`).
- `orchestration` - Type of orchestration (`default     = "Terraform"`).
- `createdby` - Created by (`default     = "Vitaliy Natarov"`).
- `enable_iam_service_linked_role` - Enable IAM service linked role (`default       = false`).
- `iam_service_linked_role_aws_service_name` - (Required, Forces new resource) The AWS service to which this role is attached. You use a string similar to a URL but without the http:// in front. For example: elasticbeanstalk.amazonaws.com. To find the full list of services that support service-linked roles, check the docs. (`default       = ""`).
- `iam_service_linked_role_custom_suffix` - (Optional, forces new resource) Additional string appended to the role name. Not all AWS services support custom suffixes. (`default       = null`).
- `iam_service_linked_role_description` - (Optional) The description of the role. (`default       = null`).


Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.
