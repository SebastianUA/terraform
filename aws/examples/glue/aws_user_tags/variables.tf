variable "environment" {
  type        = string
  description = "Environment value"
  validation {
    condition     = can(regex("DEV|TEST|QA|PROD|STAGE", var.environment))
    error_message = "ERROR: environment must be of type: DEV, TEST, QA, PROD or STAGE."
  }
}

variable "custom_tags" {
  type        = map(string)
  description = "Custom AWS tags provided by the user"
  default     = {}
}