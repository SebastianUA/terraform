variable "glue_connection_user_name" {
  type        = string
  description = "Glue connection user name"
  default     = "exampleglueusername"
}

variable "example_tags" {
  type        = map(any)
  description = "Tag values for this example"
  default = {
    "cost-center" = "00-00000.000.01"
    "Project"     = "My Test Glue Project"
  }
}