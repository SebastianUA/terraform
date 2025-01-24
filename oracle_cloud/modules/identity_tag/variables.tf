#-----------------------------------------------------------
# Global
#-----------------------------------------------------------
variable "name" {
  description = "The name for resources"
  default     = "test"
}

variable "environment" {
  description = "The environment for resources"
  default     = "dev"
}

variable "tags" {
  description = "Add additional tags"
  default     = {}
}

#-----------------------------------------------------------
# identity tag
#-----------------------------------------------------------
variable "enable_identity_tag" {
  description = "Enable identity tag usages"
  default     = false
}

variable "identity_tag_name" {
  description = "The name you assign to the tag during creation. This is the tag key definition. The name must be unique within the tag namespace and cannot be changed."
  default     = ""
}

variable "identity_tag_description" {
  description = "(Required) (Updatable) The description you assign to the tag during creation."
  default     = null
}

variable "identity_tag_tag_namespace_id" {
  description = "(Required) The OCID of the tag namespace."
  default     = ""
}

variable "identity_tag_is_cost_tracking" {
  description = "(Optional) (Updatable) Indicates whether the tag is enabled for cost tracking."
  default     = null
}

variable "identity_tag_is_retired" {
  description = "(Optional) (Updatable) Indicates whether the tag is retired. See Retiring Key Definitions and Namespace Definitions."
  default     = null
}

variable "identity_tag_validator" {
  description = "(Optional) (Updatable) Validates a definedTag value. Each validator performs validation steps in addition to the standard validation for definedTag values. For more information, see Limits on Tags."
  default     = []
}

variable "identity_tag_defined_tags" {
  description = "(Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags"
  default     = {}
}

variable "identity_tag_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 15 minutes), when creating the Tag * update - (Defaults to 15 minutes), when updating the Tag * delete - (Defaults to 12 hours), when destroying the Tag"
  default     = {}
}

#-----------------------------------------------------------
# identity tag namespace
#-----------------------------------------------------------
variable "enable_identity_tag_namespace" {
  description = "Enable identity tag namespace usages"
  default     = false
}

variable "identity_tag_namespace_compartment_id" {
  description = "(Required) (Updatable) The OCID of the tenancy containing the tag namespace."
  default     = null
}

variable "identity_tag_namespace_name" {
  description = "The name you assign to the tag namespace during creation. It must be unique across all tag namespaces in the tenancy and cannot be changed."
  default     = ""
}

variable "identity_tag_namespace_description" {
  description = "(Required) (Updatable) The description you assign to the tag namespace during creation."
  default     = ""
}

variable "identity_tag_namespace_is_retired" {
  description = "(Optional) (Updatable) Whether the tag namespace is retired. For more information, see Retiring Key Definitions and Namespace Definitions."
  default     = null
}

variable "identity_tag_namespace_defined_tags" {
  description = "(Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags."
  default     = {}
}

variable "identity_tag_namespace_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Tag Namespace * update - (Defaults to 20 minutes), when updating the Tag Namespace * delete - (Defaults to 20 minutes), when destroying the Tag Namespace"
  default     = {}
}

#-----------------------------------------------------------
# identity tag default
#-----------------------------------------------------------
variable "enable_identity_tag_default" {
  description = "Enable identity tag default usages"
  default     = false
}

variable "identity_tag_default_compartment_id" {
  description = "(Required) The OCID of the compartment. The tag default will be applied to all new resources created in this compartment."
  default     = null
}

variable "identity_tag_default_tag_definition_id" {
  description = "Required) The OCID of the tag definition. The tag default will always assign a default value for this tag definition."
  default     = null
}

variable "identity_tag_default_value" {
  description = "(Required) (Updatable) The default value for the tag definition. This will be applied to all new resources created in the compartment."
  default     = null
}

variable "identity_tag_default_is_required" {
  description = "(Optional) (Updatable) If you specify that a value is required, a value is set during resource creation (either by the user creating the resource or another tag defualt). If no value is set, resource creation is blocked."
  default     = null
}

variable "identity_tag_default_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Tag Default * update - (Defaults to 20 minutes), when updating the Tag Default * delete - (Defaults to 20 minutes), when destroying the Tag Default"
  default     = {}
}

#-----------------------------------------------------------
# identity import standard tags management
#-----------------------------------------------------------
variable "enable_identity_import_standard_tags_management" {
  description = "Enable identity import standard tags management usages"
  default     = false
}

variable "identity_import_standard_tags_management_compartment_id" {
  description = "(Required) The OCID of the compartment where the bulk create request is submitted and where the tag namespaces will be created."
  default     = null
}

variable "identity_import_standard_tags_management_standard_tag_namespace_name" {
  description = "The name of standard tag namespace that will be imported in bulk"
  default     = ""
}

variable "identity_import_standard_tags_management_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Import Standard Tags Management * update - (Defaults to 20 minutes), when updating the Import Standard Tags Management * delete - (Defaults to 20 minutes), when destroying the Import Standard Tags Management"
  default     = {}
}