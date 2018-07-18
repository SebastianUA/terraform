# Work with Google Cloud  Platform (google bigtable) via terraform

A terraform module for making google bigtable.
 
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
module "google_bigtable" {
    source                              = "../../modules/google_bigtable"
    name                                = "TEST"

    enable_bigtable_instance            = true
    # table
    #enable_bigtable_table               = true
    #instance_name                       = "test-bt-instance-stage"
    #split_keys                          = ["a", "b", "c"]
}           

module "google_bigtable_table" {
    source                              = "../../modules/google_bigtable"
    name                                = "TEST"

    enable_bigtable_instance            = false
    enable_bigtable_table               = true
    instance_name                       = "${element(module.google_bigtable.google_bigtable_instance_name, 0)}"
    split_keys                          = ["a", "b", "c"]

}
```

Module Input Variables
----------------------
- `name` - "A unique name for the resource, required by GCE. Changing this forces a new resource to be created." (`    default     = "TEST"`)
- `enable_bigtable_instance` - "Enable bigtable instance creating" (`  default     = "true"    `)
- `environment` - "Environment for service" (`    default     = "STAGE"`)
- `cluster_id` - "(Required) The ID of the Cloud Bigtable cluster." (`    default     = ""`)
- `zone` - "(Required) The zone to create the Cloud Bigtable cluster in. Zones that support Bigtable instances are noted on the Cloud Bigtable locations page." (`    default     = "us-east1-c"`)
- `num_nodes` - "(Optional) The number of nodes in your Cloud Bigtable cluster. Minimum of 3 for a PRODUCTION instance. Cannot be set for a DEVELOPMENT instance." (`    default     = "3"`)
- `instance_type` - "(Optional) The instance type to create. One of 'DEVELOPMENT' or 'PRODUCTION'. Defaults to 'PRODUCTION'." (`    default     = "PRODUCTION"`)
- `storage_type` - "(Optional) The storage type to use. One of 'SSD' or 'HDD'. Defaults to 'SSD'." (`    default     = "SSD"`)
- `project` - "(Optional) The ID of the project in which the resource belongs. If it is not provided, the provider project is used." (`    default     = ""`)
- `display_name` - "(Optional) The human-readable display name of the Bigtable instance. Defaults to the instance name." (`    default     = ""`)
- `enable_bigtable_table` - "Enable bigtable table usage" (`    default     = "false"`)
- `table_name` - "The name of the table." (`    default     = ""`)
- `instance_name` - "(Required) The name of the Bigtable instance." (`    default     = ""`)
- `split_keys` - "(Optional) A list of predefined keys to split the table on." (`    default     = []`)


Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
