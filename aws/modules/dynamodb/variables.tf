#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST"
}

variable "environment" {
    description = "Environment for service"
    default     = "STAGE"
}

variable "tags" {
    description = "A list of tag blocks. Each element should have keys named key, value, etc."
    type        = map(string)
    default     = {}
}

#---------------------------------------------------
# AWS dynamodb table
#---------------------------------------------------
variable "enable_dynamodb_table" {
  description   = "Enable dynamodb table usage"
  default       = false
}

variable "dynamodb_table_name" {
  description   = "The name of the table, this needs to be unique within a region."
  default       = ""
}

variable "dynamodb_table_hash_key" {
  description   = "(Required, Forces new resource) The attribute to use as the hash (partition) key. Must also be defined as an attribute"
  default       = null
}

variable "dynamodb_table_attribute" {
  description   = "description"
  default       = []
}

variable "dynamodb_table_billing_mode" {
  description   = "(Optional) Controls how you are charged for read and write throughput and how you manage capacity. The valid values are PROVISIONED and PAY_PER_REQUEST. Defaults to PROVISIONED"
  default       = "PROVISIONED"
}

variable "dynamodb_table_range_key" {
  description   = "(Optional, Forces new resource) The attribute to use as the range (sort) key. Must also be defined as an attribute"
  default       = null
}

variable "dynamodb_table_write_capacity" {
  description   = " (Optional) The number of write units for this table. If the billing_mode is PROVISIONED, this field is required."
  default       = null
}

variable "dynamodb_table_read_capacity" {
  description   = "(Optional) The number of read units for this table. If the billing_mode is PROVISIONED, this field is required."
  default       = null
}

variable "dynamodb_table_stream_enabled" {
  description   = "(Optional) Indicates whether Streams are to be enabled (true) or disabled (false)"
  default       = false
}

variable "dynamodb_table_stream_view_type" {
  description   = "(Optional) When an item in the table is modified, StreamViewType determines what information is written to the table's stream. Valid values are KEYS_ONLY, NEW_IMAGE, OLD_IMAGE, NEW_AND_OLD_IMAGES."
  default       = null
}

variable "dynamodb_table_ttl" {
  description   = " (Optional) Defines ttl, has two properties, and can only be specified"
  default       = []
}

variable "dynamodb_table_local_secondary_index" {
  description   = "(Optional, Forces new resource) Describe an LSI on the table; these can only be allocated at creation so you cannot change this definition after you have created the resource."
  default       = []
}

variable "dynamodb_table_global_secondary_index" {
  description   = "(Optional) Describe a GSI for the table; subject to the normal limits on the number of GSIs, projected attributes, etc."
  default       = []
}

variable "dynamodb_table_server_side_encryption" {
  description   = "(Optional) Encryption at rest options. AWS DynamoDB tables are automatically encrypted at rest with an AWS owned Customer Master Key if this argument isn't specified."
  default       = []
}

variable "dynamodb_table_point_in_time_recovery" {
  description   = "(Optional) Point-in-time recovery options."
  default       = []
}

variable "dynamodb_table_timeouts" {
  description   = "The timeouts block allows you to specify timeouts for certain actions."
  default       = []
}

#---------------------------------------------------
# AWS dynamodb table item
#---------------------------------------------------
variable "enable_dynamodb_table_item" {
  description   = "Enable dynamodb table item usage"
  default       = false
}

variable "dynamodb_table_item_table_name" {
  description   = "The name of the table to contain the item."
  default       = ""
}

variable "dynamodb_table_item_hash_key" {
  description   = "Hash key to use for lookups and identification of the item"
  default       = ""
}

variable "dynamodb_table_item_item" {
  description   = "(Required) JSON representation of a map of attribute name/value pairs, one for each attribute. Only the primary key attributes are required; you can optionally provide other attribute name-value pairs for the item."
  default       = null
}

variable "dynamodb_table_item_range_key" {
  description   = "(Optional) Range key to use for lookups and identification of the item. Required if there is range key defined in the table."
  default       = null
}

#---------------------------------------------------
# AWS dynamodb global table
#---------------------------------------------------
variable "enable_dynamodb_global_table" {
  description   = "Enable dynamodb global table usage"
  default       = false
}

variable "dynamodb_global_table_name" {
  description   = "The name of the global table. Must match underlying DynamoDB Table names in all regions."
  default       = ""
}

variable "dynamodb_global_table_replica" {
  description   = "(Required) Underlying DynamoDB Table. At least 1 replica must be defined."
  default       = []
}
