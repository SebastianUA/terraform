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

#-----------------------------------------------------------
# IAM service linked role
#-----------------------------------------------------------
variable "enable_iam_service_linked_role" {
  description   = "Enable IAM service linked role"
  default       = false
}

variable "iam_service_linked_role_aws_service_name" {
  description   = "(Required, Forces new resource) The AWS service to which this role is attached. You use a string similar to a URL but without the http:// in front. For example: elasticbeanstalk.amazonaws.com. To find the full list of services that support service-linked roles, check the docs."
  default       = ""
}

variable "iam_service_linked_role_custom_suffix" {
  description   = "(Optional, forces new resource) Additional string appended to the role name. Not all AWS services support custom suffixes."
  default       = null
}

variable "iam_service_linked_role_description" {
  description   = "(Optional) The description of the role."
  default       = null
}
