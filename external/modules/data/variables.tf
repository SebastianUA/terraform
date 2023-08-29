#---------------------------------------------------
# Data external
#---------------------------------------------------
variable "external_program" {
  description = "(Required) A list of strings, whose first element is the program to run and whose subsequent elements are optional command line arguments to the program. Terraform does not execute the program through a shell, so it is not necessary to escape shell metacharacters nor add quotes around arguments containing spaces."
  default     = []
}

variable "external_query" {
  description = "(Optional) A map of string values to pass to the external program as the query arguments. If not supplied, the program will receive an empty object as its input."
  default     = {}
}

variable "external_working_dir" {
  description = "(Optional) Working directory of the program. If not supplied, the program will run in the current directory."
  default     = null
}
