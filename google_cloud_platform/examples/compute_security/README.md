# Work with Google Cloud  Platform (compute security) via terraform

A terraform module for making google compute security policy.
 
## Usage
--------

Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "> 0.9.0"
}
provider "google" {
    credentials = "${file("/Users/captain/.config/gcloud/creds/terraform_creds.json")}"
    project     = "terraform-2018"
    region      = "us-east1"
}   

module "compute_security" {
    source                          = "../../modules/compute_security"
    name                            = "TEST"

    enable_compute_security_policy  = true
    rule                            = [
        {
            action   = "deny(403)"
            priority = "1000"
            match = [{
                versioned_expr = "SRC_IPS_V1"
                config = [{
                    src_ip_ranges = ["9.9.9.9/32"]
                },]
            },]
            description = "Deny access to IPs in 9.9.9.0/24"
        },
        {
            action   = "allow"
            priority = "2147483647"
            match = [{
                versioned_expr = "SRC_IPS_V1"
                config = [{
                    src_ip_ranges = ["*"]
                },]
            },]
            description = "default rule"
        },
    ]
}
```

Module Input Variables
----------------------
- `name` - "A unique name for the resource, required by GCE. Changing this forces a new resource to be created." (`    default     = "TEST"`)
- `environment` - "Environment for service" (`    default     = "STAGE"`)
- `project` - "The project in which the resource belongs. If it is not provided, the provider project is used." (`    default     = ""`)
- `enable_compute_security_policy` - "Enable compute security policy usage" (`    default     = "true"`)
- `description` - "(Optional) An optional description of this security policy. Max size is 2048." (`    default     = ""`)
- `rule_action` - "(Required) Action to take when match matches the request. Valid values: 'allow': allow access to target; 'deny(status)': deny access to target, returns the HTTP response code specified (valid values are 403, 404 and 502)" (`    default     = "allow"`)
- `rule_priority` - "(Required) An unique positive integer indicating the priority of evaluation for a rule. Rules are evaluated from highest priority (lowest numerically) to lowest priority (highest numerically) in order." (`    default     = "2147483647"`)
- `rule_description` - "(Optional) An optional description of this rule. Max size is 64." (`    default     = ""`)
- `rule_preview` - "(Optional) When set to true, the action specified above is not enforced. Stackdriver logs for requests that trigger a preview action are annotated as such." (`    default     = ""`)
- `match_versioned_expr` - "(Required) Predefined rule expression. Available options: SRC_IPS_V1: Must specify the corresponding src_ip_ranges field in config." (`    default     = "SRC_IPS_V1"`)
- `match_config_src_ip_ranges` - "(Required) Set of IP addresses or ranges (IPV4 or IPV6) in CIDR notation to match against inbound traffic. There is a limit of 5 IP ranges per rule. A value of '*' matches all IPs (can be used to override the default behavior)." (`    default     = ["*"]`)
- `rule` - "(Optional) The set of rules that belong to this policy. There must always be a default rule (rule with priority 2147483647 and match '*'). If no rules are provided when creating a security policy, a default rule with action 'allow' will be added. Structure is documented below." (`    default     = []`)

Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
