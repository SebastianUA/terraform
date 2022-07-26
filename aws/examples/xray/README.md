# Work with XRAY via terraform

A terraform module for making XRAY.


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

module "xray" {
  source      = "../../modules/xray"
  name        = "TEST"
  environment = "stage"

  enable_xray_sampling_rule         = true
  xray_sampling_rule_name           = "xray-test-sampling-rule"
  xray_sampling_rule_priority       = 1000
  xray_sampling_rule_version        = 1
  xray_sampling_rule_reservoir_size = 1
  xray_sampling_rule_fixed_rate     = 0.05
  xray_sampling_rule_url_path       = "*"
  xray_sampling_rule_host           = "*"
  xray_sampling_rule_http_method    = "*"
  xray_sampling_rule_service_type   = "*"
  xray_sampling_rule_service_name   = "*"
  xray_sampling_rule_resource_arn   = "*"

  xray_sampling_rule_attributes = tomap({
    "This"    = "is",
    "Vitaliy" = "Natarov"
  })

  # 
  enable_xray_encryption_config = true
  xray_encryption_config_type   = "NONE"

  # 
  enable_xray_group            = true
  xray_group_name              = "zray-group"
  xray_group_filter_expression = "responsetime > 5"

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
- `tags` - A list of tag blocks. Each element should have keys named key, value, etc. (`default = {}`)
- `enable_xray_sampling_rule` - Enable xray sampling rule usage (`default = False`)
- `xray_sampling_rule_name` - The name of the sampling rule. (`default = ""`)
- `xray_sampling_rule_priority` - (Required) The priority of the sampling rule. (`default = 1000`)
- `xray_sampling_rule_version` - (Required) The version of the sampling rule format (1 ) (`default = 1`)
- `xray_sampling_rule_reservoir_size` - (Required) A fixed number of matching requests to instrument per second, prior to applying the fixed rate. The reservoir is not used directly by services, but applies to all services using the rule collectively. (`default = 1`)
- `xray_sampling_rule_fixed_rate` - (Required) The percentage of matching requests to instrument, after the reservoir is exhausted. (`default = 0.05`)
- `xray_sampling_rule_url_path` - (Required) Matches the path from a request URL. (`default = *`)
- `xray_sampling_rule_host` - (Required) Matches the hostname from a request URL. (`default = *`)
- `xray_sampling_rule_http_method` - (Required) Matches the HTTP method of a request. (`default = *`)
- `xray_sampling_rule_service_type` - (Required) Matches the origin that the service uses to identify its type in segments. (`default = *`)
- `xray_sampling_rule_service_name` - (Required) Matches the name that the service uses to identify itself in segments. (`default = *`)
- `xray_sampling_rule_resource_arn` - (Required) Matches the ARN of the AWS resource on which the service runs. (`default = *`)
- `xray_sampling_rule_attributes` - (Optional) Matches attributes derived from the request. (`default = null`)
- `enable_xray_encryption_config` - Enable xray encryption config usage (`default = False`)
- `xray_encryption_config_type` - (Required) The type of encryption. Set to KMS to use your own key for encryption. Set to NONE for default encryption. (`default = NONE`)
- `xray_encryption_config_key_id` - (Optional) An AWS KMS customer master key (CMK) ARN. (`default = null`)
- `enable_xray_group` - Enable xray group usage (`default = False`)
- `xray_group_name` - The name of the group. (`default = ""`)
- `xray_group_filter_expression` - (Required) The filter expression defining criteria by which to group traces. more info can be found in official docs. (`default = null`)

## Module Output Variables
----------------------
- `xray_sampling_rule_id` - The name of the sampling rule.
- `xray_sampling_rule_arn` - The ARN of the sampling rule.
- `xray_encryption_config_id` - Region name.
- `xray_group_id` - The ID of the Group.
- `xray_group_arn` - The ARN of the Group.


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
