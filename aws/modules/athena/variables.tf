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
  description = "A list of tag blocks. Each element should have keys named key, value, and propagate_at_launch."
  type        = map(string)
  default     = {}
}

#---------------------------------------------------
# ASW athena database
#---------------------------------------------------
variable "enable_athena_database" {
  description = "Enable athena DB usage"
  default     = false
}

variable "athena_database_name" {
  description = "Name of the database to create."
  default     = ""
}

variable "athena_database_bucket" {
  description = "(Required) Name of s3 bucket to save the results of the query execution."
  default     = ""
}

variable "athena_database_force_destroy" {
  description = "(Optional, Default: false) A boolean that indicates all tables should be deleted from the database so that the database can be destroyed without error. The tables are not recoverable."
  default     = false
}

variable "athena_database_encryption_configuration" {
  description = "(Optional) The encryption key block AWS Athena uses to decrypt the data in S3, such as an AWS Key Management Service (AWS KMS) key. An encryption_configuration block is documented below."
  default     = []
}

#---------------------------------------------------
# ASW athena named query
#---------------------------------------------------
variable "enable_athena_named_query" {
  description = "Enable athena named query usage"
  default     = false
}

variable "athena_named_query_name" {
  description = "The plain language name for the query. Maximum length of 128."
  default     = ""
}

variable "athena_named_query_workgroup" {
  description = "(Optional) The workgroup to which the query belongs. Defaults to primary"
  default     = "primary"
}

variable "athena_named_query_database" {
  description = "The database to which the query belongs."
  default     = ""
}

variable "athena_named_query_description" {
  description = "(Optional) A brief explanation of the query. Maximum length of 1024."
  default     = ""
}

variable "athena_named_query_query" {
  description = "(Required) The text of the query itself. In other words, all query statements. Maximum length of 262144."
  default     = ""
}

#---------------------------------------------------
# AWS athena workgroup
#---------------------------------------------------
variable "enable_athena_workgroup" {
  description = "Enable athena workgroup usage"
  default     = false
}

variable "athena_workgroup_name" {
  description = "Name of the workgroup."
  default     = ""
}

variable "athena_workgroup_description" {
  description = "(Optional) Description of the workgroup."
  default     = null
}

variable "athena_workgroup_state" {
  description = "(Optional) State of the workgroup. Valid values are DISABLED or ENABLED. Defaults to ENABLED."
  default     = null
}

variable "athena_workgroup_force_destroy" {
  description = "(Optional) The option to delete the workgroup and its contents even if the workgroup contains any named queries."
  default     = null
}

variable "athena_workgroup_configuration" {
  description = "(Optional) Configuration block with various settings for the workgroup."
  default     = []
}
