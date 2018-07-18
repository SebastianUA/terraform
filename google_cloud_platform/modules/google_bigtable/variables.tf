variable "name" {
    description = "A unique name for the resource, required by GCE. Changing this forces a new resource to be created."
    default     = "TEST"
}

variable "enable_bigtable_instance" {
  description = "Enable bigtable instance creating"
  default     = "true"    
} 

variable "environment" {
    description = "Environment for service"
    default     = "STAGE"
}

variable "cluster_id" {
    description = "(Required) The ID of the Cloud Bigtable cluster."
    default     = ""
}

variable "zone" {
    description = "(Required) The zone to create the Cloud Bigtable cluster in. Zones that support Bigtable instances are noted on the Cloud Bigtable locations page."
    default     = "us-east1-c"
}

variable "num_nodes" {
    description = "(Optional) The number of nodes in your Cloud Bigtable cluster. Minimum of 3 for a PRODUCTION instance. Cannot be set for a DEVELOPMENT instance."
    default     = "3"
}

variable "instance_type" {
    description = "(Optional) The instance type to create. One of 'DEVELOPMENT' or 'PRODUCTION'. Defaults to 'PRODUCTION'."
    default     = "PRODUCTION"
}

variable "storage_type" {
    description = "(Optional) The storage type to use. One of 'SSD' or 'HDD'. Defaults to 'SSD'."
    default     = "SSD"
}

variable "project" {
    description = "(Optional) The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
    default     = ""
}

variable "display_name" {
    description = "(Optional) The human-readable display name of the Bigtable instance. Defaults to the instance name."
    default     = ""
}

variable "enable_bigtable_table" {
    description = "Enable bigtable table usage"
    default     = "false"
}

variable "table_name" {
    description = "The name of the table."
    default     = ""
}

variable "instance_name" {
    description = "(Required) The name of the Bigtable instance."
    default     = ""
}

variable "split_keys" {
    description = "(Optional) A list of predefined keys to split the table on."
    default     = []
}
