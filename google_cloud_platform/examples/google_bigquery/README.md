# Work with Google Cloud  Platform (google bigquery) via terraform

A terraform module for making google bigquery.
 
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
module "google_bigquery" {
    source                              = "../../modules/google_bigquery"
    name                                = "TEST"

    enable_bigquery_dataset             = true
    #
    #enable_bigquery_table               = true
    #dataset_id                          = "668"
    
}


```

Module Input Variables
----------------------
- `name` - "A unique name for the resource, required by GCE. Changing this forces a new resource to be created." (`    default     = "TEST"`)
- `zone` - "The zone that the machine should be created in" (`  default     = "us-east1-b"    `)
- `environment` - "Environment for service" (`    default     = "STAGE"`)
- `orchestration` - "Type of orchestration" (`    default     = "Terraform"`)
- `enable_bigquery_dataset` - "Enable bigquery dataset usage" (`    default     = "true"`)
- `dataset_id` - "(Required) A unique ID for the resource. Changing this forces a new resource to be created." (`    default     = ""`)
- `friendly_name` - "(Optional) A descriptive name for the dataset." (`    default     = ""`)
- `description` - "(Optional) A user-friendly description of the dataset." (`    default     = ""`)
- `project` - "(Optional) The ID of the project in which the resource belongs. If it is not provided, the provider project is used." (`    default     = ""`)
- `location` - "(Optional) The geographic location where the dataset should reside. See official docs. There are two types of locations, regional or multi-regional. A regional location is a specific geographic place, such as Tokyo, and a multi-regional location is a large geographic area, such as the United States, that contains at least two geographic places. Possible regional values include: asia-northeast1 Possible multi-regional values:EU and US. The default value is multi-regional location US. Changing this forces a new resource to be created." (`    default     = "US"`)
- `default_table_expiration_ms` - "(Optional) The default lifetime of all tables in the dataset, in milliseconds. The minimum value is 3600000 milliseconds (one hour). Once this property is set, all newly-created tables in the dataset will have an expirationTime property set to the creation time plus the value in this property, and changing the value will only affect new tables, not existing ones. When the expirationTime for a given table is reached, that table will be deleted automatically. If a table's expirationTime is modified or removed before the table expires, or if you provide an explicit expirationTime when creating a table, that value takes precedence over the default expiration time indicated by this property." (`    default     = "3600000"`)
- `enable_bigquery_table` - "Enable bigquery table usage" (`    default     = "false"`)
- `table_id` - "(Required) A unique ID for the resource. Changing this forces a new resource to be created." (`    default     = ""`)
- `table_description` - "(Optional) The field description." (`    default     = ""`)
- `expiration_time` - "(Optional) The time when this table expires, in milliseconds since the epoch. If not present, the table will persist indefinitely. Expired tables will be deleted and their storage reclaimed." (`    default     = "0"`)
- `table_friendly_name` - "(Optional) A descriptive name for the table." (`    default     = ""`)
- `time_partitioning_type` - "(Required) The only type supported is DAY, which will generate one partition per day based on data loading time." (`    default     = "DAY"`)
- `time_partitioning_expiration_ms` - "(Optional) Number of milliseconds for which to keep the storage for a partition." (`    default     = "0"`)
- `time_partitioning_field` - "(Optional) The field used to determine how to create a time-based partition. If time-based partitioning is enabled without this value, the table is partitioned based on the load time." (`    default     = ""`)
- `view_query` - "(Required) A query that BigQuery executes when the view is referenced." (`    default     = ""`)
- `view_use_legacy_sql` - "(Optional) Specifies whether to use BigQuery's legacy SQL for this view. The default value is true. If set to false, the view will use BigQuery's standard SQL." (`    default     = ""`)
- `enable_bigquery_table_view` - "Enable bigquery table view usage" (`    default     = "false"`)
- `schema_file` - "(Optional) A JSON schema for the table." (`    default     = "files/schema.json"`)


Authors
=======

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA)
(vitaliy.natarov@yahoo.com).

License
=======

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
