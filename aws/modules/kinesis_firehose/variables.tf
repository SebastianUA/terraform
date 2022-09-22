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
# AWS kinesis firehose delivery stream
#---------------------------------------------------
variable "enable_kinesis_firehose_delivery_stream" {
  description = "Enable kinesis firehose delivery stream usage"
  default     = false
}

variable "kinesis_firehose_delivery_stream_name" {
  description = "A name to identify the stream. This is unique to the AWS account and region the Stream is created in."
  default     = ""
}

variable "kinesis_firehose_delivery_stream_destination" {
  description = "(Required) This is the destination to where the data is delivered. The only options are s3 (Deprecated, use extended_s3 instead), extended_s3, redshift, elasticsearch, splunk, and http_endpoint"
  default     = null
}

variable "kinesis_firehose_delivery_stream_kinesis_source_configuration" {
  description = "(Optional) Allows the ability to specify the kinesis stream that is used as the source of the firehose delivery stream."
  default     = {}
}

variable "kinesis_firehose_delivery_stream_server_side_encryption" {
  description = "(Optional) Encrypt at rest options. Server-side encryption should not be enabled when a kinesis stream is configured as the source of the firehose delivery stream."
  default     = {}
}

variable "kinesis_firehose_delivery_stream_s3_configuration" {
  description = "(Optional) Required for non-S3 destinations. For S3 destination, use extended_s3_configuration instead. Configuration options for the s3 destination (or the intermediate bucket if the destination is redshift)."
  default     = {}
}
variable "kinesis_firehose_delivery_stream_extended_s3_configuration" {
  description = "(Optional, only Required when destination is extended_s3) Enhanced configuration options for the s3 destination."
  default     = {}
}

variable "kinesis_firehose_delivery_stream_redshift_configuration" {
  description = "(Optional) Configuration options if redshift is the destination. Using redshift_configuration requires the user to also specify a s3_configuration block. "
  default     = {}
}

variable "kinesis_firehose_delivery_stream_elasticsearch_configuration" {
  description = "(Optional) Configuration options if elasticsearch is the destination."
  default     = {}
}

variable "kinesis_firehose_delivery_stream_splunk_configuration" {
  description = "(Optional) Configuration options if splunk is the destination."
  default     = {}
}

variable "kinesis_firehose_delivery_stream_http_endpoint_configuration" {
  description = "Optional) Configuration options if http_endpoint is the destination. requires the user to also specify a s3_configuration"
  default     = {}
}
