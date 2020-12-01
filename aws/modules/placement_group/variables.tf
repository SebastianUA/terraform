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
  description = "A list of tag blocks. Each element should have keys named key, value, etc."
  type        = map(string)
  default     = {}
}

#---------------------------------------------------
# placement group
#---------------------------------------------------
variable "enable_placement_group" {
  description = "Enable placement group"
  default     = false
}

variable "placement_group_name" {
  description = "The name of the placement group."
  default     = ""
}

variable "placement_group_strategy" {
  description = "(Required) The placement strategy. Can be 'cluster', 'partition' or 'spread'."
  default     = "cluster"
}
