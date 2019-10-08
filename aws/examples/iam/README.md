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
    iam_role_name                   = "test_assume_role2"
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

#------------------------------------------------------------------------------
# Create user
#------------------------------------------------------------------------------
module "aim_user" {
    source                          = "../../modules/iam"

    name                            = "TEST-AIM-user"
    environment                     = "PROD"

    enable_iam_user                 = "true"
    iam_user_name                   = "aws-msk-user"
    iam_user_path                   = "/"
}

module "iam_user_ssh_key" {
    source                          = "../../modules/iam"

    enable_iam_user_ssh_key         = "true"
    iam_user_ssh_key_username       = "${module.aim_user.aws_iam_user_name}"
    
    iam_user_ssh_key_encoding       = "SSH"
    iam_user_ssh_key_public_key     = "${file("/Users/captain/.ssh/id_rsa.pub")}"
}

module  "iam_access_key" {
    source                          = "../../modules/iam"

    enable_iam_access_key           = "true"
    iam_access_key_user             = "${module.aim_user.aws_iam_user_name}"
    iam_access_key_pgp_key          = "keybase:captainua"
}

module "iam_user_policy" {
    source                          = "../../modules/iam"

    enable_iam_user_policy          = "true"
    iam_user_policy_name            = "policy-for-user"
    iam_user_policy_user            = "${module.aim_user.aws_iam_user_name}"
    iam_user_policy_policy          = "${file("additional_files/policies/iam_user_policy.json")}"
}

module "iam_user_login_profile" {
    source                                          = "../../modules/iam"

    enable_iam_user_login_profile                   = "true"
    iam_user_login_profile_user                     = "${module.aim_user.aws_iam_user_name}"
    iam_user_login_profile_pgp_key                  = "keybase:captainua"
    #iam_user_login_profile_pgp_key                  = "keybase:${module.aim_user.aws_iam_user_name}"
        
    iam_user_login_profile_password_length          = "20"
    iam_user_login_profile_password_reset_required  = "true"
    
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
- `assume_role_policy_file` - File with assume role policy (`default     = ""`).
- `iam_role_force_detach_policies` - (Optional) Specifies to force detaching any policies the role has before destroying it. Defaults to false (`default     = false`).
- `iam_role_path` - (Optional) The path to the role. See IAM Identifiers for more information. Defaults is '/' (`default     = "/"`).
- `iam_role_max_session_duration` - (Optional) The maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours. (`default     = 3600`).
- `iam_role_permissions_boundary` - (Optional) The ARN of the policy that is used to set the permissions boundary for the role. (`default     = ""`).
- `enable_iam_instance_profile` - Enable IAM instance profile (`default     = false`).
- `iam_instance_profile_name` - The profile's name (`default     = ""`).
- `iam_instance_profile_role` - (Optional) The role name to include in the profile. (`default     = ""`).
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
- `enable_iam_user` - Enable iam_user usage (`default     = "false"
- `iam_user_name` - (Required) The user's name. The name must consist of upper and lowercase alphanumeric characters with no spaces. You can also include any of the following characters: =,.@-_.. User names are not distinguished by case. For example, you cannot create users named both 'TESTUSER' and 'testuser' (`default     = ""`).
- `iam_user_path` - (Optional, default '/') Path in which to create the user (`default     = "/"`).
- `permissions_boundary` - (Optional) The ARN of the policy that is used to set the permissions boundary for the user. (`default     = ""`).
- `force_destroy` - (Optional, default false) When destroying this user, destroy even if it has non-Terraform-managed IAM access keys, login profile or MFA devices. Without force_destroy a user with non-Terraform-managed access keys and login profile will fail to be destroyed (`default     = "false"`).
- `enable_iam_user_policy` - Enable iam user policy usage (`default     = "false"`).
- `iam_user_policy_name` - (Optional) The name of the policy. If omitted, Terraform will assign a random, unique name (`default     = ""`).
- `iam_user_policy_user` - (Required) IAM user to which to attach this policy (`default     = ""`).
- `iam_user_policy_policy` - (Required) IAM user to which to attach this policy (`default     = ""`).
- `enable_iam_user_policy_name_prefix` - Enable to use iam_user_policy with prefix (`default     = "false"`).
- `iam_user_policy_name_prefix` - (Optional, Forces new resource) Creates a unique name beginning with the specified prefix. Conflicts with name (`default     = "prefix-"`).
- `enable_iam_user_policy_attachment` - Enable iam_user_policy_attachment usage (`default     = "false"`).
- `iam_user_policy_attachment_name` - (Required) - The user the policy should be applied to (`default     = ""`).
- `iam_user_policy_attachment_policy_arn` - (Required) - The ARN of the policy you want to apply (`default     = ""`).
- `enable_iam_user_ssh_key` - Enable iam_user_ssh_key usage (`default     = "false"`).
- `iam_user_ssh_key_username` - (Required) The name of the IAM user to associate the SSH public key with (`default     = ""`).
- `iam_user_ssh_key_encoding` - (Required) Specifies the public key encoding format to use in the response To retrieve the public key in ssh-rsa format, use SSH. To retrieve the public key in PEM format, use PEM. (`default     = "SSH"`).
- `iam_user_ssh_key_public_key` - (Required) The SSH public key. The public key must be encoded in ssh-rsa format or PEM format. (`default     = ""`).
- `iam_user_ssh_key_status` - (Optional) The status to assign to the SSH public key. Active means the key can be used for authentication with an AWS CodeCommit repository. Inactive means the key cannot be used. Default is Active. (`default     = "Active"`).
- `enable_iam_access_key` - Enable iam_access_key  usage (`default     = "false"`).
- `iam_access_key_user` - (Required) The IAM user to associate with this access key (`default     = ""`).
- `iam_access_key_pgp_key` - (Optional) Either a base-64 encoded PGP public key, or a keybase username in the form keybase:some_person_that_exists (`default     = ""`).
- `iam_access_key_status` - (Optional) The access key status to apply. Defaults to Active. Valid values are Active and Inactive (`default     = "Active"
- `enable_iam_user_login_profile` - Enable iam_user_login_profile usage (`default     = "false"`).
- `iam_user_login_profile_user` - (Required) The IAM user's name. (`default     = ""`).
- `iam_user_login_profile_pgp_key` - (Required) Either a base-64 encoded PGP public key, or a keybase username in the form keybase:username. Only applies on resource creation. Drift detection is not possible with this argument (`default     = "keybase:some_person_that_exists"`).
- `iam_user_login_profile_password_length` - (Optional, default 20) The length of the generated password on resource creation. Only applies on resource creation. Drift detection is not possible with this argument (`default     = "20"`).
- `iam_user_login_profile_password_reset_required` -  (Optional, default 'true') Whether the user should be forced to reset the generated password on resource creation. Only applies on resource creation. Drift detection is not possible with this argument (`default     = "true"`).
- `enable_iam_user_group_membership` - Enable iam_user_group_membership usage (`default     = "false"`).
- `iam_user_group_membership_user` - (Required) The name of the IAM User to add to groups (`default     = ""`).
- `iam_user_group_membership_groups` - (Required) A list of IAM Groups to add the user to (`default     = []`).
 

Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See LICENSE for full details.
