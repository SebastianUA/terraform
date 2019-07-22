#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST-MSK"
}

variable "region" {
  description = "The region where to deploy this code (e.g. us-east-1)."
  default     = "us-west-2"
}

variable "environment" {
    description = "Environment for service"
    default     = "STAGE"
}

variable "orchestration" {
    description = "Type of orchestration"
    default     = "Terraform"
}

variable "createdby" {
    description = "Created by"
    default     = "Vitaliy Natarov"
}

#-----------------------------------------------------------
# aws msk cluster
#-----------------------------------------------------------
variable "enable_msk_cluster_default" {
    description = "Enable AWS MSK usage"
    default     = "false"
}

variable "cluster_name" {
    description = "(Required) Name of the MSK cluster."
    default     = ""
}

variable "kafka_version" {
    description = "(Required) Specify the desired Kafka software version."
    default     = "2.1.0"
}

variable "number_of_broker_nodes" {
    description = "(Required) The desired total number of broker nodes in the kafka cluster. It must be a multiple of the number of specified client subnets."
    default     = "3"
}

variable "broker_node_group_info_instance_type" {
    description = "(Required) Specify the instance type to use for the kafka brokers. e.g. kafka.m5.large."
    default     = "kafka.m5.large"
}

variable "broker_node_group_info_ebs_volume_size" {
    description = "(Required) The size in GiB of the EBS volume for the data drive on each broker node."
    default     = "100"
}

variable "broker_node_group_info_security_groups" {
    description = "(Required) A list of the security groups to associate with the elastic network interfaces to control who can communicate with the cluster."
    type        = "list"
    default     = []
}

variable "broker_node_group_info_az_distribution" {
    description = "(Optional) The distribution of broker nodes across availability zones (documentation). Currently the only valid value is DEFAULT."
    default     = "DEFAULT"
}

variable "broker_node_group_info_client_subnets" {
    description = "(Required) A list of subnets to connect to in client VPC"
    type        = "list"
    default     = []
}

variable "encryption_info_encryption_at_rest_kms_key_arn" {
    description = "(Optional) You may specify a KMS key short ID or ARN (it will always output an ARN) to use for encrypting your data at rest. If no key is specified, an AWS managed KMS ('aws/msk' managed service) key will be used for encrypting the data at rest."
    default     = ""
}

#-----------------------------------------------------------
# AWS msk cluster with encryption
#-----------------------------------------------------------
variable "enable_msk_cluster_encryption" {
    description = "Enable AWS MSK with encryption usage"
    default     = "false"
}

variable "encryption_info_encryption_in_transit" {
    description = "(Optional) Configuration block to specify encryption in transit. See below."
    default     = ""
}

variable "client_authenication_certificate_authority_arns" {
    description = "(Optional) List of ACM Certificate Authority Amazon Resource Names (ARNs)."
    type        = "list"
    default     = []
}

#-----------------------------------------------------------
# AWS msk cluster with client authentication 
#-----------------------------------------------------------
variable "enable_msk_cluster_client_authentication" {
    description = "Enable AWS MSK with client_authentication usage"
    default     = "false"
}

variable "client_authentication_tls" {
    description = "(Optional) Configuration block for specifying TLS client authentication. See below."
    default     = ""
}

variable "client_authentication_certificate_authority_arns" {
    description = "(Optional) List of ACM Certificate Authority Amazon Resource Names (ARNs)."
    default     = ""
}

#-----------------------------------------------------------
# AWS msk cluster with configuration info
#-----------------------------------------------------------
variable "enable_msk_cluster_configuration_info" {
    description = "Enable AWS MSK with configuration_info usage"
    default     = "false"
}

variable "configuration_info_arn" {
    description = "(Required) Amazon Resource Name (ARN) of the MSK Configuration to use in the cluster."
    default     = ""
}

variable "configuration_info_revision" {
    description = "(Required) Revision of the MSK Configuration to use in the cluster."
    default     = ""
}

#-----------------------------------------------------------
# AWS msk cluster with encryption and client authentication
#-----------------------------------------------------------
variable "msk_cluster_encryption_and_authentication" {
    description = "Enable AWS MSK with encryption and client authentication usage"
    default     = "false"
}

#-----------------------------------------------------------
# AWS msk cluster with encryption and configuration info
#-----------------------------------------------------------
variable "enable_msk_cluster_encryption_and_configuration_info" {
    description = "Enable AWS MSK with encryption and configuration info usage"
    default     = "false"
}

#-----------------------------------------------------------
# AWS msk cluster with client authentication and configuration info
#-----------------------------------------------------------
variable "enable_msk_cluster_client_authentication_and_configuration_info" {
    description = "Enable AWS MSK with client authentication and configuration info usage"
    default     = "false"
}

#-----------------------------------------------------------
# AWS msk cluster with all functions
#-----------------------------------------------------------
variable "enable_msk_cluster_all" {
    description = "Enable AWS MSK with all functions usage"
    default     = "false"
}
