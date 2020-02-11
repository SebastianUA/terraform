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
variable "region" {
  description = "The region where to deploy this code (e.g. us-east-1)."
  default     = "us-east-1"
} 

variable "orchestration" {
  description = "Type of orchestration"
  default     = "Terraform"
}

variable "createdby" {
  description = "Created by"
  default     = "Vitaliy Natarov"
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

variable "force_destroy" {
  description = "(Optional, Default: false) A boolean that indicates all tables should be deleted from the database so that the database can be destroyed without error. The tables are not recoverable."
  default     = false
}

# variable "athena_database_encryption_configuration" {
#   description = "(Optional) The encryption key block AWS Athena uses to decrypt the data in S3, such as an AWS Key Management Service (AWS KMS) key. An encryption_configuration block is documented below."
#   default     = []
#}

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
  default     = "ENABLED"
}

variable "athena_workgroup_bytes_scanned_cutoff_per_query" {
  description = "(Optional) Integer for the upper data usage limit (cutoff) for the amount of bytes a single query in a workgroup is allowed to scan. Must be at least 10485760."
  default     = 10485760
}

variable "athena_workgroup_enforce_workgroup_configuration" {
  description = "(Optional) Boolean whether the settings for the workgroup override client-side settings. For more information, see Workgroup Settings Override Client-Side Settings. Defaults to true."
  default     = true
}

variable "athena_workgroup_publish_cloudwatch_metrics_enabled" {
  description = "(Optional) Boolean whether Amazon CloudWatch metrics are enabled for the workgroup. Defaults to true."
  default     = true
}

variable "athena_workgroup_output_location" {
  description = "(Optional) The location in Amazon S3 where your query results are stored, such as s3://path/to/query/bucket/. For more information, see Queries and Query Result Files."
  default     = null
}

variable "athena_workgroup_encryption_option" {
  description = "(Required) Indicates whether Amazon S3 server-side encryption with Amazon S3-managed keys (SSE-S3), server-side encryption with KMS-managed keys (SSE-KMS), or client-side encryption with KMS-managed keys (CSE-KMS) is used. If a query runs in a workgroup and the workgroup overrides client-side settings, then the workgroup's setting for encryption is used. It specifies whether query results must be encrypted, for all queries that run in this workgroup."
  default     = null
}

variable "athena_workgroup_kms_key_arn" {
  description = "(Optional) For SSE-KMS and CSE-KMS, this is the KMS key Amazon Resource Name (ARN)."
  default     = null
}