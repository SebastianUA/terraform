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

variable "cluster_name" {
  description = "(Required) Name of the MSK cluster."
  default     = ""
}

variable "kafka_version" {
  description = "(Required) Specify the desired Kafka software version."
  default     = "2.3.1"
}

variable "number_of_broker_nodes" {
  description = "(Required) The desired total number of broker nodes in the kafka cluster. It must be a multiple of the number of specified client subnets."
  default     = 3
}

variable "broker_node_group_info" {
  description = "(Required) Configuration block for the broker nodes of the Kafka cluster."
  default     = []
}

# AWS msk cluster with encryption
variable "encryption_in_transit_client_broker" {
  description = "(Optional) Encryption setting for data in transit between clients and brokers. Valid values: TLS, TLS_PLAINTEXT, and PLAINTEXT. Default value: TLS_PLAINTEXT."
  default     = "TLS_PLAINTEXT"
}

variable "encryption_in_transit_in_cluster" {
  description = "(Optional) Whether data communication among broker nodes is encrypted. Default value: true."
  default     = true
}

variable "encryption_info_encryption_at_rest_kms_key_arn" {
  description = "(Optional) You may specify a KMS key short ID or ARN (it will always output an ARN) to use for encrypting your data at rest. If no key is specified, an AWS managed KMS ('aws/msk' managed service) key will be used for encrypting the data at rest."
  default     = ""
}

# AWS msk cluster with client authentication
variable "client_authentication_certificate_authority_arns" {
  description = "(Optional) List of ACM Certificate Authority Amazon Resource Names (ARNs)."
  default     = []
}

# AWS msk cluster with configuration info
variable "configuration_info" {
  description = "(Optional) Configuration block for specifying a MSK Configuration to attach to Kafka brokers."
  default     = []
}

# AWS enhanced monitoring
variable "enhanced_monitoring" {
  description = "(Optional) Specify the desired enhanced MSK CloudWatch monitoring level. Supports [DEFAULT PER_BROKER PER_TOPIC_PER_BROKER]"
  default     = "DEFAULT"
}

#-----------------------------------------------------------
# AWS msk configuration
#-----------------------------------------------------------
variable "enable_msk_configuration" {
  description = "Enable mask configuration usage"
  default     = false
}

variable "msk_configuration_name" {
  description = "Name of the configuration."
  default     = ""
}

variable "kafka_versions" {
  description = "(Required) List of Apache Kafka versions which can use this configuration."
  default     = ["2.1.0"]
}

variable "msk_configuration_description" {
  description = "(Optional) Description of the configuration."
  default     = ""
}

variable "server_properties" {
  description = "(Required) List of Apache Kafka versions which can use this configuration."
  default = [
    "auto.create.topics.enable = true",
    "delete.topic.enable = true"
  ]
}
