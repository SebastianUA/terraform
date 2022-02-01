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
# Kubernetes namespace
#---------------------------------------------------
variable "enable_namespace" {
  description = "Enable ns for kubernetes usage"
  default     = false
}

variable "namespace_name" {
  description = "(Optional) Name of the namespace, must be unique. Cannot be updated. For more info see Kubernetes reference"
  default     = ""
}

variable "namespace_generate_name" {
  description = "(Optional) Prefix, used by the server, to generate a unique name ONLY IF the name field has not been provided. This value will also be combined with a unique suffix. Read more about name idempotency."
  default     = null
}

variable "namespace_annotations" {
  description = "(Optional) An unstructured key value map stored with the namespace that may be used to store arbitrary metadata."
  default     = {}
}

variable "namespace_labels" {
  description = "(Optional) Map of string keys and values that can be used to organize and categorize (scope and select) namespaces. May match selectors of replication controllers and services."
  default     = {}
}

variable "timeouts" {
  description = "kubernetes_namespace provides the following Timeouts configuration"
  default     = {}
}
