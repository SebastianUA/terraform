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
  description = "A list of tag blocks."
  type        = map(string)
  default     = {}
}

#-----------------------------------------------------------
# aws msk cluster
#-----------------------------------------------------------
variable "enable_msk_cluster" {
  description = "Enable AWS MSK usage"
  default     = false
}

variable "msk_cluster_name" {
  description = "(Required) Name of the MSK cluster."
  default     = ""
}

variable "msk_cluster_kafka_version" {
  description = "(Required) Specify the desired Kafka software version."
  default     = "2.3.1"
}

variable "msk_cluster_number_of_broker_nodes" {
  description = "(Required) The desired total number of broker nodes in the kafka cluster. It must be a multiple of the number of specified client subnets."
  default     = 3
}

variable "msk_cluster_broker_node_group_info" {
  description = "(Required) Configuration block for the broker nodes of the Kafka cluster."
  default     = []
}

variable "msk_cluster_encryption_info" {
  description = "(Optional) Configuration block for specifying encryption."
  default     = []
}

variable "msk_cluster_client_authentication" {
  description = "(Optional) Configuration block for specifying a client authentication."
  default     = []
}

variable "msk_cluster_configuration_info" {
  description = "(Optional) Configuration block for specifying a MSK Configuration to attach to Kafka brokers."
  default     = []
}

variable "msk_cluster_open_monitoring" {
  description = "Configuration block for settings for open monitoring."
  default     = []
}

variable "msk_cluster_logging_info_broker_logs_cloudwatch_logs" {
  description = "Set some settings for cloudwatch logs"
  default     = []
}

variable "msk_cluster_logging_info_broker_logs_firehose" {
  description = "Set some settings for firehose"
  default     = []
}

variable "msk_cluster_logging_info_broker_logs_s3" {
  description = "Set some settings for S3 "
  default     = []
}

variable "msk_cluster_enhanced_monitoring" {
  description = "(Optional) Specify the desired enhanced MSK CloudWatch monitoring level. Supports [DEFAULT PER_BROKER PER_TOPIC_PER_BROKER]"
  default     = null
}

#-----------------------------------------------------------
# AWS msk configuration
#-----------------------------------------------------------
variable "enable_msk_configuration" {
  description = "Enable msk configuration usage"
  default     = false
}

variable "msk_configuration_name" {
  description = "Name of the configuration."
  default     = ""
}

variable "msk_configuration_kafka_versions" {
  description = "(Required) List of Apache Kafka versions which can use this configuration."
  default     = ["2.1.0"]
}

variable "msk_configuration_server_properties" {
  description = "(Required) List of Apache Kafka versions which can use this configuration."
  default = [
    "auto.create.topics.enable = true",
    "delete.topic.enable = true"
  ]
}

variable "msk_configuration_description" {
  description = "(Optional) Description of the configuration."
  default     = null
}

#---------------------------------------------------
# Create aws msk scram secret association
#---------------------------------------------------
variable "enable_msk_scram_secret_association" {
  description = "Enable msk scram secret association usage"
  default     = false
}

variable "msk_scram_secret_association_cluster_arn" {
  description = "Amazon Resource Name (ARN) of the MSK cluster."
  default     = ""
}

variable "msk_scram_secret_association_secret_arn_list" {
  description = "(Required) List of AWS Secrets Manager secret ARNs."
  default     = []
}
