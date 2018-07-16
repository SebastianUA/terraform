variable "name" {
    description = "(Required) The name of the repository that will be created."
    default     = "TEST"
}

variable "project" {
  description = "(Optional) The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
  default     = ""    
} 

variable "environment" {
    description = "Environment for service"
    default     = "STAGE"
}
