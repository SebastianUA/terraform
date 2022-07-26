# Work with IAM_ROLE via terraform

A terraform module for making IAM_ROLE.


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

module "iam_role" {
  source      = "../../modules/iam_role"
  name        = "TEST-role"
  environment = "stage"

  # Using IAM role
  enable_iam_role      = true
  iam_role_name        = "tf-role-for-testing"
  iam_role_description = "It's just a simple IAM role to test TF module"
  # Inside additional_files directory I will add additional policies for assume_role_policy usage in the future....
  iam_role_assume_role_policy = file("additional_files/assume_role_policy_with_mfa.json")

  iam_role_force_detach_policies = true
  iam_role_path                  = "/"
  iam_role_max_session_duration  = 3600

  # Using IAM role policy
  enable_iam_role_policy = true
  iam_role_policy_name   = "my-iam-role-policy-for-testing-terraform"
  iam_role_policy        = file("additional_files/policy.json")

  # Using IAM role policy attachment
  enable_iam_role_policy_attachment      = false
  iam_role_policy_attachment_policy_arns = ["test"]

  # Using IAM instance profile
  enable_iam_instance_profile = true
  iam_instance_profile_name   = "tf-role-for-testing"

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys (`default = {}`)
- `enable_iam_role` - Enable IAM role creation (`default = False`)
- `iam_role_name` - The name of the role (`default = ""`)
- `iam_role_name_prefix` - (Optional, Forces new resource) Creates a unique name beginning with the specified prefix. Conflicts with iam_role_name. (`default = ""`)
- `iam_role_description` - (Optional) The description of the role. (`default = ""`)
- `iam_role_assume_role_policy` - File with assume role policy (`default = ""`)
- `iam_role_force_detach_policies` - (Optional) Specifies to force detaching any policies the role has before destroying it. Defaults to false. (`default = False`)
- `iam_role_path` - (Optional) The path to the role. See IAM Identifiers for more information. Defaults is '/' (`default = /`)
- `iam_role_max_session_duration` - (Optional) The maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours. (`default = 3600`)
- `iam_role_permissions_boundary` - (Optional) The ARN of the policy that is used to set the permissions boundary for the role. (`default = null`)
- `enable_iam_role_policy` - Enable IAM policy usage/creation (`default = False`)
- `iam_role_policy_name` - (Optional) The name of the role policy. If omitted, Terraform will assign a random, unique name. (`default = ""`)
- `iam_role_policy_name_prefix` - (Optional) Creates a unique name beginning with the specified prefix. Conflicts with iam_role_policy_name. (`default = ""`)
- `iam_role_policy_role` - (Required) The IAM role to attach to the policy. (`default = ""`)
- `iam_role_policy` - (Required) The policy document. This is a JSON formatted string. For more information about building IAM policy documents with Terraform, see the AWS IAM Policy Document Guide (`default = ""`)
- `enable_iam_role_policy_attachment` - Enable IAM role policy attachment usage (`default = False`)
- `iam_role_policy_attachment_role` - Set role for role policy attachment (`default = ""`)
- `iam_role_policy_attachment_policy_arns` - (Required) - The list of ARNs of the policy you want to apply (`default = []`)
- `enable_iam_instance_profile` - Enable IAM instance profile (`default = False`)
- `iam_instance_profile_name` - The profile's name (`default = ""`)
- `iam_instance_profile_role` - (Optional) The role name to include in the profile. (`default = null`)

## Module Output Variables
----------------------
- `iam_role_arn` - The Amazon Resource Name (ARN) specifying the role.
- `iam_role_name` - The name of the role.
- `iam_role_id` - The name of the role.
- `iam_role_policy_id` - The role policy ID, in the form of role_name:role_policy_name.
- `iam_role_policy_name` - The name of the policy.
- `iam_role_policy_policy` - The policy document attached to the role.
- `iam_role_policy_role` - The name of the role associated with the policy.
- `iam_role_policy_attachment_id` - ID
- `iam_role_policy_attachment_role` - (Required) - The role the policy should be applied to
- `iam_role_policy_attachment_policy_arn` - (Required) - The ARN of the policy you want to apply
- `instance_profile_id` - The instance profile's ID.
- `instance_profile_uid` - The unique ID assigned by AWS.
- `instance_profile_arn` - The ARN assigned by AWS to the instance profile.
- `instance_profile_create_date` - The creation timestamp of the instance profile.
- `instance_profile_name` - The instance profile's name.
- `instance_profile_path` - The path of the instance profile in IAM.
- `instance_profile_role` - The role assigned to the instance profile.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
