#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST-ECR"
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

variable "repository" { 
    description = "(Required) Name of the repository to apply the policy."
    default     = ""
}

variable "policy_json_file" {
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

variable "lifecycle_policy_json_file" {
    description = "Json file with lifecycle policy"
    default     = ""
}
