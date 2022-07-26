# Work with DLM via terraform

A terraform module for making DLM.


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

module "dlm" {
  source      = "../../modules/dlm"
  name        = "TEST"
  environment = "dev"

  enable_dlm_lifecycle_policy                                     = true
  dlm_lifecycle_policy_description                                = "Test DML lifecycle policy"
  dlm_lifecycle_policy_execution_role_arn                         = "arn:aws:iam::167127734783:role/admin-role"
  dlm_lifecycle_policy_state                                      = "ENABLED"
  dlm_lifecycle_policy_details_resource_types                     = ["VOLUME"]
  dlm_lifecycle_policy_details_schedule_name                      = ""
  dlm_lifecycle_policy_details_schedule_create_rule_interval      = 24
  dlm_lifecycle_policy_details_schedule_create_rule_interval_unit = "HOURS"
  dlm_lifecycle_policy_details_schedule_create_rule_times         = ["23:45"]
  dlm_lifecycle_policy_details_schedule_retain_rule_count         = 14
  dlm_lifecycle_policy_details_schedule_copy_tags                 = false

  target_tags = {}
  tags_to_add = {}
}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `region` - The region where to deploy this code (e.g. us-east-1). (`default = us-east-1`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_dlm_lifecycle_policy` - Enable dlm lifecycle policy (`default = False`)
- `dlm_lifecycle_policy_name` - Set dlm lifecycle policy name (`default = ""`)
- `dlm_lifecycle_policy_description` - A description for the DLM lifecycle policy. (`default = ""`)
- `dlm_lifecycle_policy_execution_role_arn` - (Required) The ARN of an IAM role that is able to be assumed by the DLM service. (`default = null`)
- `dlm_lifecycle_policy_state` - (Optional) Whether the lifecycle policy should be enabled or disabled. ENABLED or DISABLED are valid values. Defaults to ENABLED. (`default = ENABLED`)
- `dlm_lifecycle_policy_details_resource_types` - (Required) A list of resource types that should be targeted by the lifecycle policy. VOLUME is currently the only allowed value. (`default = ['VOLUME']`)
- `dlm_lifecycle_policy_details_schedule_name` - A name for the schedule. (`default = ""`)
- `dlm_lifecycle_policy_details_schedule_create_rule_interval` - (Required) How often this lifecycle policy should be evaluated. 1, 2,3,4,6,8,12 or 24 are valid values. (`default = 24`)
- `dlm_lifecycle_policy_details_schedule_create_rule_interval_unit` - (Optional) The unit for how often the lifecycle policy should be evaluated. HOURS is currently the only allowed value and also the default value. (`default = HOURS`)
- `dlm_lifecycle_policy_details_schedule_create_rule_times` - (Optional) A list of times in 24 hour clock format that sets when the lifecycle policy should be evaluated. Max of 1. (`default = ['23:45']`)
- `dlm_lifecycle_policy_details_schedule_retain_rule_count` - (Required) How many snapshots to keep. Must be an integer between 1 and 1000. (`default = 14`)
- `dlm_lifecycle_policy_details_schedule_copy_tags` - (Optional) Copy all user-defined tags on a source volume to snapshots of the volume created by this policy. (`default = False`)
- `target_tags` - (Required) A map of tag keys and their values. Any resources that match the resource_types and are tagged with any of these tags will be targeted. (`default = {}`)
- `tags_to_add` - (Optional) A map of tag keys and their values. DLM lifecycle policies will already tag the snapshot with the tags on the volume. This configuration adds extra tags on top of these. (`default = {}`)

## Module Output Variables
----------------------
- `dlm_lifecycle_policy_id` - Identifier of the DLM Lifecycle Policy.
- `dlm_lifecycle_policy_arn` - Amazon Resource Name (ARN) of the DLM Lifecycle Policy.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
