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
# AWS cloud9 environment ec2
#---------------------------------------------------
variable "enable_cloud9_environment_ec2" {
  description = "Enable cloud9 environment ec2 usage"
  default     = false
}

variable "cloud9_environment_ec2_name" {
  description = "The name of the environment."
  default     = ""
}

variable "cloud9_environment_ec2_instance_type" {
  description = "(Required) The type of instance to connect to the environment, e.g. t2.micro."
  default     = "t2.micro"
}

variable "cloud9_environment_ec2_automatic_stop_time_minutes" {
  description = "(Optional) The number of minutes until the running instance is shut down after the environment has last been used."
  default     = null
}

variable "cloud9_environment_ec2_description" {
  description = "(Optional) The description of the environment."
  default     = null
}

variable "cloud9_environment_ec2_owner_arn" {
  description = "(Optional) The ARN of the environment owner. This can be ARN of any AWS IAM principal. Defaults to the environment's creator."
  default     = null
}

variable "cloud9_environment_ec2_subnet_id" {
  description = "(Optional) The ID of the subnet in Amazon VPC that AWS Cloud9 will use to communicate with the Amazon EC2 instance."
  default     = null
}
