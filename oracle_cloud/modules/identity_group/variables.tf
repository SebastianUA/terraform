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
# identity dynamic group
#-----------------------------------------------------------
variable "enable_identity_dynamic_group" {
  description = "Enable identity dynamic group usages"
  default     = false
}

variable "identity_dynamic_group_compartment_id" {
  description = "(Required) The OCID of the tenancy containing the group."
  default     = null
}

variable "identity_dynamic_group_description" {
  description = "(Required) (Updatable) The description you assign to the group during creation. Does not have to be unique, and it's changeable."
  default     = null
}

variable "identity_dynamic_group_matching_rule" {
  description = "(Required) (Updatable) The matching rule to dynamically match an instance certificate to this dynamic group. For rule syntax, see Managing Dynamic Groups."
  default     = null
}

variable "identity_dynamic_group_name" {
  description = "The name you assign to the group during creation. The name must be unique across all groups in the tenancy and cannot be changed."
  default     = ""
}

variable "identity_dynamic_group_freeform_tags" {
  description = "(Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags."
  default     = {}
}

variable "identity_dynamic_group_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Dynamic Group * update - (Defaults to 20 minutes), when updating the Dynamic Group * delete - (Defaults to 20 minutes), when destroying the Dynamic Group"
  default     = {}
}

#-----------------------------------------------------------
# identity group
#-----------------------------------------------------------
variable "enable_identity_group" {
  description = "Enable identity group usages"
  default     = false
}

variable "identity_group_compartment_id" {
  description = "(Required) The OCID of the tenancy containing the group."
  default     = null
}

variable "identity_group_description" {
  description = "(Required) (Updatable) The description you assign to the group during creation. Does not have to be unique, and it's changeable."
  default     = null
}

variable "identity_group_name" {
  description = "The name you assign to the group during creation. The name must be unique across all groups in the tenancy and cannot be changed."
  default     = ""
}

variable "identity_group_freeform_tags" {
  description = "(Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags. "
  default     = {}
}

variable "identity_group_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Group * update - (Defaults to 20 minutes), when updating the Group * delete - (Defaults to 20 minutes), when destroying the Group"
  default     = {}
}

#-----------------------------------------------------------
# identity user group membership
#-----------------------------------------------------------
variable "enable_identity_user_group_membership" {
  description = "Enable identity user group membership usages"
  default     = false
}

variable "identity_user_group_membership_group_id" {
  description = "The OCID of the group."
  default     = ""
}

variable "identity_user_group_membership_user_id" {
  description = "(Required) The OCID of the user."
  default     = null
}

variable "identity_user_group_membership_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the User Group Membership * update - (Defaults to 20 minutes), when updating the User Group Membership * delete - (Defaults to 20 minutes), when destroying the User Group Membership"
  default     = {}
}

#-----------------------------------------------------------
# identity idp group mapping
#-----------------------------------------------------------
variable "enable_identity_idp_group_mapping" {
  description = "Enable identity idp group mapping usages"
  default     = false
}

variable "identity_idp_group_mapping_group_id" {
  description = "(Updatable) The OCID of the IAM Service group you want to map to the IdP group."
  default     = ""
}

variable "identity_idp_group_mapping_identity_provider_id" {
  description = "(Required) The OCID of the identity provider."
  default     = null
}

variable "identity_idp_group_mapping_idp_group_name" {
  description = "(Required) (Updatable) The name of the IdP group you want to map."
  default     = null
}

variable "identity_idp_group_mapping_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Idp Group Mapping * update - (Defaults to 20 minutes), when updating the Idp Group Mapping * delete - (Defaults to 20 minutes), when destroying the Idp Group Mapping"
  default     = {}
}

#-----------------------------------------------------------
# identity identity provider
#-----------------------------------------------------------
variable "enable_identity_identity_provider" {
  description = "Enable identity identity provider usages"
  default     = false
}

variable "identity_identity_provider_compartment_id" {
  description = "(Required) The OCID of your tenancy."
  default     = null
}

variable "identity_identity_provider_description" {
  description = "(Required) (Updatable) The description you assign to the IdentityProvider during creation. Does not have to be unique, and it's changeable."
  default     = null
}

variable "identity_identity_provider_metadata" {
  description = "(Required) (Updatable) The XML that contains the information required for federating."
  default     = null
}

variable "identity_identity_provider_metadata_url" {
  description = "(Required) (Updatable) The URL for retrieving the identity provider's metadata, which contains information required for federating."
  default     = null
}

variable "identity_identity_provider_name" {
  description = "(Required) The name you assign to the IdentityProvider during creation. The name must be unique across all IdentityProvider objects in the tenancy and cannot be changed."
  default     = ""
}

variable "identity_identity_provider_product_type" {
  description = "(Required) The identity provider service or product. Supported identity providers are Oracle Identity Cloud Service (IDCS) and Microsoft Active Directory Federation Services (ADFS). Example: IDCS"
  default     = null
}

variable "identity_identity_provider_protocol" {
  description = "(Required) (Updatable) The protocol used for federation. Example: SAML2"
  default     = null
}

variable "identity_identity_provider_freeform_attributes" {
  description = "(Optional) (Updatable) Extra name value pairs associated with this identity provider."
  default     = null
}

variable "identity_identity_provider_freeform_tags" {
  description = "(Optional) (Updatable) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags."
  default     = {}
}

variable "identity_identity_provider_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Identity Provider * update - (Defaults to 20 minutes), when updating the Identity Provider * delete - (Defaults to 20 minutes), when destroying the Identity Provider"
  default     = {}
}
