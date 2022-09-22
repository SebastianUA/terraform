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
# AWS kinesis stream
#---------------------------------------------------
variable "enable_kinesis_stream" {
  description = "Enable kinesis stream usage"
  default     = false
}

variable "kinesis_stream_name" {
  description = "A name to identify the stream. This is unique to the AWS account and region the Stream is created in."
  default     = ""
}

variable "kinesis_stream_shard_count" {
  description = "(Optional) The number of shards that the stream will use. If the stream_mode is PROVISIONED, this field is required. Amazon has guidelines for specifying the Stream size that should be referenced when creating a Kinesis stream. See Amazon Kinesis Streams for more."
  default     = null
}

variable "kinesis_stream_retention_period" {
  description = "(Optional) Length of time data records are accessible after they are added to the stream. The maximum value of a stream's retention period is 8760 hours. Minimum value is 24. Default is 24"
  default     = null
}

variable "kinesis_stream_shard_level_metrics" {
  description = "(Optional) A list of shard-level CloudWatch metrics which can be enabled for the stream. See Monitoring with CloudWatch for more. Note that the value ALL should not be used; instead you should provide an explicit list of metrics you wish to enable."
  default     = null
}

variable "kinesis_stream_enforce_consumer_deletion" {
  description = "(Optional) A boolean that indicates all registered consumers should be deregistered from the stream so that the stream can be destroyed without error. The default value is false"
  default     = null
}

variable "kinesis_stream_encryption_type" {
  description = "(Optional) The encryption type to use. The only acceptable values are NONE or KMS. The default value is NONE."
  default     = null
}

variable "kinesis_stream_kms_key_id" {
  description = "(Optional) The GUID for the customer-managed KMS key to use for encryption. You can also use a Kinesis-owned master key by specifying the alias alias/aws/kinesis."
  default     = null
}

variable "kinesis_stream_stream_mode_details" {
  description = "Optional) Indicates the capacity mode of the data stream."
  default     = {}
}

variable "kinesis_stream_timeouts" {
  description = "Set timeouts for kinesis stream"
  default     = {}
}

#---------------------------------------------------
# AWS kinesis stream consumer
#---------------------------------------------------
variable "enable_kinesis_stream_consumer" {
  description = "Enable kinesis stream consumer usage"
  default     = false
}

variable "kinesis_stream_consumer_name" {
  description = "Name of the stream consumer."
  default     = ""
}

variable "kinesis_stream_consumer_stream_arn" {
  description = "Amazon Resource Name (ARN) of the data stream the consumer is registered with."
  default     = ""
}
