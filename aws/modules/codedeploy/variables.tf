#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources as prefix"
  default     = "TEST"
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

#---------------------------------------------------
# AWS codedeploy app
#---------------------------------------------------
variable "enable_codedeploy_app" {
  description = "Enable codedeploy app usage"
  default     = false
}

variable "codedeploy_app_name" {
  description = "The name of the application."
  default     = ""
}

variable "codedeploy_app_compute_platform" {
  description = "(Optional) The compute platform can either be ECS, Lambda, or Server. Default is Server."
  default     = "Server"
}


#---------------------------------------------------
# AWS codedeploy deployment config
#---------------------------------------------------
variable "enable_codedeploy_deployment_config" {
  description = "Enable codedeploy deployment config canary usage"
  default     = false
}

variable "codedeploy_deployment_config_stack" {
  description = "Set properties for codedeploy deployment config"
  default     = []
}

#---------------------------------------------------
# AWS codedeploy deployment group
#---------------------------------------------------
variable "enable_codedeploy_deployment_group" {
  description = "Enable codedeploy deployment group usage"
  default     = false
}

variable "codedeploy_deployment_group_stack" {
  description = "Set properties for codedeploy deployment group"
  default     = []
}
