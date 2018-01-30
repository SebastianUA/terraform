#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST-AIM"
}

variable "region" {
  description = "The region where to deploy this code (e.g. us-east-1)."
  default     = "us-east-1"
}
#---------------------------------------------------------------
# Custom variables
#---------------------------------------------------------------
#variable "provider" {
#    type = "map"
#    default = {
#        access_key = "unknown"
#        secret_key = "unknown"
#        region     = "us-east-1"
#    }
#}
variable "environment" {
    description = "environment for service"
    default     = "STAGE"
}
variable "aws_iam_role-principals" {
  description = "List of allowed principals."
  type        = "list"  
}
variable "aws_iam_policy-resources" {
  description = "List of allowed resources."
  type        = "list"
  default     = ["*"]
}
variable "aws_iam_policy-actions" {
  description = "List of allowed actions."  
  type        = "list"
  default     = ["*"] 
}
variable "enable_crossaccount_role" {
    description = "Enabling cross account role"
    default     = "false"
}
variable "cross_acc_principal_arns" {
    description = "ARNs of accounts, groups, or users with the ability to assume this role."
    type        = "list"
    default     = ["222222222222","arn:aws:iam::333333333333:user/MyUser"]
}
variable "cross_acc_policy_arns" {
    description = "List of ARNs of policies to be associated with the created IAM role"
    type        = "list"
    default     = ["arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser", "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"]
}


