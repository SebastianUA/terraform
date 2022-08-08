#---------------------------------------------------
# Time offset
#---------------------------------------------------
variable "enable_offset" {
  description = "Enable offset usage"
  default     = false
}

variable "offset_offset_years" {
  description = "(Optional) Number of years to offset the base timestamp. Conflicts with other offset_ arguments."
  default     = null
}

variable "offset_offset_months" {
  description = "(Optional) Number of months to offset the base timestamp. Conflicts with other offset_ arguments."
  default     = null
}

variable "offset_offset_days" {
  description = "(Optional) Number of days to offset the base timestamp. Conflicts with other offset_ arguments."
  default     = null
}

variable "offset_offset_hours" {
  description = "(Optional) Number of hours to offset the base timestamp. Conflicts with other offset_ arguments."
  default     = null
}

variable "offset_offset_minutes" {
  description = "(Optional) Number of minutes to offset the base timestamp. Conflicts with other offset_ arguments."
  default     = null
}

variable "offset_offset_seconds" {
  description = "(Optional) Number of seconds to offset the base timestamp. Conflicts with other offset_ arguments."
  default     = null
}

variable "offset_base_rfc3339" {
  description = "(Optional) Configure the base timestamp with an UTC RFC3339 time string (YYYY-MM-DDTHH:MM:SSZ). Defaults to the current time."
  default     = null
}

variable "offset_triggers" {
  description = "(Optional) Arbitrary map of values that, when changed, will trigger a new base timestamp value to be saved. See the main provider documentation for more information."
  default     = null
}

#---------------------------------------------------
# Time rotating
#---------------------------------------------------
variable "enable_rotating" {
  description = "Enable rotating usage"
  default     = false
}

variable "rotating_rotation_years" {
  description = "(Optional) Number of years to add to the base timestamp to configure the rotation timestamp. When the current time has passed the rotation timestamp, the resource will trigger recreation. Conflicts with other rotation_ arguments."
  default     = null
}

variable "rotating_rotation_months" {
  description = "(Optional) Number of months to add to the base timestamp to configure the rotation timestamp. When the current time has passed the rotation timestamp, the resource will trigger recreation. Conflicts with other rotation_ arguments."
  default     = null
}

variable "rotating_rotation_days" {
  description = "(Optional) Number of days to add to the base timestamp to configure the rotation timestamp. When the current time has passed the rotation timestamp, the resource will trigger recreation. Conflicts with other rotation_ arguments."
  default     = null
}

variable "rotating_rotation_hours" {
  description = "(Optional) Number of hours to add to the base timestamp to configure the rotation timestamp. When the current time has passed the rotation timestamp, the resource will trigger recreation. Conflicts with other rotation_ arguments."
  default     = null
}

variable "rotating_rotation_minutes" {
  description = "(Optional) Number of minutes to add to the base timestamp to configure the rotation timestamp. When the current time has passed the rotation timestamp, the resource will trigger recreation. Conflicts with other rotation_ arguments."
  default     = null
}

variable "rotating_rfc3339" {
  description = "(Optional) Configure the base timestamp with an UTC RFC3339 time string (YYYY-MM-DDTHH:MM:SSZ). Defaults to the current time."
  default     = null
}

variable "rotating_rotation_rfc3339" {
  description = "(Optional) Configure the rotation timestamp with an UTC RFC3339 time string (YYYY-MM-DDTHH:MM:SSZ). When the current time has passed the rotation timestamp, the resource will trigger recreation. Conflicts with other rotation_ arguments."
  default     = null
}

variable "rotating_triggers" {
  description = "(Optional) Arbitrary map of values that, when changed, will trigger a new base timestamp value to be saved. These conditions recreate the resource in addition to other rotation arguments. See the main provider documentation for more information."
  default     = null
}

#---------------------------------------------------
# Time sleep
#---------------------------------------------------
variable "enable_sleep" {
  description = "Enable sleep usage"
  default     = false
}

variable "sleep_create_duration" {
  description = "(Optional) Time duration to delay resource creation. For example, 30s for 30 seconds or 5m for 5 minutes. Updating this value by itself will not trigger a delay."
  default     = null
}

variable "sleep_destroy_duration" {
  description = "(Optional) Time duration to delay resource destroy. For example, 30s for 30 seconds or 5m for 5 minutes. Updating this value by itself will not trigger a delay. This value or any updates to it must be successfully applied into the Terraform state before destroying this resource to take effect."
  default     = null
}

variable "sleep_triggers" {
  description = "(Optional) Arbitrary map of values that, when changed, will run any creation or destroy delays again. See the main provider documentation for more information."
  default     = null
}

#---------------------------------------------------
# Time static
#---------------------------------------------------
variable "enable_static" {
  description = "Enable static usage"
  default     = false
}

variable "static_rfc3339" {
  description = "(Optional) Configure the base timestamp with an UTC RFC3339 time string (YYYY-MM-DDTHH:MM:SSZ). Defaults to the current time."
  default     = null
}

variable "static_triggers" {
  description = "(Optional) Arbitrary map of values that, when changed, will trigger a new base timestamp value to be saved. See the main provider documentation for more information."
  default     = null
}