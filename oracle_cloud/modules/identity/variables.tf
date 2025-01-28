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

variable "compartment_id" {
  description = "(Required) (Updatable) The OCID of the compartment to"
  default     = null
}

variable "tags" {
  description = "Add additional tags"
  default     = {}
}

#-----------------------------------------------------------
# identity network source
#-----------------------------------------------------------
variable "enable_identity_network_source" {
  description = "Enable identity network source usages"
  default     = false
}

variable "identity_network_source_description" {
  description = "(Required) (Updatable) The description you assign to the network source during creation. Does not have to be unique, and it's changeable."
  default     = null
}

variable "identity_network_source_name" {
  description = "(Required) The name you assign to the network source during creation. The name must be unique across all groups in the tenancy and cannot be changed."
  default     = ""
}

variable "identity_network_source_public_source_list" {
  description = "(Optional) (Updatable) A list of allowed public IP addresses and CIDR ranges."
  default     = null
}

variable "identity_network_source_services" {
  description = "(Optional) (Updatable) A list of services allowed to make on-behalf-of requests. These requests can have different source IP addresses than those listed in the network source. Currently, only all and none are supported. The default is all."
  default     = null
}

# variable "identity_network_source_virtual_source_list" {
#   description = "(Optional) (Updatable) A list of allowed VCN OCID and IP range pairs."
#   default     = null
# }

variable "identity_network_source_defined_tags" {
  description = "(Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags."
  default     = {}
}

variable "identity_network_source_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Network Source * update - (Defaults to 20 minutes), when updating the Network Source * delete - (Defaults to 20 minutes), when destroying the Network Source"
  default     = {}
}

#-----------------------------------------------------------
# identity policy
#-----------------------------------------------------------
variable "enable_identity_policy" {
  description = "Enable identity policy usages"
  default     = false
}

variable "identity_policy_description" {
  description = "(Required) (Updatable) The description you assign to the policy during creation. Does not have to be unique, and it's changeable."
  default     = null
}

variable "identity_policy_name" {
  description = "The name you assign to the policy during creation. The name must be unique across all policies in the tenancy and cannot be changed."
  default     = ""
}

variable "identity_policy_statements" {
  description = "(Required) (Updatable) An array of policy statements written in the policy language. See How Policies Work and Common Policies."
  default     = null
}

variable "identity_policy_version_date" {
  description = "(Optional) (Updatable) The version of the policy. If null or set to an empty string, when a request comes in for authorization, the policy will be evaluated according to the current behavior of the services at that moment. If set to a particular date (YYYY-MM-DD), the policy will be evaluated according to the behavior of the services on that date."
  default     = null
}

variable "identity_policy_defined_tags" {
  description = "(Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags"
  default     = {}
}

variable "identity_policy_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Policy * update - (Defaults to 20 minutes), when updating the Policy * delete - (Defaults to 20 minutes), when destroying the Policy"
  default     = {}
}

#-----------------------------------------------------------
# identity identity provider
#-----------------------------------------------------------
variable "enable_identity_identity_provider" {
  description = "Enable identity identity provider usages"
  default     = false
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
  description = "The name you assign to the IdentityProvider during creation. The name must be unique across all IdentityProvider objects in the tenancy and cannot be changed."
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

variable "identity_identity_provider_defined_tags" {
  description = "(Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags"
  default     = null
}

variable "identity_identity_provider_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Identity Provider * update - (Defaults to 20 minutes), when updating the Identity Provider * delete - (Defaults to 20 minutes), when destroying the Identity Provider"
  default     = {}
}

#-----------------------------------------------------------
# identity authentication policy
#-----------------------------------------------------------
variable "enable_identity_authentication_policy" {
  description = "Enable identity authentication policy usage"
  default     = false
}

variable "identity_authentication_policy_network_policy" {
  description = "(Optional) (Updatable) Network policy, Consists of a list of Network Source ids."
  default     = {}
}

variable "identity_authentication_policy_password_policy" {
  description = "(Optional) (Updatable) Password policy, currently set for the given compartment."
  default     = {}
}

variable "identity_authentication_policy_timeouts" {
  description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Authentication Policy * update - (Defaults to 20 minutes), when updating the Authentication Policy * delete - (Defaults to 20 minutes), when destroying the Authentication Policy"
  default     = {}
}

#-----------------------------------------------------------
# identity compartment
#-----------------------------------------------------------
variable "enable_identity_compartment" {
  description = "Enable identity compartment usages"
  default     = false
}

variable "identity_compartment_description" {
  description = "(Required) (Updatable) The description you assign to the compartment during creation. Does not have to be unique, and it's changeable."
  default     = null
}

variable "identity_compartment_name" {
  description = "(Updatable) The name you assign to the compartment during creation. The name must be unique across all compartments in the parent compartment. Avoid entering confidential information."
  default     = ""
}

variable "identity_compartment_defined_tags" {
  description = "(Optional) (Updatable) Defined-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags."
  default     = {}
}

variable "identity_compartment_enable_delete" {
  description = "(Optional) Defaults to false. If omitted or set to false the provider will implicitly import the compartment if there is a name collision, and will not actually delete the compartment on destroy or removal of the resource declaration. If set to true, the provider will throw an error on a name collision with another compartment, and will attempt to delete the compartment on destroy or removal of the resource declaration."
  default     = null
}

# variable "identity_compartment_timeouts" {
#   description = "The timeouts block allows you to specify timeouts for certain operations: * create - (Defaults to 20 minutes), when creating the Compartment * update - (Defaults to 20 minutes), when updating the Compartment * delete - (Defaults to 90 minutes), when destroying the Compartment"
#   default     = {}
# }
