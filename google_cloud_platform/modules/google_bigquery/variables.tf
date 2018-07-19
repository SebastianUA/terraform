variable "name" {
    description = "A unique name for the resource, required by GCE. Changing this forces a new resource to be created."
    default     = "TEST"
}

variable "zone" {
  description = "The zone that the machine should be created in"
  default     = "us-east1-b"    
} 

variable "environment" {
    description = "Environment for service"
    default     = "STAGE"
}

variable "orchestration" {
    description = "Type of orchestration"
    default     = "Terraform"
}

variable "enable_bigquery_dataset" {
    description = "Enable bigquery dataset usage"
    default     = "true"
}

variable "dataset_id" {
    description = "(Required) A unique ID for the resource. Changing this forces a new resource to be created."
    default     = ""
}

variable "friendly_name" {
    description = "(Optional) A descriptive name for the dataset."
    default     = ""
}

variable "description" {
    description = "(Optional) A user-friendly description of the dataset."
    default     = ""
}

variable "project" {
    description = "(Optional) The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
    default     = ""
}

variable "location" {
    description = "(Optional) The geographic location where the dataset should reside. See official docs. There are two types of locations, regional or multi-regional. A regional location is a specific geographic place, such as Tokyo, and a multi-regional location is a large geographic area, such as the United States, that contains at least two geographic places. Possible regional values include: asia-northeast1 Possible multi-regional values:EU and US. The default value is multi-regional location US. Changing this forces a new resource to be created."
    default     = "US"
}

variable "default_table_expiration_ms" {
    description = "(Optional) The default lifetime of all tables in the dataset, in milliseconds. The minimum value is 3600000 milliseconds (one hour). Once this property is set, all newly-created tables in the dataset will have an expirationTime property set to the creation time plus the value in this property, and changing the value will only affect new tables, not existing ones. When the expirationTime for a given table is reached, that table will be deleted automatically. If a table's expirationTime is modified or removed before the table expires, or if you provide an explicit expirationTime when creating a table, that value takes precedence over the default expiration time indicated by this property."
    default     = "3600000"
}

variable "enable_bigquery_table" {
    description = "Enable bigquery table usage"
    default     = "false"
}

variable "table_id" {
    description = "(Required) A unique ID for the resource. Changing this forces a new resource to be created."
    default     = ""
}

variable "table_description" {
    description = "(Optional) The field description."
    default     = ""
}

variable "expiration_time" {
    description = "(Optional) The time when this table expires, in milliseconds since the epoch. If not present, the table will persist indefinitely. Expired tables will be deleted and their storage reclaimed."
    default     = "0"
}

variable "table_friendly_name" {
    description = "(Optional) A descriptive name for the table."
    default     = ""
}

variable "time_partitioning_type" {
    description = "(Required) The only type supported is DAY, which will generate one partition per day based on data loading time."
    default     = "DAY"
}
    
variable "time_partitioning_expiration_ms" {
    description = "(Optional) Number of milliseconds for which to keep the storage for a partition."
    default     = "0"
}

variable "time_partitioning_field" {
    description = "(Optional) The field used to determine how to create a time-based partition. If time-based partitioning is enabled without this value, the table is partitioned based on the load time."
    default     = ""
}

variable "view_query" {
    description = "(Required) A query that BigQuery executes when the view is referenced."
    default     = ""
}

variable "view_use_legacy_sql" {
    description = "(Optional) Specifies whether to use BigQuery's legacy SQL for this view. The default value is true. If set to false, the view will use BigQuery's standard SQL."
    default     = ""
}

variable "enable_bigquery_table_view" {
    description = "Enable bigquery table view usage"
    default     = "false"
}

variable "schema_file" {
    description = "(Optional) A JSON schema for the table."
    default     = "files/schema.json"
}
