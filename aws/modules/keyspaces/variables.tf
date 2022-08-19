#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources"
  default     = "TEST"
}

variable "tags" {
  description = "A list of tag blocks. Each element should have keys"
  type        = map(string)
  default     = {}
}

#-----------------------------------------------------------
# AWS keyspaces
#-----------------------------------------------------------

