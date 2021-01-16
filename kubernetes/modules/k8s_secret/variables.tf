#-----------------------------------------------------------
# Global
#-----------------------------------------------------------
variable "name" {
  description = "The name for helm release resources"
  default     = "test"
}

variable "environment" {
  description = "Environment for service"
  default     = "STAGE"
}

#---------------------------------------------------
# Kubernetes secret
#---------------------------------------------------
variable "enable_secret" {
  description = "Enable ns for kubernetes usage"
  default     = false
}

variable "secret_name" {
  description = "(Optional) Name of the secret, must be unique. Cannot be updated. For more info see Kubernetes reference"
  default     = ""
}

variable "secret_generate_name" {
  description = "(Optional) Prefix, used by the server, to generate a unique name ONLY IF the name field has not been provided. This value will also be combined with a unique suffix. For more info see Kubernetes reference"
  default     = null
}

variable "secret_annotations" {
  description = "(Optional) An unstructured key value map stored with the secret that may be used to store arbitrary metadata."
  default     = {}
}

variable "secret_labels" {
  description = "(Optional) Map of string keys and values that can be used to organize and categorize (scope and select) secrets. May match selectors of replication controllers and services."
  default     = {}
}

variable "secret_namespace" {
  description = "(Optional) Namespace defines the space within which name of the secret must be unique."
  default     = null
}

variable "secret_data" {
  description = "(Optional) A map of the secret data."
  default     = null
}

variable "secret_type" {
  description = "(Optional) The secret type. Defaults to Opaque. For more info see Kubernetes reference"
  default     = "Opaque"
}
