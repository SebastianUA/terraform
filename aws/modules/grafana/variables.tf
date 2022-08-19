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

variable "ami" {
  description = "Default AMIs by region"
  default = {
    us-east-1 = "ami-46c1b650"
    us-west-2 = "ami-50d1d929"
    eu-west-1 = "ami-6e28b517"
  }
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
