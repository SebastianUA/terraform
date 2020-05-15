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

#---------------------------------------------------
# AWS cur report definition
#---------------------------------------------------
variable "enable_cur_report_definition" {
  description   = "Enable cur report definition usage"
  default       = false
}

variable "cur_report_definition_report_name" {
  description   = "(Required) Unique name for the report. Must start with a number/letter and is case sensitive. Limited to 256 characters."
  default       = ""
}

variable "cur_report_definition_time_unit" {
  description   = "(Required) The frequency on which report data are measured and displayed. Valid values are: HOURLY, DAILY."
  default       = "HOURLY"
}

variable "cur_report_definition_format" {
  description   = "(Required) Format for report. Valid values are: textORcsv."
  default       = "textORcsv"
}

variable "cur_report_definition_compression" {
  description   = "(Required) Compression format for report. Valid values are: GZIP, ZIP."
  default       = "GZIP"
}

variable "cur_report_definition_additional_schema_elements" {
  description   = "(Required) A list of schema elements. Valid values are: RESOURCES."
  default       = ["RESOURCES"]
}

variable "cur_report_definition_additional_artifacts" {
  description   = "(Required) A list of additional artifacts. Valid values are: REDSHIFT, QUICKSIGHT."
  default       = ["REDSHIFT", "QUICKSIGHT"]
}

variable "cur_report_definition_s3_bucket" {
  description   = "(Required) Name of the existing S3 bucket to hold generated reports."
  default       = null
}

variable "cur_report_definition_s3_region" {
  description   = "(Required) Region of the existing S3 bucket to hold generated reports."
  default       = null
}

variable "cur_report_definition_s3_prefix" {
  description   = "(Optional) Report path prefix. Limited to 256 characters."
  default       = null
}
