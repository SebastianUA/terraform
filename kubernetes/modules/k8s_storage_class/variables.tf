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
# Kubernetes storage_class
#---------------------------------------------------
variable "enable_storage_class" {
  description = "Enable ns for kubernetes usage"
  default     = false
}

variable "storage_class_name" {
  description = "(Optional) Name of the namespace, must be unique. Cannot be updated. For more info see Kubernetes reference"
  default     = ""
}

variable "storage_class_generate_name" {
  description = "(Optional) Prefix, used by the server, to generate a unique name ONLY IF the name field has not been provided. This value will also be combined with a unique suffix. Read more about name idempotency."
  default     = null
}

variable "storage_class_annotations" {
  description = "(Optional) An unstructured key value map stored with the namespace that may be used to store arbitrary metadata."
  default     = {}
}

variable "storage_class_labels" {
  description = "(Optional) Map of string keys and values that can be used to organize and categorize (scope and select) namespaces. May match selectors of replication controllers and services."
  default     = {}
}

variable "storage_class_storage_provisioner" {
  description = "(Required) Indicates the type of the provisioner"
  default     = []
}

variable "storage_class_reclaim_policy" {
  description = "(Optional) Indicates the reclaim policy to use. If no reclaimPolicy is specified when a StorageClass object is created, it will default to Delete."
  default     = "Delete"
}

variable "storage_class_parameters" {
  description = "(Optional) The parameters for the provisioner that should create volumes of this storage class. Read more about available parameters."
  default     = null
}

variable "storage_class_mount_options" {
  description = "(Optional) Persistent Volumes that are dynamically created by a storage class will have the mount options specified."
  default     = null
}

variable "storage_class_volume_binding_mode" {
  description = "(Optional) Indicates when volume binding and dynamic provisioning should occur."
  default     = null
}

variable "storage_class_allow_volume_expansion" {
  description = "(Optional) Indicates whether the storage class allow volume expand, default true."
  default     = true
}