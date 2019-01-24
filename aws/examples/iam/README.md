# Work with AWS IAM via terraform
=======================

A terraform module for making IAM.

## Usage
--------

Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = ">= 0.11.11"
}
provider "aws" {
    region  = "us-east-1"
    profile = "default"
}

module "aim" {
    source                          = "../../modules/iam"
    name                            = "TEST-AIM"
    environment                     = "PROD"

    enable_iam_role                 = true
    # if you would like to set custom name for role, use iam_role_name;
    iam_role_name                   = ""
    assume_role_policy_file         = "additional_files/policies/test_policy_principal.json"

    enable_iam_instance_profile     = false

    enable_iam_policy               = true
    iam_policy_file                 = "additional_files/policies/test_policy.json"
    enable_iam_policy_attachment    = true

    enable_crossaccount_role        = false
    cross_acc_principal_arns        = ["222222222222222","arn:aws:iam::333333333333:user/test"]
    cross_acc_policy_arns           = ["arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser", "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"] 
                                         
    enable_iam_server_certificate   = false
    certificate_body_file           = "additional_files/certs/example.crt.pem"
    private_key_file                = "additional_files/certs/example.key.pem"
}
```

Module Input Variables
----------------------

- `name` - Name to be used on all resources as prefix (`default = TEST-AIM`).
- `environment` - Environment for service (`default = STAGE`). Just uses for a tags
- `orchestration` -  Type of orchestration (`default     = "Terraform"`).
- `createdby` - Created by (`default     = "Vitaliy Natarov"`).
- `enable_iam_role` - Enable IAM role creation (`default     = false`).
- `iam_role_name` - The name of the role (`default     = ""`).
- `iam_role_force_detach_policies` - (Optional) Specifies to force detaching any policies the role has before destroying it. Defaults to false (`default     = false`).
- `iam_role_path` - (Optional) The path to the role. See IAM Identifiers for more information. Defaults is '/' (`default     = "/"`).
- `iam_role_max_session_duration` - (Optional) The maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours (`default     = 3600`).
- `iam_role_permissions_boundary` - (Optional) The ARN of the policy that is used to set the permissions boundary for the role (`default     = ""`).
- `assume_role_policy_file` - Json file with assume role policy (`default     = ""`).
- `enable_iam_instance_profile` - Enable IAM instance profile (`default     = false`).
    description = ""
- `iam_instance_profile_name` - The profile's name (`default     = ""`).
- `iam_instance_profile_role` - (Optional) The role name to include in the profile (`default     = ""`).
- `enable_iam_policy` - Enable IAM policy usage/creation (`default     = false`).
- `iam_policy_path` - (Optional, default '/') Path in which to create the policy. See IAM Identifiers for more information (`default     = "/"`).
- `iam_policy_file` - File with policy (`default     = ""`).
- `iam_policy_name` - Set custom policy name (`default     = ""`).
- `enable_crossaccount_role` - Enabling cross account role (`default     = false`).
- `cross_account_assume_role_name` - Set custom cross account assume role name (`default     = ""`).
- `enable_iam_policy_attachment` - Enabling IAM policy attachment (`default     = false`).
- `iam_policy_attachment_name` - Set custom iam policy attachment name (`default     = ""`).
- `cross_acc_principal_arns` - ARNs of accounts, groups, or users with the ability to assume this role (`default     = ["222222222222","arn:aws:iam::333333333333:user/MyUser"]`).
- `cross_acc_policy_arns` - List of ARNs of policies to be associated with the created IAM role (`default     = ["arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser", "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"]`).
- `enable_iam_server_certificate` - Allow upload server certificate (`default     = false`).
- `iam_server_certificate_name` - Set custom iam server cert name (`default     = ""`).
- `certificate_body_file` - Path to the crt file (`default     = ""`).
- `private_key_file` - Path to the private key file (`default     = ""`).
 

Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.
