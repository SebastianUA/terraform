#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "tags" {
  description = "A list of tag blocks. Each element should have keys named key, value, etc."
  type        = map(string)
  default     = {}
}
