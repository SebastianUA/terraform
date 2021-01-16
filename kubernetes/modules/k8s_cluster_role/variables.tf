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
# Kubernetes cluster role
#---------------------------------------------------
variable "enable_cluster_role" {
  description = "Enable cluster_role for kubernetes usage"
  default     = false
}

variable "cluster_role_name" {
  description = "(Optional) Name of the cluster role binding, must be unique. Cannot be updated. For more info see Kubernetes reference"
  default     = ""
}

// variable "cluster_role_generate_name" {
//   description = "(Optional) Prefix, used by the server, to generate a unique name ONLY IF the name field has not been provided. This value will also be combined with a unique suffix. For more info see Kubernetes reference"
//   default     = null
// }

variable "cluster_role_annotations" {
  description = "(Optional) An unstructured key value map stored with the cluster role binding that may be used to store arbitrary metadata."
  default     = {}
}

variable "cluster_role_labels" {
  description = "(Optional) Map of string keys and values that can be used to organize and categorize (scope and select) the cluster role binding."
  default     = {}
}

variable "cluster_role_rule" {
  description = "(Optional) The PolicyRoles for this ClusterRole. For more info see Kubernetes reference"
  default     = []
}

variable "cluster_role_aggregation_rule" {
  description = "(Optional) Describes how to build the Rules for this ClusterRole. If AggregationRule is set, then the Rules are controller managed and direct changes to Rules will be overwritten by the controller. . For more info see Kubernetes reference"
  default     = []
}

#---------------------------------------------------
# Kubernetes cluster role binding
#---------------------------------------------------
variable "enable_cluster_role_binding" {
  description = "Enable cluster_role_binding for kubernetes usage"
  default     = false
}

variable "cluster_role_binding_name" {
  description = "(Optional) Name of the cluster role binding, must be unique. Cannot be updated. For more info see Kubernetes reference"
  default     = ""
}

// variable "cluster_role_binding_generate_name" {
//   description = "(Optional) Prefix, used by the server, to generate a unique name ONLY IF the name field has not been provided. This value will also be combined with a unique suffix. For more info see Kubernetes reference"
//   default     = null
// }

variable "cluster_role_binding_annotations" {
  description = "(Optional) An unstructured key value map stored with the cluster role binding that may be used to store arbitrary metadata."
  default     = {}
}

variable "cluster_role_binding_labels" {
  description = "(Optional) Map of string keys and values that can be used to organize and categorize (scope and select) the cluster role binding."
  default     = {}
}

variable "cluster_role_binding_role_ref" {
  description = "(Required) The ClusterRole to bind Subjects to. For more info see Kubernetes reference"
  default     = []
}

variable "cluster_role_binding_subject" {
  description = "(Required) The Users, Groups, or ServiceAccounts to grant permissions to. For more info see Kubernetes reference"
  default     = []
}
