# Work with ROLESANYWHERE via terraform

A terraform module for making ROLESANYWHERE.


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
  region = "us-west-2"
}

module "rolesanywhere" {
  source = "../../modules/rolesanywhere"

  # Additionals vars will be added later
  
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
- `tags` - A list of tag blocks. (`default = {}`)
- `enable_rolesanywhere_profile` - Enable rolesanywhere profile usage (`default = False`)
- `rolesanywhere_profile_name` - The name of the Profile. (`default = ""`)
- `rolesanywhere_profile_role_arns` - (Required) A list of IAM roles that this profile can assume (`default = []`)
- `rolesanywhere_profile_duration_seconds` - (Optional) The number of seconds the vended session credentials are valid for. Defaults to 3600. (`default = null`)
- `rolesanywhere_profile_enabled` - (Optional) Whether or not the Profile is enabled. (`default = null`)
- `rolesanywhere_profile_managed_policy_arns` - (Optional) A list of managed policy ARNs that apply to the vended session credentials. (`default = null`)
- `rolesanywhere_profile_require_instance_properties` - (Optional) Specifies whether instance properties are required in CreateSession requests with this profile. (`default = null`)
- `rolesanywhere_profile_session_policy` - (Optional) A session policy that applies to the trust boundary of the vended session credentials. (`default = null`)
- `enable_rolesanywhere_trust_anchor` - Enable rolesanywhere trust anchor usage (`default = False`)
- `rolesanywhere_trust_anchor_name` - The name of the Trust Anchor. (`default = ""`)
- `rolesanywhere_trust_anchor_enabled` - (Optional) Whether or not the Trust Anchor should be enabled. (`default = null`)
- `rolesanywhere_trust_anchor_source` - (Required) The source of trust (`default = {}`)

## Module Output Variables
----------------------
- `rolesanywhere_profile_id` - The Profile ID.
- `rolesanywhere_profile_arn` - Amazon Resource Name (ARN) of the Profile
- `rolesanywhere_trust_anchor_id` - The Trust Anchor ID.
- `rolesanywhere_trust_anchor_arn` - Amazon Resource Name (ARN) of the Trust Anchor


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
