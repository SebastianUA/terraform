# Work with Google Cloud  Platform (compute url map) via terraform

A terraform module for making google compute url map.
 
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

module "compute_url" {
    source                          = "../../modules/compute_url"
    name                            = "TEST"

    enable_compute_url_map          = true

    default_service                 = ""
    # Set rules for host_rule
    host_rule_hosts                 = []
    host_rule_path_matcher          = ""
    # Set rules for path_matcher
    path_matcher_name               = ""
    path_rule                       = [
        {
            paths   = ["/home"]
            service = "home"
        },
        {
            paths   = ["/login"]
            service = "login"
        }
    ]
    # Set rules for test
    test_service                    = ""
    test_host                       = ""
    test_path                       = ""
    
}
```

Module Input Variables
----------------------
- `name` - "A unique name for the resource, required by GCE. Changing this forces a new resource to be created." (`    default     = "TEST"`)
- `environment` - "Environment for service" (`    default     = "STAGE"`)
- `project` - "The project in which the resource belongs. If it is not provided, the provider project is used." (`    default     = ""`)
- `description` - "(Optional) A brief description of this resource." (`    default     = ""`)
- `default_service` - "(Required) The backend service or backend bucket to use when none of the given rules match." (`    default     = ""`)
- `enable_compute_url_map` - "Enable compute url map usage" (`    default     = "false"`)
- `host_rule_hosts` - "(Required) - The list of host patterns to match." (`    default     = []`)
- `host_rule_path_matcher` - "(Required) The name of the path_matcher to apply this host rule to." (`    default     = ""`)
- `host_rule_description` - "(Optional) An optional description of the host rule." (`    default     = ""`)
- `test_service` - "(Required) The backend service or backend bucket link that should be matched by this test." (`    default     = ""`)
- `test_host` - "(Required) The host component of the URL being tested." (`    default     = ""`)
- `test_path` - "(Required) The path component of the URL being tested." (`    default     = ""`)
- `test_description` - "(Optional) An optional description of this test." (`    default     = ""`)
- `path_rule_paths` - "(Required) The list of paths to match against." (`    default     = []`)
- `path_rule_service` - "(Required) The backend service or backend bucket to use if any of the given paths match." (`    default     = ""`)
- `path_rule` - "Rules for path_rule" (`    default     = []`)
- `path_matcher_name` - "(Required) The name of the path_matcher resource." (`    default     = ""`)


Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
