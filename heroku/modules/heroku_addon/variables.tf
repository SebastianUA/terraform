#---------------------------------------------------
# Heroku addon
#---------------------------------------------------
variable "enable_addon" {
  description = "Enable Heroku addon usage"
  default     = false
}

variable "addon_name" {
  description = "(Optional) Globally unique name of the add-on."
  default     = null
}

variable "addon_app" {
  description = "(Required) The Heroku app to add to."
  default     = null
}

variable "addon_plan" {
  description = "(Required) The addon to add."
  default     = null
}

variable "addon_config" {
  description = "(Optional) Optional plan configuration."
  default     = null
}

#---------------------------------------------------
# Heroku addon attachment
#---------------------------------------------------
variable "enable_addon_attachment" {
  description = "Enable Heroku addon attachment usage"
  default     = false
}

variable "addon_attachment_name" {
  description = "(Optional) A friendly name for the Heroku Addon Attachment."
  default     = null
}

variable "addon_attachment_app_id" {
  description = "(Required) The ID of the Heroku App to attach to."
  default     = null
}

variable "addon_attachment_addon_id" {
  description = "(Required) The ID of the existing Heroku Addon to attach."
  default     = ""
}

variable "addon_attachment_namespace" {
  description = "(Optional) The namespace value for the Heroku Addon Attachment. This can be used to configure the behaviour of the attachment. See Heroku Platform API Reference"
  default     = null
}
