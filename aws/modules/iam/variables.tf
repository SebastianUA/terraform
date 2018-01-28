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
    default     = "PROD"
}
variable "aws_iam_role-principals" {
  type        = "list"
  description = "List of allowed actions."
}
variable "aws_iam_policy-resources" {
  type        = "list"
  description = "List of allowed actions."
  default     = ["*"]
}
variable "aws_iam_policy-actions" {
  type        = "list"
  description = "List of allowed actions."	
  default     = ["*"]
 
}


