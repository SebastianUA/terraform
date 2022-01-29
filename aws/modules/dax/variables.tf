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
# AWS dax cluster
#---------------------------------------------------
variable "enable_dax_cluster" {
  description = "Enable dax cluster usage"
  default     = false
}

variable "dax_cluster_name" {
  description = "Group identifier. DAX converts this name to lowercase"
  default     = ""
}

variable "dax_cluster_iam_role_arn" {
  description = "(Required) A valid Amazon Resource Name (ARN) that identifies an IAM role. At runtime, DAX will assume this role and use the role's permissions to access DynamoDB on your behalf"
  default     = null
}

variable "dax_cluster_node_type" {
  description = "(Required) The compute and memory capacity of the nodes. See Nodes for supported node types"
  default     = null
}

variable "dax_cluster_replication_factor" {
  description = "(Required) The number of nodes in the DAX cluster. A replication factor of 1 will create a single-node cluster, without any read replicas"
  default     = 1
}

variable "dax_cluster_availability_zones" {
  description = "(Optional) List of Availability Zones in which the nodes will be created"
  default     = null
}

variable "dax_cluster_description" {
  description = "(Optional) Description for the cluster"
  default     = null
}

variable "dax_cluster_notification_topic_arn" {
  description = "(Optional) An Amazon Resource Name (ARN) of an SNS topic to send DAX notifications to. Example: arn:aws:sns:us-east-1:012345678999:my_sns_topic"
  default     = null
}

variable "dax_cluster_parameter_group_name" {
  description = "(Optional) Name of the parameter group to associate with this DAX cluster"
  default     = null
}

variable "dax_cluster_maintenance_window" {
  description = "(Optional) Specifies the weekly time range for when maintenance on the cluster is performed. The format is ddd:hh24:mi-ddd:hh24:mi (24H Clock UTC). The minimum maintenance window is a 60 minute period. Example: sun:05:00-sun:09:00"
  default     = null
}

variable "dax_cluster_security_group_ids" {
  description = "(Optional) One or more VPC security groups associated with the cluster"
  default     = null
}

variable "dax_cluster_subnet_group_name" {
  description = "(Optional) Name of the subnet group to be used for the cluster"
  default     = null
}

variable "dax_cluster_server_side_encryption" {
  description = "(Optional) Encrypt at rest options"
  default     = []
}

variable "dax_cluster_timeouts" {
  description = "aws_dax_cluster provides Timeouts and they can be set."
  default     = {}
}

#---------------------------------------------------
# AWS dax parameter group
#---------------------------------------------------
variable "enable_dax_parameter_group" {
  description = "Enable dax parameter group usage"
  default     = false
}

variable "dax_parameter_group_name" {
  description = "The name of the parameter group."
  default     = ""
}

variable "dax_parameter_group_description" {
  description = "(Optional, ForceNew) A description of the parameter group."
  default     = ""
}

variable "dax_parameter_group_parameters" {
  description = "(Optional) The parameters of the parameter group."
  default     = []
}

#---------------------------------------------------
# AWS dax subnet group
#---------------------------------------------------
variable "enable_dax_subnet_group" {
  description = "Enable dax subnet group usage"
  default     = false
}

variable "dax_subnet_group_name" {
  description = "The name of the subnet group."
  default     = ""
}

variable "dax_subnet_group_subnet_ids" {
  description = "(Required) A list of VPC subnet IDs for the subnet group."
  default     = []
}

variable "dax_subnet_group_description" {
  description = "(Optional) A description of the subnet group."
  default     = null
}
