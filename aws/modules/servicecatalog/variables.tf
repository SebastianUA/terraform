#---------------------------------------------------
# AWS servicecatalog portfolio
#---------------------------------------------------
variable "tags" {
  description = "A list of tag blocks. Each element should have keys named key, value, etc."
  type        = map(string)
  default     = {}
}

#---------------------------------------------------
# AWS servicecatalog portfolio
#---------------------------------------------------
variable "enable_servicecatalog_portfolio" {
  description = "Enable servicecatalog portfolio usage"
  default     = false
}

variable "servicecatalog_portfolio_name" {
  description = "The name of the portfolio."
  default     = ""
}

variable "servicecatalog_portfolio_description" {
  description = "(Required) Description of the portfolio"
  default     = ""
}

variable "servicecatalog_portfolio_provider_name" {
  description = "(Required) Name of the person or organization who owns the portfolio."
  default     = null
}
