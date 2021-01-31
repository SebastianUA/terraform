#---------------------------------------------------
# Global
#---------------------------------------------------
variable "name" {
  description = "Set name if some variables will be unset for resources"
  default     = "heroku"
}

variable "environment" {
  description = "Set Env name"
  default     = "dev"
}

#---------------------------------------------------
# Heroku app
#---------------------------------------------------
variable "enable_app" {
  description = "Enable Heroku app usage"
  default     = null
}

variable "app_name" {
  description = "(Required) The name of the application. In Heroku, this is also the unique ID, so it must be unique and have a minimum of 3 characters."
  default     = null
}

variable "app_region" {
  description = "(Required) The region that the app should be deployed in."
  default     = null
}

variable "app_stack" {
  description = "(Optional) The application stack is what platform to run the application in."
  default     = null
}

variable "app_buildpacks" {
  description = "(Optional) Buildpack names or URLs for the application. Buildpacks configured externally won't be altered if this is not present."
  default     = null
}

variable "app_config_vars" {
  description = "(Optional) Configuration variables for the application. The config variables in this map are not the final set of configuration variables, but rather variables you want present. That is, other configuration variables set externally won't be removed by Terraform if they aren't present in this list."
  default     = null
}

variable "app_sensitive_config_vars" {
  description = "(Optional) This argument is the same as config_vars. The main difference between the two is when sensitive_config_vars outputs are displayed on-screen following a terraform apply or terraform refresh, they are redacted, with <sensitive> displayed in place of their value. It is recommended to put private keys, passwords, etc in this argument."
  default     = null
}

variable "app_space" {
  description = "(Optional) The name of a private space to create the app in."
  default     = null
}

variable "app_internal_routing" {
  description = "(Optional) If true, the application will be routable only internally in a private space. This option is only available for apps that also specify space."
  default     = null
}

variable "app_organization" {
  description = "(Optional) A block that can be specified once to define Heroku Team settings for this app. "
  default     = []
}

variable "app_acm" {
  description = "(Optional) The flag representing Automated Certificate Management for the app."
  default     = null
}

#---------------------------------------------------
# Heroku app config association
#---------------------------------------------------
variable "enable_app_config_association" {
  description = "Enable Heroku app config association usage"
  default     = false
}

variable "app_config_association_app_id" {
  description = "A Heroku app's UUID. Can also be the name of the Heroku app but UUID is preferred as it is idempotent."
  default     = ""
}

variable "app_config_association_vars" {
  description = "Map of config vars that can be output in plaintext."
  default     = null
}

variable "app_config_association_sensitive_vars" {
  description = "This is the same as vars. The main difference between the two attributes is sensitive_vars outputs are redacted on-screen and replaced by a <sensitive> placeholder, following a terraform plan or apply. It is recommended to put private keys, passwords, etc in this argument."
  default     = null
}

#---------------------------------------------------
# Heroku app release
#---------------------------------------------------
variable "enable_app_release" {
  description = "Enable Heroku app release usage"
  default     = false
}

variable "app_release_app" {
  description = "The name of the application"
  default     = ""
}

variable "app_release_slug_id" {
  description = "unique identifier of slug"
  default     = null
}

variable "app_release_description" {
  description = "description of changes in this release"
  default     = null
}

#---------------------------------------------------
# Heroku app feature
#---------------------------------------------------
variable "enable_app_feature" {
  description = "Enable Heroku app feature usage"
  default     = false
}

variable "app_feature_app" {
  description = "(Required) The Heroku app to link to."
  default     = ""
}

variable "app_feature_name" {
  description = "(Required) The name of the App Feature to manage."
  default     = ""
}

variable "app_feature_enabled" {
  description = "(Optional) Whether to enable or disable the App Feature. The default value is true."
  default     = null
}

#---------------------------------------------------
# Heroku app webhook
#---------------------------------------------------
variable "enable_app_webhook" {
  description = "Enable Heroku app webhook usage"
  default     = false
}

variable "app_webhook_app_id" {
  description = "(Required) The Heroku app to add to."
  default     = ""
}

variable "app_webhook_level" {
  description = "(Required) The webhook level (either notify or sync)"
  default     = null
}

variable "app_webhook_url" {
  description = "(Required) Optional plan configuration."
  default     = null
}

variable "app_webhook_include" {
  description = "(Required) List of events to deliver to the webhook."
  default     = null
}

variable "app_webhook_secret" {
  description = "(Optional) Value used to sign webhook payloads. Once set, this value cannot be fetched from the Heroku API, but it can be updated."
  default     = null
}

variable "app_webhook_authorization" {
  description = "(Optional) Values used in Authorization header. Once set, this value cannot be fetched from the Heroku API, but it can be updated."
  default     = null
}
