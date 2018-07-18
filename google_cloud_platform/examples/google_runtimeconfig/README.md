# Work with Google Cloud  Platform (google runtimeconfig) via terraform

A terraform module for making google runtimeconfig.
 
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
module "google_runtimeconfig" {
    source                                      = "../../modules/google_runtimeconfig"
    name                                        = "TEST"
                                        
    # variable with text
    #enable_runtimeconfig_variable_text_usage    = "true"
    #runtimeconfig_config_name                   = "test-rc-config-stage"
    #text                                        = "linux-notes.org"

    # variable with value
    #enable_runtimeconfig_variable_value_usage   = true
    #runtimeconfig_config_name                   = "test-rc-config-stage"
    #value                                       = "test2"
    #value_file                                  = "files/file_name.dat"
    
}    
```

Module Input Variables
----------------------
- `name` - "A unique name for the resource, required by GCE. Changing this forces a new resource to be created." (`    default     = "TEST"`)
- `environment` - "Environment for service" (`    default     = "STAGE"`)
- `description` - "(Optional) The description to associate with the runtime config." (`    default     = ""`)
- `project` - "(Optional) The ID of the project in which the resource belongs. If it is not provided, the provider project is used." (`    default     = ""`)
- `enable_runtimeconfig_variable_text_usage` - "Enable runtimeconfig variable with text usage" (`    default     = "false"`)
- `runtimeconfig_config_name` - "(Required) The name of the RuntimeConfig resource containing this variable." (`    default     = ""`)
- `text` - "(Required) The content to associate with the variable. Exactly one of text or variable must be specified. If text is specified, it must be a valid UTF-8 string and less than 4096 bytes in length. If value is specified, it must be base64 encoded and less than 4096 bytes in length." (`    default     = ""`)
- `value` - "(Required) The content to associate with the variable. Exactly one of text or variable must be specified. If text is specified, it must be a valid UTF-8 string and less than 4096 bytes in length. If value is specified, it must be base64 encoded and less than 4096 bytes in length." (`    default     = ""`)
- `enable_runtimeconfig_variable_value_usage` - "Enable runtimeconfig variable with value usage" (`    default     = "false"`)
- `value_file` - "Path to file with value data" (`    default     = "files/file_name.dat"`)


Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
