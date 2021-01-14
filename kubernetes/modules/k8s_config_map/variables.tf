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
# Kubernetes config_map
#---------------------------------------------------
variable "enable_config_map" {
  description = "Enable cm for kubernetes usage"
  default     = false
}

variable "config_map_name" {
  description = "(Optional) Name of the namespace, must be unique. Cannot be updated. For more info see Kubernetes reference"
  default     = ""
}

variable "config_map_generate_name" {
  description = "(Optional) Prefix, used by the server, to generate a unique name ONLY IF the name field has not been provided. This value will also be combined with a unique suffix. Read more about name idempotency."
  default     = null
}

variable "config_map_annotations" {
  description = "(Optional) An unstructured key value map stored with the namespace that may be used to store arbitrary metadata."
  default     = {}
}

variable "config_map_labels" {
  description = "(Optional) Map of string keys and values that can be used to organize and categorize (scope and select) namespaces. May match selectors of replication controllers and services."
  default     = {}
}

variable "config_map_namespace" {
  description = "(Optional) Namespace defines the space within which name of the config map must be unique."
  default     = null
}

variable "data" {
  description = "(Optional) Data contains the configuration data. Each key must consist of alphanumeric characters, '-', '_' or '.'. Values with non-UTF-8 byte sequences must use the BinaryData field. The keys stored in Data must not overlap with the keys in the BinaryData field, this is enforced during validation process."
  default     = null
}

variable "binary_data" {
  description = "(Optional) BinaryData contains the binary data. Each key must consist of alphanumeric characters, '-', '_' or '.'. BinaryData can contain byte sequences that are not in the UTF-8 range. The keys stored in BinaryData must not overlap with the ones in the Data field, this is enforced during validation process. Using this field will require 1.10+ apiserver and kubelet. This field only accepts base64-encoded payloads that will be decoded/received before being sent/received to the apiserver."
  default     = null
}