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

#---------------------------------------------------
# AWS simpledb domain
#---------------------------------------------------
variable "enable_simpledb_domain" {
  description = "Enable simpledb domain usage"
  default     = false
}

variable "simpledb_domain_name" {
  description = "The name of the SimpleDB domain"
  default     = ""
}
