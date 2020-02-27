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

variable "tags" {
    description = "A list of tag blocks. Each element should have keys named key, value, and propagate_at_launch."
    type        = map(string)
    default     = {}
}

#-----------------------------------------------------------
# KMS
#-----------------------------------------------------------
variable "enable_kms_key" {
    description = "Allow to create kms_key"
    default     = false
}

variable "kms_key_name" {
  description   = "Name for KMS"
  default       = ""
}

variable "deletion_window_in_days" {
    description = "Duration in days after which the key is deleted after destruction of the resource, must be between 7 and 30 days. Defaults to 30 days."
    default     = 10
}

variable "description" {
    description = "The description of the key as viewed in AWS console."
    default     = "This key is used to encrypt <___> AWS service"
}

variable "key_usage" {
    description = "Specifies the intended use of the key. Defaults to ENCRYPT_DECRYPT, and only symmetric encryption and decryption are supported"
    default     = "ENCRYPT_DECRYPT"
}

variable "is_enabled" {
    description = "Specifies whether the key is enabled. Defaults to true."
    default     = true
}

variable "enable_key_rotation" {
    description = "Specifies whether key rotation is enabled. Defaults to false."
    default     = false
}

variable "policy" {
  description   = "Set policy"
  default       = ""
}


#-----------------------------------------------------------
# KMS alias
#-----------------------------------------------------------
variable "enable_kms_alias" {
    description = "Allow to create kms_alias"
    default     = false
}

variable "kms_alias_name" {
  description   = "(Optional) The display name of the alias. The name must start with the word 'alias' followed by a forward slash (alias/)"
  default       = null
}

variable "name_prefix" {
        description = "(Optional) Creates an unique alias beginning with the specified prefix. The name must start with the word 'alias' followed by a forward slash (alias/). Conflicts with name."
        default     = null
}

variable "target_key_id" {
        description = "(Required) Identifier for the key for which the alias is for, can be either an ARN or key_id."
        default     = ""
}
