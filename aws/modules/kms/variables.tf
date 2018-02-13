#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST-KMS"
}

variable "region" {
  description = "The region where to deploy this code (e.g. us-east-1)."
  default     = "us-east-1"
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

variable "deletion_window_in_days" {
    description = "Duration in days after which the key is deleted after destruction of the resource, must be between 7 and 30 days. Defaults to 30 days."
    default     = "10"
}

variable "description" {
    description = "The description of the key as viewed in AWS console."
    default     = "This key is used to encrypt <___> AWS service"
}

variable "key_usage" {
    description = "Specifies the intended use of the key. Defaults to ENCRYPT_DECRYPT, and only symmetric encryption and decryption are supported"
    default     = ""
}

variable "is_enabled" {
    description = "Specifies whether the key is enabled. Defaults to true."
    default     = "true"
}

variable "enable_key_rotation" {
    description = "Specifies whether key rotation is enabled. Defaults to false."
    default     = "false"
}

variable "admin_user" {
    description = "Admin user in IAM"
    default     = "root"
}

variable "aws_account_id" {
    description = "AWS account ID"
    default     = ""
}
