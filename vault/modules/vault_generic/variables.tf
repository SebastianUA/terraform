#-----------------------------------------------------------
# Global
#-----------------------------------------------------------

#---------------------------------------------------
# Vault generic secret
#---------------------------------------------------
variable "enable_generic_secret" {
  description = "Enable generic_secret for Vault usage"
  default     = false
}

variable "generic_secret_path" {
  description = "(Required) The full logical path at which to write the given data. To write data into the 'generic' secret backend mounted in Vault by default, this should be prefixed with secret/. Writing to other backends with this resource is possible; consult each backend's documentation to see which endpoints support the PUT and DELETE methods."
  default     = null
}

variable "generic_secret_data_json" {
  description = "(Required) String containing a JSON-encoded object that will be written as the secret data at the given path."
  default     = null
}

// variable "generic_secret_allow_read" {
//   description = "(Optional, Deprecated) True/false. Set this to true if your vault authentication is able to read the data, this allows the resource to be compared and updated. Defaults to false."
//   default     = false
// }

variable "generic_secret_disable_read" {
  description = "(Optional) True/false. Set this to true if your vault authentication is not able to read the data. Setting this to true will break drift detection. Defaults to false."
  default     = false
}

#---------------------------------------------------
# Vault generic endpoint
#---------------------------------------------------
variable "enable_generic_endpoint" {
  description = "Enable generic_endpoint for Vault usage"
  default     = false
}

variable "generic_endpoint_path" {
  description = "(Required) The full logical path at which to write the given data. Consult each backend's documentation to see which endpoints support the PUT methods and to determine whether they also support DELETE and GET."
  default     = null
}

variable "generic_endpoint_data_json" {
  description = "(Required) String containing a JSON-encoded object that will be written to the given path as the secret data."
  default     = null
}

variable "generic_endpoint_ignore_absent_fields" {
  description = "(Optional) True/false. If set to true, ignore any fields present when the endpoint is read but that were not in data_json. Also, if a field that was written is not returned when the endpoint is read, treat that field as being up to date. You should set this to true when writing to endpoint that, when read, returns a different set of fields from the ones you wrote, as is common with many configuration endpoints. Defaults to false."
  default     = false
}

variable "generic_endpoint_disable_read" {
  description = "(Optional) True/false. Set this to true if your vault authentication is not able to read the data or if the endpoint does not support the GET method. Setting this to true will break drift detection. You should set this to true for endpoints that are write-only. Defaults to false."
  default     = false
}

variable "generic_endpoint_disable_delete" {
  description = "(Optional) True/false. Set this to true if your vault authentication is not able to delete the data or if the endpoint does not support the DELETE method. Defaults to false."
  default     = false
}

variable "generic_endpoint_write_fields" {
  description = "(Optional). A list of fields that should be returned in write_data_json and write_data. If omitted, data returned by the write operation is not available to the resource or included in state. This helps to avoid accidental storage of sensitive values in state. Some endpoints, such as many dynamic secrets endpoints, return data from writing to an endpoint rather than reading it. You should use write_fields if you need information returned in this way."
  default     = null
}