#-----------------------------------------------------------
# Global or/and default variables
#-----------------------------------------------------------
variable "name" {
  description = "Name to be used on all resources"
  default     = "TEST"
}

#-----------------------------------------------------------
# AWS key_pair
#-----------------------------------------------------------
variable "enable_key_pair" {
    description = "Enable aws key_pair"
    default     = false
}

variable "key_name" {
    description = "(Optional) The name for the key pair."
    default     = ""
}

variable "public_key" {
    description = "(Required) The public key material."
    default     = ""
}

variable "key_name_prefix" {
    description = "(Optional) Creates a unique name beginning with the specified prefix. Conflicts with key_name."
    default     = "key-"
}
