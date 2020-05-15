#---------------------------------------------------
# AWS macie member account association
#---------------------------------------------------
variable "enable_macie_member_account_association" {
  description   = "Enable macie member account association usage"
  default       = false
}

variable "macie_member_account_association_member_account_id" {
  description   = "(Required) The ID of the AWS account that you want to associate with Amazon Macie as a member account."
  default       = null
}

#---------------------------------------------------
# AWS macie s3 bucket association
#---------------------------------------------------
variable "enable_macie_s3_bucket_association" {
  description   = "Enable macie s3 bucket association usage"
  default       = false
}

variable "macie_s3_bucket_association_bucket_name" {
  description   = "(Required) The name of the S3 bucket that you want to associate with Amazon Macie."
  default       = null
}

variable "macie_s3_bucket_association_member_account_id" {
  description   = "(Optional) The ID of the Amazon Macie member account whose S3 resources you want to associate with Macie. If member_account_id isn't specified, the action associates specified S3 resources with Macie for the current master account."
  default       = null
}

variable "macie_s3_bucket_association_prefix" {
  description   = "(Optional) Object key prefix identifying one or more S3 objects to which the association applies."
  default       = null
}

variable "macie_s3_bucket_association_classification_type" {
  description   = "(Optional) The configuration of how Amazon Macie classifies the S3 objects."
  default       = []
}
