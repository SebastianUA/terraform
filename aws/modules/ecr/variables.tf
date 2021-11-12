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
  description = "A list of tag blocks. Each element should have keys named key, value, and propagate_at_launch."
  type        = map(string)
  default     = {}
}

#-----------------------------------------------------------
# ECR repo
#-----------------------------------------------------------
variable "enable_ecr_repository" {
  description = "Enable ecr repo creating"
  default     = false
}

variable "ecr_repository_name" {
  description = "Name of the repository."
  default     = ""
}

variable "timeouts_delete" {
  description = "(Default 20 minutes) How long to wait for a repository to be deleted."
  default     = "20m"
}

#-----------------------------------------------------------
# ECR repo policy
#-----------------------------------------------------------
variable "enable_ecr_repository_policy" {
  description = "Enable ecr repo policy usage"
  default     = false
}

variable "ecr_repository_policy_repository" {
  description = "(Required) Name of the repository to apply the policy."
  default     = ""
}

variable "ecr_repository_policy" {
  description = "Json file with policy"
  default     = ""
}

#-----------------------------------------------------------
# ECR lifecycle policy
#-----------------------------------------------------------
variable "enable_ecr_lifecycle_policy" {
  description = "Enable ecr lifecycle policy"
  default     = false
}

variable "ecr_lifecycle_policy_repository" {
  description = "Set repository for lifecycle policy resource"
  default     = ""
}

variable "ecr_lifecycle_policy" {
  description = "Json file with lifecycle policy"
  default     = ""
}
