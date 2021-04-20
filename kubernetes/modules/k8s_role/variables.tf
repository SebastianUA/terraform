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
# Kubernetes role
#---------------------------------------------------
variable "enable_role" {
  description = "Enable role for kubernetes usage"
  default     = false
}

variable "role_name" {
  description = "(Optional) Name of the cluster role binding, must be unique. Cannot be updated. For more info see Kubernetes reference"
  default     = ""
}

variable "role_generate_name" {
  description = "(Optional) Prefix, used by the server, to generate a unique name ONLY IF the name field has not been provided. This value will also be combined with a unique suffix. For more info see Kubernetes reference"
  default     = null
}

variable "role_annotations" {
  description = "(Optional) An unstructured key value map stored with the cluster role binding that may be used to store arbitrary metadata."
  default     = {}
}

variable "role_labels" {
  description = "(Optional) Map of string keys and values that can be used to organize and categorize (scope and select) the cluster role binding."
  default     = {}
}

variable "role_rules" {
  description = "(Optional) The PolicyRoles for this ClusterRole. For more info see Kubernetes reference"
  default     = []
}

variable "role_namespace" {
  description = "(Optional) Namespace defines the space within which name of the role must be unique."
  default     = null
}

#---------------------------------------------------
# Kubernetes role binding
#---------------------------------------------------
variable "enable_role_binding" {
  description = "Enable role_binding for kubernetes usage"
  default     = false
}

variable "role_binding_name" {
  description = "(Optional) Name of the cluster role binding, must be unique. Cannot be updated. For more info see Kubernetes reference"
  default     = ""
}

// variable "role_binding_generate_name" {
//   description = "(Optional) Prefix, used by the server, to generate a unique name ONLY IF the name field has not been provided. This value will also be combined with a unique suffix. For more info see Kubernetes reference"
//   default     = null
// }

variable "role_binding_namespace" {
  description = "(Optional) Namespace defines the space within which name of the role binding must be unique."
  default     = null
}

variable "role_binding_annotations" {
  description = "(Optional) An unstructured key value map stored with the cluster role binding that may be used to store arbitrary metadata."
  default     = {}
}

variable "role_binding_labels" {
  description = "(Optional) Map of string keys and values that can be used to organize and categorize (scope and select) the cluster role binding."
  default     = {}
}

variable "role_binding_role_refs" {
  description = "(Required) The ClusterRole to bind Subjects to. For more info see Kubernetes reference"
  default     = []
}

variable "role_binding_subjects" {
  description = "(Required) The Users, Groups, or ServiceAccounts to grant permissions to. For more info see Kubernetes reference"
  default     = []
}
