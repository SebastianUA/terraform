#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST-S3"
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

variable "bucket_prefix" {
    description = "Creates a unique bucket name beginning with the specified prefix. Conflicts with bucket."
    default     = ""
}

variable "s3_acl" {
    description = "The canned ACL to apply. Defaults to 'private'."
    default     = "private"
}

variable "enable_versioning" {
    description = "A state of versioning"
    default     = false
}

variable "force_destroy" {
    description = "A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
    default     = false
}

variable "website" {
    description = "List of website fields"
    type        = "list"
    default     = []
}

variable "routing_rules" {
    description = "Routing rules"
    type        = "list"
    default     = []
}

variable "cors_rule" {
    description = "Cors rules"
    type        = "list"
    default     = []
}

variable "logging" {
    description = "Add logging rules"
    type        = "list"
    default     = []
}

variable "enable_lifecycle_rule" {
    description = "Enable lifecycle rule"
    default     = true
}

variable "lifecycle_rule_prefix" {
    description = " Set prefix for lifecycle rule"
    default     = ""
}

variable "noncurrent_version_expiration_days" {
    description = "(Optional) Specifies when noncurrent object versions expire."
    default     = "90"
}

variable "noncurrent_version_transition_days" {
    description = "(Optional) Specifies when noncurrent object versions transitions"
    default     = "30"
}

variable "standard_transition_days" {
    description = "Number of days to persist in the standard storage tier before moving to the infrequent access tier"
    default     = "30"
}

variable "glacier_transition_days" {
    description = "Number of days after which to move the data to the glacier storage tier"
    default     = "60"
}

variable "expiration_days" {
    description = "Number of days after which to expunge the objects"
    default     = "90"
}
